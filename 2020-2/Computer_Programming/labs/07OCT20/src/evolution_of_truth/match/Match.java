package evolution_of_truth.match;

import evolution_of_truth.agent.Agent;

public class Match {
    public static final int UNDEFINED = -1;
    public static final int CHEAT = 0;
    public static final int COOPERATE = 1;
    protected static int ruleMatrix[][][] = {
        {
            {0, 0}, // A cheats, B cheats
            {3, -1} // A cheats, B coops
        },
        {
            {-1, 3}, // A coops, B cheats
            {2,  2}  // A coops, B coops
        }
    };

    Agent agentA, agentB;
    int prevChoiceA, prevChoiceB;

    public Match(Agent agentA, Agent agentB) {
        this.agentA = agentA;
        this.agentB = agentB;
        this.prevChoiceA = Match.UNDEFINED;
        this.prevChoiceB = Match.UNDEFINED;
    }

    public void playGame() {
        int choiceA = this.agentA.choice(this.prevChoiceB);
        int choiceB = this.agentB.choice(this.prevChoiceA);

        this.agentA.setScore(this.agentA.getScore() + Match.ruleMatrix[choiceA][choiceB][0]);
        this.agentB.setScore(this.agentB.getScore() + Match.ruleMatrix[choiceA][choiceB][1]);
        this.prevChoiceA = choiceA;
        this.prevChoiceB = choiceB;
    }
}
