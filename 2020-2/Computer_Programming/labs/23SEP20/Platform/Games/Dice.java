package Platform.Games;

public class Dice {
    public int playGame() {
        int userDice = this.roll();
        int opponentDice = this.roll();

        System.out.printf("%d %d\n", userDice, opponentDice);

        if (userDice > opponentDice) return 1;
        else if (userDice < opponentDice) return -1;
        else return 0;
    }

    private int roll() {
        return (int)(Math.random() * 100);
    }
}
