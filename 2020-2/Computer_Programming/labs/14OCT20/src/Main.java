import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class Main {
    private static Queue<Work> workQueue;
    private static List<Worker> workers;

    public static void main(String[] args) {
        prepareWorks(10);
        prepareWorkers(1, 3);

        Scheduler<Worker> scheduler = new Scheduler<>();
        while(!(workQueue.isEmpty())){
            Worker worker = scheduler.schedule(workers);
            worker.run();
            Scheduler.delay();
        }
    }

    private static void prepareWorks(int numWorks) {
        workQueue = new LinkedList<>();
        for(int i = 0; i < numWorks; i++){
            workQueue.add(new Work());
        }
    }

    private static void prepareWorkers(int numProducers, int numConsumers) {
        workers = new LinkedList<>();
        for (int i = 0; i < numProducers; i++) {
            workers.add(new Producer(workQueue));
        }
        for (int i = 0; i < numConsumers; i++) {
            workers.add(new Consumer(workQueue));
        }
    }
}
