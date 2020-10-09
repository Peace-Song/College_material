package evolution_of_truth.agent;

import evolution_of_truth.match.Match;
import kiroong.Individual;

public class Copykitten extends Agent {
    int prevPrevOpponentChoice;

    public Copykitten() {
        super("Copykitten");
        this.prevPrevOpponentChoice = Match.UNDEFINED;
    }

    @Override
    public int choice(int prevOpponentChoice) {
        if (prevOpponentChoice == Match.UNDEFINED) {
            return Match.COOPERATE;
        }
        
        if (this.prevPrevOpponentChoice != Match.CHEAT) {
            if (prevOpponentChoice == Match.CHEAT) {
                this.prevPrevOpponentChoice = prevOpponentChoice;
            }
            return Match.COOPERATE;
        } else {
            if (prevOpponentChoice == Match.COOPERATE) {
                this.prevPrevOpponentChoice = prevOpponentChoice;
            }
            return prevOpponentChoice;
        }
    
    }

    @Override
    public Individual clone() {
        return new Copykitten();
    }

    public String meow() {
        return "meow";
    }
}
