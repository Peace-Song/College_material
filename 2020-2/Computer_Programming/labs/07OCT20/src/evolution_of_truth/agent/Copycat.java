package evolution_of_truth.agent;

import evolution_of_truth.match.Match;
import kiroong.Individual;

public class Copycat extends Agent {
    public Copycat() {
        super("Copycat");
    }

    @Override
    public int choice(int prevOpponentChoice) {
        if (prevOpponentChoice == Match.UNDEFINED) {
            return Match.COOPERATE;
        } else {
            return prevOpponentChoice;
        }
    }

    @Override
    public Individual clone() {
        return new Copycat();
    }
}
