package evolution.of.truth.environment;

import evolution.of.truth.agent.Agent;
import evolution.of.truth.agent.Angel;
import evolution.of.truth.agent.Copycat;
import evolution.of.truth.agent.Devil;
import evolution.of.truth.match.Match;
import kiroong.Individual;
import kiroong.Population;

public class Tournament {
    Population agentPopulation;

    public Tournament() {
        agentPopulation = new Population();
        for (int i = 0; i < 15; i++) {
            agentPopulation.addIndividual(new Angel());
        }
        for (int i = 0; i < 5; i++) {
            agentPopulation.addIndividual(new Devil());
        }
        for (int i = 0; i < 5; i++) {
            agentPopulation.addIndividual(new Copycat());
        }
    }

    public void evolvePopulation() {
        agentPopulation.toNextGeneration(5);
    }

    public void resetAgents() {
        Individual[] agents = agentPopulation.getIndividuals();
        for(Individual _agent: agents) {
            Agent agent = (Agent)_agent;
            agent.setScore(0);
        }
    }

    private Match[] createAllMatches() {
        int n = agentPopulation.size();
        Individual[] agents = agentPopulation.getIndividuals();
        Match[] matches = new Match[n * (n - 1) / 2];
        int index = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                matches[index++] = new Match((Agent)agents[i], (Agent)agents[j]);
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
        Individual[] agents = agentPopulation.getIndividuals();
        for(Individual _agent: agents) {
            Agent agent = (Agent)_agent;
            System.out.print(agent.toString() + " / ");
        }
        System.out.println();
    }
}
