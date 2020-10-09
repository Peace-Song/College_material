package evolution.of.truth.agent;

import kiroong.Individual;

abstract public class Agent extends Individual {
    private int score;
    private String name;

    protected Agent(String name) {
        score = 0;
        this.name = name;
    }

    public int sortKey() {
        return getScore();
    }

    @Override
    public String toString() {
        return name + ": " + getScore();
    }

    public int getScore() {
        return score;
    }

    public void setScore(int newScore) {
        score = newScore;
    }

    abstract public int choice(int previousOpponentChoice);
}
