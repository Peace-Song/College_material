package evolution.of.truth.agent;

import evolution.of.truth.match.Match;
import kiroong.Individual;

public class Angel extends Agent {

    public Angel() {
        super("Angel");
    }

    @Override
    public Individual clone() {
        return new Angel();
    }

    @Override
    public int choice(int previousOpponentChoice) {
        return Match.COOPERATE;
    }
}
