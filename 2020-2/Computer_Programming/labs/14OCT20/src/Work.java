public class Work {
    private static int numWorks = 0;
    protected final int id;
    
    Work() {
        this.id = Work.numWorks++;
    }

    public int getId() { return this.id; }
}
