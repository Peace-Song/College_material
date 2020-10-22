import java.util.List;

public class Scheduler<T> {
    private static final int waitms = 400;

    T schedule(List<T> workers) {
        return workers.get((int)(Math.random() * workers.size()));
    }

    static void delay() {
        try {
            Thread.sleep(waitms);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
