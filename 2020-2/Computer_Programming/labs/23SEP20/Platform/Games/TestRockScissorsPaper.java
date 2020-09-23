package Platform.Games;

import Platform.Games.RockPaperScissors;

public class TestRockScissorsPaper {

    public static void main(String[] args){
        RockPaperScissors rsp = new RockPaperScissors();
        int sum = 0;
        int total = 4;
        for(int i = 0; i < total; i++){
            int status = rsp.playGame();
            if(status == 1)
                sum += 1;
        }
        System.out.println("WinRate " + (sum / (float)total));
    }
}
