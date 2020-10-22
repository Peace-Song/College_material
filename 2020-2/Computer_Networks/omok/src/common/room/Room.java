package omok.src.common.room;

import omok.src.common.game.Game;
import omok.src.common.player.Player;
import omok.src.common.utils.PlayerStatus;
import omok.src.common.utils.RoomStatus;
import omok.src.common.utils.listeners.GameStatusListener;
import omok.src.common.utils.listeners.PlayerStatusListener;

public class Room implements PlayerStatusListener, GameStatusListener {
    private static int roomNum = 0;
    private int roomId;
    private RoomStatus status;
    private Player[] players; // idx 0 is always the owner
    private Game game;

    public Room() {
        this.roomId = this.allocateRoomId();
        this.status = RoomStatus.IDLE;
        this.players = new Player[2];
    }

    public Room(Player createdPlayer) {
        this();
        this.players[0] = createdPlayer;
    }

    public void onChangePlayerStatus() {
        if (players[0].getStatus() == PlayerStatus.READY && players[1].getStatus() == PlayerStatus.READY) {
            this.game.play();
        }
    }
    
    public void onGameFinished(Player winner) {
        System.out.println("Player ID " + winner.getPlayerId() + " wins!");
    }

    private int allocateRoomId() { return Room.roomNum++; }

    public static Room createRoom(Player createdPlayer) { return new Room(createdPlayer); }

    public void enterPlayer(Player player) {
        this.players[1] = player;
        this.status = RoomStatus.FULL;
    }

    /* getters */
    public int getRoomId() { return this.roomId; }
    public RoomStatus getRoomStatus() { return this.status; }
    public Player getPlayer(int idx) { return this.players[idx]; }
}
