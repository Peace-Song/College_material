package evolution_of_truth.env;

import evolution_of_truth.agent.*;
import evolution_of_truth.match.Match;
import kiroong.Individual;
import kiroong.Population;

public class Tournament {
    Population agentPopulation;
    
    public Tournament() {
        this.agentPopulation = new Population();

        for (int idx = 0; idx < 15; idx++) {
            this.agentPopulation.addIndividual(new Angel());
        }

        for (int idx = 15; idx < 20; idx++) {
            this.agentPopulation.addIndividual(new Devil());
        }

        for (int idx = 20; idx < 25; idx++) {
            this.agentPopulation.addIndividual(new Copykitten());
        }
    }

    private Match[] createAllMatches() {
        Individual[] agents = this.agentPopulation.getIndividuals();
        int len = this.agentPopulation.size();
        Match[] matches = new Match[len * (len-1) / 2];
        int idx = 0;

        for (int i = 0; i < len; i++) {
            for (int j = i + 1; j < len; j++) {
                matches[idx++] = new Match((Agent)agents[i], (Agent)agents[j]);
            }
        }
        
        return matches;
    }

    public void playAllGames(int numRounds) {
        Match[] matches = createAllMatches();

        for (int round = 0; round < numRounds; round++) {
            for (Match match : matches) {
                match.playGame();
            }
        }
    }

    public void describe() {
        Individual[] agents = this.agentPopulation.getIndividuals();

        for (Individual agent : agents) {
            System.out.print((Agent)agent + " / ");
        }

        System.out.println();
    }

    public void evolvePopulation() {
        this.agentPopulation.toNextGeneration(5);
    }

    public void resetAgents() {
        Individual[] agents = this.agentPopulation.getIndividuals();

        for (Individual agent : agents) {
            ((Agent)agent).setScore(0);
        }
    }
}