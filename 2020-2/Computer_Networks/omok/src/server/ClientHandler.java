package omok.src.server;

import java.io.EOFException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.SocketException;

import omok.src.common.player.Player;
import omok.src.common.room.Room;

public class ClientHandler extends Thread {
    private Socket socket;
    private OmokServer server;
    private BufferedReader reader;
    private PrintWriter writer;
    private Player player;

    public ClientHandler(Socket socket, OmokServer server) {
        this.socket = socket;
        this.server = server;
        try {
            this.reader = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
            this.writer = new PrintWriter(this.socket.getOutputStream(), true);
        } catch(IOException ioe) {
            System.out.println("Could not initiate thread: " + ioe.getMessage());
            ioe.printStackTrace();
        }
    }

    @Override
    public void run() {
        String receivedMsg;
        
        System.out.println("Connection established with " + socket + ".");

        try {
            while (true) {
                receivedMsg = this.reader.readLine();
                if (receivedMsg == null) break;
                System.out.println("received: " + receivedMsg);
                this.executeMsg(receivedMsg);
            }
        } catch(EOFException | SocketException e) {
        } catch(IOException e) {
            System.out.println("Omok server has met problems in communication: " + e.getMessage());
            e.printStackTrace();
        }

        System.out.println("Connection at socket " + this.socket + " closed.");
        try {
            this.socket.close();
        } catch(IOException ioe) {
            System.out.println("Could not close the socket: " + ioe.getMessage());
            ioe.printStackTrace();
        }
    }
    
    private void executeMsg(String msg) {
        String cmd = msg.split(":")[0];

        if (cmd.equals("newUser")) {
            Player player = Player.createPlayer();
            this.player = player;
            Store.addPlayer(player);
        }

        else if (cmd.equals("list")) {
            this.writer.println("list:" + Store.getAvailableRooms());
        }
        
        else if (cmd.equals("open")) {
            Room room = Room.createRoom(this.player);
            Store.addRoom(room);

            this.writer.println("opened:" + room.getRoomId());
        }

        else if (cmd.equals("join")) {
            System.out.println("fdas: " + msg);
            int roomId = Integer.parseInt(msg.split(":")[1]);

            Room room = Store.getRoomById(roomId);
            room.enterPlayer(this.player);
            Player player = room.getPlayer(0);
            int id = player.getPlayerId();
            ClientHandler clientHandler = this.server.getClientHandlerByPlayerId(id);
            clientHandler.writer.println("joined:" + this.player.getPlayerId() + ":" + roomId);
            this.writer.println("hosted:" + room.getPlayer(0).getPlayerId());
        }

        else if (cmd.equals("ready")) {
            int roomId = Integer.parseInt(msg.split(":")[1]);

            this.player.makeReady();
        }
    }

    public void setPlayer(Player player) { this.player = player; }
    public Player getPlayer() { return this.player; }
}
