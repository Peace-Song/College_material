package Platform;

import Platform.Platform;

public class Test {
    public static void main(String[] args){
        System.out.println("Choose 0 for Dice, 1 for RockPaperScissors");
        Platform platform = new Platform();
        platform.setRounds(6);
        float winrate = platform.run();
        System.out.println(winrate);
    }
}
