package io.vertx.core.net.impl.pool;

import io.netty.util.concurrent.FastThreadLocal;
import io.netty.util.internal.PlatformDependent;
import java.util.Queue;
import java.util.concurrent.atomic.AtomicInteger;

protected static final class InProgressTail {
  Task task;
}

private final FastThreadLocal<InProgressTail> current = new FastThreadLocal<>();

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
      InProgressTail inProgress = current.get();
      if (inProgress == null) {
        inProgress = new InProgressTail();
        current.set(inProgress);
        inProgress.task = tail;
        try {
          head.runNextTasks();
        } finally {
          current.remove();
        }
      } else {
        assert inProgress.task != null;
        Task oldNextTail = inProgress.task.replaceNext(head);
        assert oldNextTail == null;
        inProgress.task = tail;
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
    ConnectionPool<Connection> pool = ConnectionPool.pool(new PoolConnector<Connection>() {
      int count = 0;
      int reentrancy = 0;
      @Override
      public void connect(ContextInternal context, Listener listener, Handler<AsyncResult<ConnectResult<Connection>>> handler) {
        assertEquals(0, reentrancy++);
        try {
          int val = count++;
          if (val == 0) {
            for (int i = 0;i < numAcquires;i++) {
              int num = seq.getAndIncrement();
              ref.get().acquire(ctx, 0, onFailure(err -> {
                res.add(num);
                latch.countDown();
              }));
            }
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
    List<Integer> expected = IntStream.range(0, numAcquires + 1).boxed().collect(Collectors.toList());
    assertEquals(expected, res);
  }



package io.vertx.core.net.impl.pool;
import io.vertx.test.core.AsyncTestBase;
import org.junit.Test;
import java.lang.management.ManagementFactory;
import java.lang.management.ThreadMXBean;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;





@Test
public void testFoo() throws Exception {


  int numThreads = 8;
  int numIter = 1_000 * 100;
  Executor<Object> sync = new CombinerExecutor<>(new Object());
  Executor.Action action = s -> {
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

