package omok.src.client;

import java.net.Socket;
import java.net.SocketException;
import java.io.EOFException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.BufferedReader;


public class ClientReadThread extends Thread {
    private Socket socket;
    private OmokClient client;
    private BufferedReader reader;

    public ClientReadThread(Socket socket, OmokClient client) {
        this.socket = socket;
        this.client = client;

        try {
            this.reader = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
        } catch (IOException ioe) {
            System.out.println("Could not open input stream from the server: " + ioe.getMessage());
            ioe.printStackTrace();
        }
    }

    @Override
    public void run() {        
        while (true) {
            try {
                String receivedMsg = this.reader.readLine();
                this.executeMsg(receivedMsg);
                
            } catch(EOFException | SocketException e) {
                System.out.println("Omok server closed the connection: " + e.getMessage());
                break;
            } catch(Exception e) {
                System.out.println("Omok client has met problems in communication: " + e.getMessage());
                e.printStackTrace();
                break;
            }
        }
    }

    private void executeMsg(String msg) {
        String cmd = msg.split(":")[0];

        if (cmd.equals("list")) {
            String body = msg.split(":")[1];

            String result = "================================\nAvailable Room IDs\n--------------------------------\n";
            result += (body.equals("none") ? "There is currently no rooms." : body);
            result += "\n================================";
            
            System.out.println(result);

            synchronized(ClientWriteThread.lock) {
                ClientWriteThread.lock.notify();
            }
        }

        else if (cmd.equals("joined")) {
            System.out.println("fda");
            String playerId = cmd.split(":")[1];
            String roomId = cmd.split(":")[2];

            synchronized(ClientWriteThread.lock) {
                ClientWriteThread.commonBufferString = playerId + ":" + roomId;
                ClientWriteThread.lock.notify();
            }
        }

        else if (cmd.equals("hosted")) {
            String playerId = cmd.split(":")[1];

            synchronized(ClientWriteThread.lock) {
                ClientWriteThread.commonBufferString = playerId;
                ClientWriteThread.lock.notify();
            }
        }
    }

}
