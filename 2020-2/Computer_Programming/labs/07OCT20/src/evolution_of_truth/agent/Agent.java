package evolution_of_truth.agent;

import kiroong.Individual;

abstract public class Agent extends Individual {
    private int score;
    private String name;

    protected Agent(String name) {
        this.score = 0;
        this.name = name;
    }

    public int sortKey() {
        return getScore();
    }

    @Override
    public String toString() {
        return this.name + ": " + getScore();
    }

    public int getScore() {
        return this.score;
    }

    public void setScore(int newScore) {
        this.score = newScore;
    }

    abstract public int choice(int prevOpponentChoice);
}
