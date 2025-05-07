impl Memory {
		pub fn new(limit: usize) -> Self {
		Self {
			data: Vec::new(),
			effective_len: U256::zero(),
			limit,
		}
	}

		pub fn limit(&self) -> usize {
		self.limit
	}

		pub fn len(&self) -> usize {
		self.data.len()
	}

		pub fn effective_len(&self) -> U256 {
		self.effective_len
	}

		pub fn is_empty(&self) -> bool {
		self.len() == 0
	}

		pub fn data(&self) -> &Vec<u8> {
		&self.data
	}

		pub fn resize_offset(&mut self, offset: U256, len: U256) -> Result<(), ExitError> {
		if len == U256::zero() {
			return Ok(())
		}

		if let Some(end) = offset.checked_add(len) {
			self.resize_end(end)
		} else {
			Err(ExitError::InvalidRange)
		}
	}

		pub fn resize_end(&mut self, mut end: U256) -> Result<(), ExitError> {
		while end % U256::from(32) != U256::zero() {
			end = match end.checked_add(U256::one()) {
				Some(end) => end,
				None => return Err(ExitError::InvalidRange)
			};
		}

		self.effective_len = max(self.effective_len, end);
		Ok(())
	}

		pub fn get(&self, offset: usize, size: usize) -> Vec<u8> {
		let mut ret = Vec::new();
		ret.resize(size, 0);

		for index in 0..size {
			let position = offset + index;
			if position >= self.data.len() {
				break
			}

			ret[index] = self.data[position];
		}

		ret
	}

		pub fn set(
		&mut self,
		offset: usize,
		value: &[u8],
		target_size: Option<usize>
	) -> Result<(), ExitFatal> {
		let target_size = target_size.unwrap_or(value.len());

		if offset.checked_add(target_size)
			.map(|pos| pos > self.limit).unwrap_or(true)
		{
			return Err(ExitFatal::NotSupported)
		}

		if self.data.len() < offset + target_size {
			self.data.resize(offset + target_size, 0);
		}

		for index in 0..target_size {
			if self.data.len() > offset + index && value.len() > index {
				self.data[offset + index] = value[index];
			} else {
				self.data[offset + index] = 0;
			}
		}

		Ok(())
	}

		pub fn copy_large(
		&mut self,
		memory_offset: U256,
		data_offset: U256,
		len: U256,
		data: &[u8]
	) -> Result<(), ExitFatal> {
		let memory_offset = if memory_offset > U256::from(usize::max_value()) {
			return Err(ExitFatal::NotSupported)
		} else {
			memory_offset.as_usize()
		};

		let ulen = if len > U256::from(usize::max_value()) {
			return Err(ExitFatal::NotSupported)
		} else {
			len.as_usize()
		};

		let data = if let Some(end) = data_offset.checked_add(len) {
			if end > U256::from(usize::max_value()) {
				&[]
			} else {
				let data_offset = data_offset.as_usize();
				let end = end.as_usize();

				if data_offset > data.len() {
					&[]
				} else {
					&data[data_offset..min(end, data.len())]
				}
			}
		} else {
			&[]
		};

		self.set(memory_offset, data, Some(ulen))
	}
}
