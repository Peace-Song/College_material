package omok.src.client;

import java.net.Socket;
import java.net.SocketException;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.Scanner;
import java.io.Console;
import java.io.IOException;
import java.io.PrintWriter;

public class ClientWriteThread extends Thread {
    private Socket socket;
    private OmokClient client;
    private PrintWriter writer;
    private Scanner scanner;
    public static Lock lock;
    public static String commonBufferString;

    private static final String cmdList = "Type one of the following commands to proceed.\nlist: show rooms available to join\nopen: open a room\nenter {roomId}: enter to a room\nexit: exit Omok";
    private static final String prompt = ">>> ";

    public ClientWriteThread(Socket socket, OmokClient client) {
        this.socket = socket;
        this.client = client;
        this.scanner = new Scanner(System.in);
        ClientWriteThread.lock = new ReentrantLock();

        try {
            this.writer = new PrintWriter(this.socket.getOutputStream(), true);
            this.writer.flush();
            this.writer.println("newPlayer:");
        } catch (IOException ioe) {
            System.out.println("Could not open output stream to the server: " + ioe.getMessage());
            ioe.printStackTrace();
        }
    }

    @Override
    public void run() {        
        String cmd = "";
        System.out.println(cmdList);
        System.out.print(prompt);

        cmd = this.scanner.nextLine();
        while (true) {
            try {
                if (cmd.equals("list")) {
                    synchronized(ClientWriteThread.lock) {
                        try {
                            this.writer.println("list:");
                            ClientWriteThread.lock.wait();
                        } catch (InterruptedException e) {
                            System.out.println("interrupt");
                        }
                    }

                } else if (cmd.equals("open")) {
                    this.writer.println("open:");
                    System.out.println("Waiting for an opponent to join...");
                    
                    synchronized(ClientWriteThread.lock) {
                        try {
                            ClientWriteThread.lock.wait();
                        } catch (InterruptedException e) {
                            System.out.println("interrupt");
                        }
                    }

                    String roomId = ClientWriteThread.commonBufferString.split(":")[1];
                    System.out.println("User with ID " + ClientWriteThread.commonBufferString.split(":")[0] + " joined the game.");
                    System.out.println("Type \"ready\" to mark as ready.");

                    String status = this.scanner.nextLine();
                    while (!status.equals("ready")) {
                        status = this.scanner.nextLine();
                    }

                    this.writer.println("ready:" + roomId);

                } else if (cmd.startsWith("enter")) {
                    String roomId = cmd.split(" ")[1];
                    this.writer.println("join:" + roomId);

                    synchronized(ClientWriteThread.lock) {
                        try {
                            ClientWriteThread.lock.wait();
                        } catch (InterruptedException e) {
                            System.out.println("interrupt");
                        }
                    }

                    System.out.println("User with ID " + ClientWriteThread.commonBufferString + " is the host.");
                    System.out.println("Type \"ready\" to mark as ready.");

                    String status = this.scanner.nextLine();
                    while (!status.equals("ready")) {
                        status = this.scanner.nextLine();
                    }

                    this.writer.println("ready:" + roomId);

                } else if (cmd.equals("exit")) {
                    break;
                }

                System.out.print(prompt);
                cmd = this.scanner.nextLine();
                // synchronized(ClientWriteThread.lock) {
                //     try {
                //         ClientWriteThread.lock.wait();
                //     } catch (InterruptedException e) {
                //         System.out.println("interrupt");
                //     }
                // }



            } catch(Exception e) {
                System.out.println("Omok client crashed while waiting for server response: " + e.getMessage());
                e.printStackTrace();
                break;
            }
        }

        this.writer.close();
    }

}
