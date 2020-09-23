package Platform.Games;

import java.util.Scanner;

public class RockPaperScissors {
    Scanner scanner;
    private final String ROCK = "rock";
    private final String SCISSOR = "scissor";
    private final String PAPER = "paper";
    
    public RockPaperScissors() {
        this.scanner = new Scanner(System.in);
    }

    public int playGame() {
        String userChoice = scanner.nextLine();
        String opponentchoice = getOpponentChoice();
        
        if (!isValidChoice(userChoice)) return -1;

        System.out.printf("%s %s\n", userChoice, opponentchoice);

        if (userChoice.equals(opponentchoice)) return 0;

        if (userChoice.equals(ROCK)) return opponentchoice.equals(SCISSOR) ? 1 : -1;
        if (userChoice.equals(SCISSOR)) return opponentchoice.equals(PAPER) ? 1 : -1;
        if (userChoice.equals(PAPER)) return opponentchoice.equals(ROCK) ? 1 : -1;

        // never reaches here
        return -1;
    }

    private String getOpponentChoice() {
        int rand = (int)(Math.random() * 100);

        if (rand < 33) return ROCK;
        else if (rand < 66) return SCISSOR;
        else return PAPER;
    }

    private boolean isValidChoice(String choice) {
        if (choice.equals(ROCK) || choice.equals(SCISSOR) || choice.equals(PAPER))
            return true;
        else
            return false;
    }
}
