package io.vertx.core.net.impl.pool;

import io.netty.util.concurrent.FastThreadLocal;
import io.netty.util.internal.PlatformDependent;
import java.util.HashMap;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.atomic.AtomicInteger;

protected static final class InProgressTail<S> {

  final CombinerExecutor<S> combiner;
  Task task;
  Map<CombinerExecutor<S>, Task> others;

  public InProgressTail(CombinerExecutor<S> combiner, Task task) {
    this.combiner = combiner;
    this.task = task;
  }
}

private static final FastThreadLocal<InProgressTail<?>> current = new FastThreadLocal<>();

@Override
public void submit(Action<S> action) {
  q.add(action);
  if (s.get() != 0 || !s.compareAndSet(0, 1)) {
    return;
  }
  Task head = null;
  Task tail = null;
  do {
    try {
      for (; ; ) {
        final Action<S> a = q.poll();
        if (a == null) {
          break;
        }
        final Task task = a.execute(state);
        if (task != null) {
          Task last = task.last();
          if (head == null) {
            assert tail == null;
            tail = last;
            head = task;
          } else {
            tail.next(task);
            tail = last;
          }
        }
      }
    } finally {
      s.set(0);
    }
  } while (!q.isEmpty() && s.compareAndSet(0, 1));
  if (head != null) {
    InProgressTail<S> inProgress = (InProgressTail<S>) current.get();
    if (inProgress == null) {
      inProgress = new InProgressTail<>(this, tail);
      current.set(inProgress);
      try {
        head.runNextTasks();
        assert inProgress.others == null || inProgress.others.isEmpty();
      } finally {
        current.remove();
      }
    } else {
      if (inProgress.combiner == this) {
        Task oldNextTail = inProgress.task.replaceNext(head);
        assert oldNextTail == null;
        inProgress.task = tail;
      } else {
        Map<CombinerExecutor<S>, Task> map = inProgress.others;
        if (map == null) {
          map = inProgress.others = new HashMap<>(1);
        }
        Task task = map.get(this);
        if (task == null) {
          map.put(this, tail);
          try {
            head.runNextTasks();
          } finally {
            map.remove(this);
          }
        } else {
          Task oldNextTail = task.replaceNext(head);
          assert oldNextTail == null;
          map.put(this, tail);
        }
      }
    }
  }
}

@Test
  public void testPostTasksTrampoline() throws Exception {
    int numAcquires = 5;
    AtomicReference<ConnectionPool<Connection>> ref = new AtomicReference<>();
    ContextInternal ctx = vertx.createEventLoopContext();
    List<Integer> res = Collections.synchronizedList(new LinkedList<>());
    AtomicInteger seq = new AtomicInteger();
    CountDownLatch latch = new CountDownLatch(numAcquires);
    int[] count = new int[1];
    ConnectionPool<Connection> pool = ConnectionPool.pool(new PoolConnector<Connection>() {
      int reentrancy = 0;
      @Override
      public void connect(ContextInternal context, Listener listener, Handler<AsyncResult<ConnectResult<Connection>>> handler) {
        assertEquals(0, reentrancy++);
        try {
          int val = count[0]++;
          if (val == 0) {
            // Queue extra requests
            for (int i = 0;i < numAcquires;i++) {
              int num = seq.getAndIncrement();
              ref.get().acquire(ctx, 0, onFailure(err -> {
                res.add(num);
                latch.countDown();
              }));
            }
            assertEquals(1, count[0]);
          }
          handler.handle(Future.failedFuture("failure"));
        } finally {
          reentrancy--;
        }
      }
      @Override
      public boolean isValid(Connection connection) {
        return true;
      }
    }, new int[]{1}, 1 + numAcquires);
    ref.set(pool);
    int num = seq.getAndIncrement();
    pool.acquire(ctx, 0, onFailure(err -> res.add(num)));
    awaitLatch(latch);
    assertEquals(1 + numAcquires, count[0]);
    List<Integer> expected = IntStream.range(0, numAcquires + 1).boxed().collect(Collectors.toList());
    assertEquals(expected, res);
  }

  @Test
  public void testConcurrentPostTasksTrampoline() throws Exception {
    AtomicReference<ConnectionPool<Connection>> ref1 = new AtomicReference<>();
    AtomicReference<ConnectionPool<Connection>> ref2 = new AtomicReference<>();
    ContextInternal ctx = vertx.createEventLoopContext();
    List<Integer> res = Collections.synchronizedList(new LinkedList<>());
    CountDownLatch latch = new CountDownLatch(4);
    ConnectionPool<Connection> pool1 = ConnectionPool.pool(new PoolConnector<Connection>() {
      int count = 0;
      int reentrancy = 0;
      @Override
      public void connect(ContextInternal context, Listener listener, Handler<AsyncResult<ConnectResult<Connection>>> handler) {
        assertEquals(0, reentrancy++);
        try {
          int val = count++;
          if (val == 0) {
            ref1.get().acquire(ctx, 0, onFailure(err -> {
              res.add(1);
              latch.countDown();
            }));
            ref2.get().acquire(ctx, 0, onFailure(err -> {
              res.add(2);
              latch.countDown();
            }));
          }
          handler.handle(Future.failedFuture("failure"));
        } finally {
          reentrancy--;
        }
      }
      @Override
      public boolean isValid(Connection connection) {
        return true;
      }
    }, new int[]{1}, 2);
    ConnectionPool<Connection> pool2 = ConnectionPool.pool(new PoolConnector<Connection>() {
      int count = 0;
      int reentrancy = 0;
      @Override
      public void connect(ContextInternal context, Listener listener, Handler<AsyncResult<ConnectResult<Connection>>> handler) {
        assertEquals(0, reentrancy++);
        try {
          int val = count++;
          if (val == 0) {
            ref2.get().acquire(ctx, 0, onFailure(err -> {
              res.add(3);
              latch.countDown();
            }));
            ref1.get().acquire(ctx, 0, onFailure(err -> {
              res.add(4);
              latch.countDown();
            }));
          }
          handler.handle(Future.failedFuture("failure"));
        } finally {
          reentrancy--;
        }
      }
      @Override
      public boolean isValid(Connection connection) {
        return true;
      }
    }, new int[]{1}, 2);
    ref1.set(pool1);
    ref2.set(pool2);
    pool1.acquire(ctx, 0, onFailure(err -> res.add(0)));
    awaitLatch(latch);
  }

  import io.netty.util.concurrent.FastThreadLocal;
  import io.vertx.test.core.AsyncTestBase;
  import org.junit.Test;
  import java.lang.management.ManagementFactory;
  import java.lang.management.ThreadMXBean;
  import java.util.Arrays;
  import java.util.LinkedList;
  import java.util.List;
  import java.util.concurrent.CountDownLatch;
  import java.util.concurrent.ThreadLocalRandom;
  import java.util.concurrent.atomic.AtomicBoolean;
  import java.util.concurrent.atomic.AtomicInteger;

@Test
public void testActionReentrancy2() throws Exception {
  List<Integer> log = new LinkedList<>();
  Executor<Object> combiner1 = new CombinerExecutor<>(new Object());
  Executor<Object> combiner2 = new CombinerExecutor<>(new Object());
  int[] reentrancy = new int[2];
  combiner1.submit(state1 -> taskOf(() -> {
    assertEquals(0, reentrancy[0]++);
    combiner1.submit(state2 -> taskOf(() -> {
      assertEquals(0, reentrancy[0]++);
      log.add(0);
      reentrancy[0]--;
    }));
    combiner2.submit(state2 -> taskOf(() -> {
      assertEquals(0, reentrancy[1]++);
      log.add(1);
      combiner1.submit(state3 -> taskOf(() -> {
        assertEquals(0, reentrancy[0]++);
        log.add(2);
        reentrancy[0]--;
      }));
      combiner2.submit(state3 -> taskOf(() -> {
        assertEquals(0, reentrancy[1]++);
        log.add(3);
        reentrancy[1]--;
      }));
      reentrancy[1]--;
    }));
    reentrancy[0]--;
  }));
  assertEquals(0, reentrancy[0]);
  assertEquals(0, reentrancy[1]);
  assertEquals(Arrays.asList(1, 3, 0, 2), log);
}

static Task taskOf(Runnable runnable) {
  return new Task() {
    @Override
    public void run() {
      runnable.run();
    }
  };
}

@Test
public void testFoo() throws Exception {
  int numThreads = 8;
  int numIter = 1_000 * 100;
  Executor<Object> sync = new CombinerExecutor<>(new Object());
  Executor.Action<Object> action = s -> {
    burnCPU(10);
    return null;
  };
  Thread[] threads = new Thread[numThreads];
  for (int i = 0;i < numThreads;i++) {
    threads[i] = new Thread(() -> {
      for (int j = 0;j < numIter;j++) {
        if (j % 1_000 == 0) {
          System.out.println("Thread " + Thread.currentThread() + " " + j / 1_000);
        }
        sync.submit(action);
      }
    });
  }
  for (Thread t : threads) {
    t.start();
  }
  for (Thread t : threads) {
    t.join();
  }
}

@Test
public void testFastThreadLocalStability() {
  CombinerExecutor<Void> executor = new CombinerExecutor<>(null);
  int expected = io.netty.util.internal.InternalThreadLocalMap.lastVariableIndex();
  AtomicInteger counter = new AtomicInteger();
  for (int i = 0;i < 1000;i++) {
    executor = new CombinerExecutor<>(null);
    executor.submit(state -> new Task() {
      @Override
      public void run() {
        counter.incrementAndGet();
      }
    });
    assertEquals(i + 1, counter.get());
  }
  assertEquals(expected, io.netty.util.internal.InternalThreadLocalMap.lastVariableIndex());
}