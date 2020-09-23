package Platform.Games;

import Platform.Games.Dice;

public class TestDice {
    public static void main(String[] args){
        Dice dice = new Dice();
        int sum = 0;
        int total = 100;
        for(int i = 0; i < total; i++){
            int status = dice.playGame();
            if(status == 1)
                sum += 1;
        }
        System.out.println("WinRate " + (sum / (float)total));
    }
}
