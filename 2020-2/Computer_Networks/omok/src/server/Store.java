package omok.src.server;

import java.util.ArrayList;
import omok.src.common.player.Player;
import omok.src.common.room.Room;
import omok.src.common.utils.RoomStatus;

public class Store {
    private static Store instance;
    private static ArrayList<Room> rooms;
    private static ArrayList<Player> players;

    private Store() {
        Store.rooms = new ArrayList<Room>();
        Store.players = new ArrayList<Player>();
    }

    public static void addPlayer(Player player) {
        Store.players.add(player);
    }

    public static void removePlayer(Player player) {
        Store.players.add(player);
    }

    public static void addRoom(Room room) {
        Store.rooms.add(room);
    }

    public static void removeRoom(Room room) {
        Store.rooms.remove(room);
    }

    public static String getAvailableRooms() {
        String result = "";
        
        if (Store.rooms.size() == 0) result += "none";
        else {
            for (Room room : Store.rooms) {
                if (room.getRoomStatus() == RoomStatus.IDLE) {
                    result += (room.getRoomId() + " ");
                }
            }
        }
        return result;
    }

    public static void init() {
        if (instance == null) {
            synchronized(Store.class) {
                if (instance == null) {
                    instance = new Store();
                }
            }
        }
    }

    /* getters */
    public static Store getInstance() {
        return Store.instance;
    }

    public static ArrayList<Room> getRooms() {
        return Store.rooms;
    }

    public static Room getRoomById(int roomId) {
        for (Room room : Store.rooms) {
            if (room.getRoomId() == roomId) {
                return room;
            }
        }
        return null;
    }
}
