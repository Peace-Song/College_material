import java.util.Queue;

public abstract class Worker {
    private static int numWorkers = 0;
    protected final int id;
    Queue<Work> workQueue;

    public abstract void run();

    Worker(Queue<Work> workQueue) {
        this.id = Worker.numWorkers++;

        this.workQueue = workQueue;
    }

    void report(String msg){
        System.out.print("\b".repeat(300) +
                "[" + ">".repeat(workQueue.size()) + "] " + id + "-th Worker(" + getClass().getName() + ") " + msg);
    }
}

class Producer extends Worker {
    Producer(Queue<Work> workQueue) {
        super(workQueue);
    }

    public void run() {
        Work work = new Work();
        this.workQueue.add(work);
        this.report("produced work" + work.getId());
    }
}

class Consumer extends Worker {
    Consumer(Queue<Work> workQueue) {
        super(workQueue);
    }

    public void run() {
        if (Math.random() <= 1.0/3) {
            Work work = this.workQueue.poll();
            this.report("consumed work" + work.getId());
        } else {
            this.report("failed to consume work");
        }
    }
}
