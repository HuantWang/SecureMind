impl Event {
    pub(super) fn new(token: Token) -> Event {
        Event {
            flags: 0,
            data: usize::from(token) as u64,
        }
    }

    pub(super) fn set_readable(&mut self) {
        self.flags |= afd::POLL_RECEIVE
    }

    #[cfg(feature = "os-ext")]
    pub(super) fn set_writable(&mut self) {
        self.flags |= afd::POLL_SEND;
    }

    pub(super) fn from_completion_status(status: &CompletionStatus) -> Event {
        Event {
            flags: status.bytes_transferred(),
            data: status.token() as u64,
        }
    }

    pub(super) fn to_completion_status(&self) -> CompletionStatus {
        CompletionStatus::new(self.flags, self.data as usize, std::ptr::null_mut())
    }
}

struct Inner {
    
    connect: Overlapped,
    read: Overlapped,
    write: Overlapped,
   
    handle: Handle,
    connecting: AtomicBool,
    io: Mutex<Io>,
    pool: Mutex<BufferPool>,
}

impl Inner {
    unsafe fn ptr_from_conn_overlapped(ptr: *mut OVERLAPPED) -> *const Inner {

        ptr.cast()
    }

    
    unsafe fn ptr_from_read_overlapped(ptr: *mut OVERLAPPED) -> *const Inner {

        (ptr as *mut Overlapped).wrapping_sub(1) as *const Inner
    }

    unsafe fn ptr_from_write_overlapped(ptr: *mut OVERLAPPED) -> *const Inner {
        (ptr as *mut Overlapped).wrapping_sub(2) as *const Inner
    }

    pub unsafe fn connect_overlapped(&self, overlapped: *mut OVERLAPPED) -> io::Result<bool> {
        if ConnectNamedPipe(self.handle.raw(), overlapped) != 0 {
            return Ok(true);
        }

        let err = io::Error::last_os_error();

        match err.raw_os_error().map(|e| e as u32) {
            Some(ERROR_PIPE_CONNECTED) => Ok(true),
            Some(ERROR_NO_DATA) => Ok(true),
            Some(ERROR_IO_PENDING) => Ok(false),
            _ => Err(err),
        }
    }

    pub fn disconnect(&self) -> io::Result<()> {
        if unsafe { DisconnectNamedPipe(self.handle.raw()) } == 0 {
            Err(io::Error::last_os_error())
        } else {
            Ok(())
        }
    }

    pub unsafe fn read_overlapped(
        &self,
        buf: &mut [u8],
        overlapped: *mut OVERLAPPED,
    ) -> io::Result<Option<usize>> {
        let len = std::cmp::min(buf.len(), u32::MAX as usize) as u32;
        let res = ReadFile(
            self.handle.raw(),
            buf.as_mut_ptr() as *mut _,
            len,
            std::ptr::null_mut(),
            overlapped,
        );
        if res == 0 {
            let err = io::Error::last_os_error();
            if err.raw_os_error() != Some(ERROR_IO_PENDING as i32) {
                return Err(err);
            }
        }

        let mut bytes = 0;
        let res = GetOverlappedResult(self.handle.raw(), overlapped, &mut bytes, 0);
        if res == 0 {
            let err = io::Error::last_os_error();
            if err.raw_os_error() == Some(ERROR_IO_INCOMPLETE as i32) {
                Ok(None)
            } else {
                Err(err)
            }
        } else {
            Ok(Some(bytes as usize))
        }
    }

    pub unsafe fn write_overlapped(
        &self,
        buf: &[u8],
        overlapped: *mut OVERLAPPED,
    ) -> io::Result<Option<usize>> {
        let len = std::cmp::min(buf.len(), u32::MAX as usize) as u32;
        let res = WriteFile(
            self.handle.raw(),
            buf.as_ptr() as *const _,
            len,
            std::ptr::null_mut(),
            overlapped,
        );
        if res == 0 {
            let err = io::Error::last_os_error();
            if err.raw_os_error() != Some(ERROR_IO_PENDING as i32) {
                return Err(err);
            }
        }

        let mut bytes = 0;
        let res = GetOverlappedResult(self.handle.raw(), overlapped, &mut bytes, 0);
        if res == 0 {
            let err = io::Error::last_os_error();
            if err.raw_os_error() == Some(ERROR_IO_INCOMPLETE as i32) {
                Ok(None)
            } else {
                Err(err)
            }
        } else {
            Ok(Some(bytes as usize))
        }
    }

    #[inline]
    unsafe fn result(&self, overlapped: *mut OVERLAPPED) -> io::Result<usize> {
        let mut transferred = 0;
        let r = GetOverlappedResult(self.handle.raw(), overlapped, &mut transferred, 0);
        if r == 0 {
            Err(io::Error::last_os_error())
        } else {
            Ok(transferred as usize)
        }
    }
}

impl FromRawHandle for NamedPipe {
    unsafe fn from_raw_handle(handle: RawHandle) -> NamedPipe {
        NamedPipe {
            inner: Arc::new(Inner {
                handle: Handle::new(handle as HANDLE),
                connect: Overlapped::new(connect_done),
                connecting: AtomicBool::new(false),
                read: Overlapped::new(read_done),
                write: Overlapped::new(write_done),
                io: Mutex::new(Io {
                    cp: None,
                    token: None,
                    read: State::None,
                    write: State::None,
                    connect_error: None,
                }),
                pool: Mutex::new(BufferPool::with_capacity(2)),
            }),
        }
    }
}

fn schedule_read(me: &Arc<Inner>, io: &mut Io, events: Option<&mut Vec<Event>>) -> bool {
    match io.read {
        State::None => {}
        _ => return true,
    }

    let mut buf = me.get_buffer();
    let e = unsafe {
        let overlapped = me.read.as_ptr() as *mut _;
        let slice = slice::from_raw_parts_mut(buf.as_mut_ptr(), buf.capacity());
        me.read_overlapped(slice, overlapped)
    };

    match e {
        Ok(_) => {
            io.read = State::Pending(buf, 0);
            mem::forget(me.clone());
            true
        }

        Err(ref e) if e.raw_os_error() == Some(ERROR_PIPE_LISTENING as i32) => false,

        Err(e) => {
            io.read = State::Err(e);
            io.notify_readable(events);
            true
        }
    }
}

fn schedule_write(
    me: &Arc<Inner>,
    buf: Vec<u8>,
    pos: usize,
    io: &mut Io,
    events: Option<&mut Vec<Event>>,
) {
    match Inner::maybe_schedule_write(me, buf, pos, io) {
        Ok(Some(_)) => {
            let state = mem::replace(&mut io.write, State::None);
            io.write = match state {
                State::Ok(buf, pos) => State::Pending(buf, pos),
                _ => unreachable!(),
            };
            mem::forget(me.clone());
        }
        Ok(None) => (),
        Err(e) => {
            io.write = State::Err(e);
            io.notify_writable(events);
        }
    }
}

fn post_register(me: &Arc<Inner>, mut events: Option<&mut Vec<Event>>) {
    let mut io = me.io.lock().unwrap();
    #[allow(clippy::needless_option_as_deref)]
    if Inner::schedule_read(me, &mut io, events.as_deref_mut()) {
        if let State::None = io.write {
            io.notify_writable(events);
        }
    }
}

fn read_done(status: &OVERLAPPED_ENTRY, events: Option<&mut Vec<Event>>) {
    let status = CompletionStatus::from_entry(status);

    let me = unsafe { Arc::from_raw(Inner::ptr_from_read_overlapped(status.overlapped())) };

    let mut io = me.io.lock().unwrap();
    let mut buf = match mem::replace(&mut io.read, State::None) {
        State::Pending(buf, _) => buf,
        _ => unreachable!(),
    };
    unsafe {
        match me.result(status.overlapped()) {
            Ok(n) => {
                debug_assert_eq!(status.bytes_transferred() as usize, n);
                buf.set_len(status.bytes_transferred() as usize);
                io.read = State::Ok(buf, 0);
            }
            Err(e) => {
                debug_assert_eq!(status.bytes_transferred(), 0);
                io.read = State::Err(e);
            }
        }
    }

    io.notify_readable(events);
}

fn write_done(status: &OVERLAPPED_ENTRY, events: Option<&mut Vec<Event>>) {
    let status = CompletionStatus::from_entry(status);

    let me = unsafe { Arc::from_raw(Inner::ptr_from_write_overlapped(status.overlapped())) };

    let mut io = me.io.lock().unwrap();
    let (buf, pos) = match mem::replace(&mut io.write, State::None) {
        
        State::Ok(..) => {
            io.notify_writable(events);
            return;
        }
        State::Pending(buf, pos) => (buf, pos),
        _ => unreachable!(),
    };

    unsafe {
        match me.result(status.overlapped()) {
            Ok(n) => {
                debug_assert_eq!(status.bytes_transferred() as usize, n);
                let new_pos = pos + (status.bytes_transferred() as usize);
                if new_pos == buf.len() {
                    me.put_buffer(buf);
                    io.notify_writable(events);
                } else {
                    Inner::schedule_write(&me, buf, new_pos, &mut io, events);
                }
            }
            Err(e) => {
                debug_assert_eq!(status.bytes_transferred(), 0);
                io.write = State::Err(e);
                io.notify_writable(events);
            }
        }
    }
}



fn notify_readable(&self, events: Option<&mut Vec<Event>>) {
    if let Some(token) = self.token {
        let mut ev = Event::new(token);
        ev.set_readable();

        if let Some(events) = events {
            events.push(ev);
        } else {
            let _ = self.cp.as_ref().unwrap().post(ev.to_completion_status());
        }
    }
}

fn notify_writable(&self, events: Option<&mut Vec<Event>>) {
    if let Some(token) = self.token {
        let mut ev = Event::new(token);
        ev.set_writable();

        if let Some(events) = events {
            events.push(ev);
        } else {
            let _ = self.cp.as_ref().unwrap().post(ev.to_completion_status());
        }
    }
}
