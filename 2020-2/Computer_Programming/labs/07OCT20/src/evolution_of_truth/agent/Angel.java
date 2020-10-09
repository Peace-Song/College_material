package evolution_of_truth.agent;

import evolution_of_truth.match.Match;
import kiroong.Individual;

public class Angel extends Agent{
    public Angel() {
        super("Angel");
    }

    @Override
    public int choice(int prevOpponentChoice) {
        return Match.COOPERATE;
    }

    @Override
    public Individual clone() {
        return new Angel();
    }
}
