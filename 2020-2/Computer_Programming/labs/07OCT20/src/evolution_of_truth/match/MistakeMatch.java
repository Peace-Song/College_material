package evolution_of_truth.match;

import evolution_of_truth.agent.Agent;

public class MistakeMatch extends Match {
    public MistakeMatch(Agent agentA, Agent agentB) {
        super(agentA, agentB);
    }
    
    @Override
    public void playGame() {
        int choiceA = this.agentA.choice(this.prevChoiceB);
        int choiceB = this.agentB.choice(this.prevChoiceA);

        if (Math.random() < 0.05) choiceA = choiceA == Match.CHEAT ? Match.COOPERATE : Match.CHEAT;
        if (Math.random() < 0.05) choiceB = choiceB == Match.CHEAT ? Match.COOPERATE : Match.CHEAT;

        this.agentA.setScore(this.agentA.getScore() + Match.ruleMatrix[choiceA][choiceB][0]);
        this.agentB.setScore(this.agentB.getScore() + Match.ruleMatrix[choiceA][choiceB][1]);
        this.prevChoiceA = choiceA;
        this.prevChoiceB = choiceB;
    }
}
