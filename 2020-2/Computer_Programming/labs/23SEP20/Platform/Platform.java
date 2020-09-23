package Platform;

import java.util.Scanner;
import Platform.Games.Dice;
import Platform.Games.RockPaperScissors;

public class Platform {
    private Scanner scanner;
    private int numRounds;
    private Dice dice;
    private RockPaperScissors rps;

    Platform() {
        this.numRounds = 1;
        this.scanner = new Scanner(System.in);
        this.dice = new Dice();
        this.rps = new RockPaperScissors();
    }

    public float run() {
        int mode = this.scanner.nextInt();
        int winCount = 0;

        if (mode != 0 && mode != 1) {
            return 0.0f;
        }

        for (int round = 0; round < this.numRounds; round++) {
            switch (mode) {
                case 0:
                    if (this.dice.playGame() == 1) winCount++;
                    break;
                case 1:
                    if (this.rps.playGame() == 1) winCount ++;
                    break;
                default:
                    break;
            }
        }

        return (float)winCount / this.numRounds;
    }

    public void setRounds(int num) {
        if (this.numRounds != 1) return;

        this.numRounds = num;
    }
}
