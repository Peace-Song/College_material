package omok.src.common.game;

import omok.src.common.player.Player;
import omok.src.common.room.Room;
import omok.src.common.utils.listeners.BoardStatusListener;

public class Game implements BoardStatusListener {
    private static int gameNum = 0;
    private int gameId;
    private Room room;
    private Player[] players;
    private boolean[] outOfRangeFlag;
    private int turn;
    private int stoneXchgCount;
    private int waitCount;
    private Board board;


    public Game(Room room, Player[] players) {
        this.gameId = this.allocateGameId();
        this.room = room;
        this.players = players;
        this.outOfRangeFlag = new boolean[2];
        this.turn = 0;
        this.stoneXchgCount = 0;
        this.waitCount = 0;
        this.board = new Board(this);
    }

    public void init() {
        this.outOfRangeFlag[0] = this.outOfRangeFlag[1] = false;

    }

    public void play() {

    }


    public void onOmokPlaced() {
        this.room.onGameFinished(this.players[turn]);
    }

    private int allocateGameId() { return Game.gameNum++; }
    
    /* getters */

}

