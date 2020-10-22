package omok.src.common.player;

import java.util.ArrayList;

import omok.src.common.room.Room;
import omok.src.common.utils.PlayerStatus;
import omok.src.server.ClientHandler;

public class Player implements PlayerStatusSubject{
    private static int playerNum = 0;
    private int playerID;
    private PlayerStatus status;
    private ArrayList<Room> listeners;

    public Player() {
        this.playerID = this.allocatePlayerId();
        this.status = PlayerStatus.NOT_READY;
        this.listeners = new ArrayList<Room>();
    }

    private int allocatePlayerId() { return Player.playerNum++; }

    public static Player createPlayer() { return new Player(); }

    public void addListener(Room room) { this.listeners.add(room); }

    public void notifyStatusChange() {
        this.listeners.forEach((listener) -> listener.onChangePlayerStatus());
    }

    public void makeReady() {
        this.status = PlayerStatus.READY;

        this.notifyStatusChange();
    }

    /* getters */
    public int getPlayerId() { return this.playerID; }
    public PlayerStatus getStatus() { return this.status; }
}

interface PlayerStatusSubject {
    void addListener(Room room);
    void notifyStatusChange();
}

