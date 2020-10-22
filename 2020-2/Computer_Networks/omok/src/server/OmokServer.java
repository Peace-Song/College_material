package omok.src.server;

import java.net.*;
import java.util.ArrayList;
import java.io.*;

public class OmokServer {
    private ServerSocket serverSocket;
    private ArrayList<ClientHandler> clientHandlers;
    private static final int portNum = 20703;

    public static void main(String[] args) throws IOException {
        System.out.println("Omok Server initiating...");

        OmokServer server = new OmokServer();
        server.runServer();
    }

    private void runServer() {
        Store.init();
        this.clientHandlers = new ArrayList<ClientHandler>();

        try {
            this.serverSocket = new ServerSocket(OmokServer.portNum);
        } catch (IOException ioe) {
            System.out.println("Could not open server socket.");
            ioe.printStackTrace();

            return;
        }

        while (true) {
            try {
                Socket socket = this.serverSocket.accept();
                System.out.println("New client connected.");

                ClientHandler clientHandler = new ClientHandler(socket, this);
                this.clientHandlers.add(clientHandler);
                clientHandler.start();

            } catch (IOException ioe) {
                System.out.println("Could not run the server.");
                ioe.printStackTrace();
            }
        }
    }

    public ClientHandler getClientHandlerByPlayerId(int playerId) {
        for (ClientHandler handler : this.clientHandlers) {
            if (handler.getPlayer().getPlayerId() == playerId) {
                return handler;
            }
        }

        return null;
    }
}
