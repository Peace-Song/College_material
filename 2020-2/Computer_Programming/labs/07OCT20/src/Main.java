import evolution_of_truth.agent.*;
import evolution_of_truth.match.Match;
import evolution_of_truth.env.Tournament;

public class Main {
    public static void main(String[] args) {
        Tournament tournament = new Tournament();
        for (int __ = 0; __ < 10; __++) {
            tournament.resetAgents();
            tournament.playAllGames(10);
            tournament.describe();
            tournament.evolvePopulation();
        }
    }
}
