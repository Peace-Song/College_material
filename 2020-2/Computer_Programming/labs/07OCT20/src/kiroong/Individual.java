package kiroong;

abstract public class Individual {
    private static int idCount = 0;

    int id;

    protected Individual() {
        id = idCount++;
    }

    abstract public int sortKey();
    abstract public Individual clone();
}