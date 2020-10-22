package omok.src.client;

import java.net.*;
import java.io.*;
import java.util.Scanner;

public class OmokClient {
    private Socket socket;
    private ClientReadThread clientReadThread;
    private ClientWriteThread clientWriteThread;

    private static final String inputMarker = ">>> ";
    private static final String hostname = "localhost"; // "cn06@cn1.snucse.org"
    private static final int portNum = 20703;
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Welcome to Omok!");
        System.out.println("Type \"enter\" to connect to Omok server, \"exit\" to exit.");

        while (true) {
            System.out.print(inputMarker);
            String cmd = scanner.nextLine();

            if (cmd.equals("enter")) {
                OmokClient client = new OmokClient();
                client.connectToServer();

                break;
            }

            if (cmd.equals("exit")) {
                System.out.println("Thank you for playing Omok!");

                break;
            }

            System.out.println("Invalid command. Please try again.");
        }

        // scanner.close();
    }

    private void connectToServer() {
        try {
            this.socket = new Socket(OmokClient.hostname, OmokClient.portNum);
            System.out.println("Connection established with " + socket + "!");

            this.clientWriteThread = new ClientWriteThread(this.socket, this);
            this.clientReadThread = new ClientReadThread(this.socket, this);

            this.clientReadThread.start();
            this.clientWriteThread.start();

        } catch(IOException ioe) {
            System.out.println("Could not connect to the server. Please check your environment.");
            return;
        }
    }

    public ClientReadThread getClientReadThread() { return this.clientReadThread; }
    public ClientWriteThread getClientWriteThread() { return this.clientWriteThread; }
}
