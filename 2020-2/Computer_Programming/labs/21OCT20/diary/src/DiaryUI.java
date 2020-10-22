import java.util.Scanner;

public class DiaryUI {
    private static Diary diary = new Diary();
    private static Scanner scanner = new Scanner(System.in);

    /* Print the message, and input a string line from the console */
    static String input(String message) {
        System.out.print("\t" + message);
        return scanner.nextLine();
    }

    /* Print the message */
    static void print(Object object) {
        System.out.println("\t" + object);
    }

    private static boolean runCommand(String command) {
        String[] commandSlices = command.split(" ");
        String commandName = commandSlices[0];
        int argNum = commandSlices.length;

        if (commandName.equals("exit")) {
            return false;
        }

        if (commandName.equals("create") && argNum == 1) {
            diary.createEntry();
        } else if (commandName.equals("list") && argNum == 1) {
            diary.listEntries();
        } else if (commandName.equals("read") && argNum == 2) {
            int id = Integer.parseInt(commandSlices[1]);
            diary.readEntry(id);
        } else if (commandName.equals("delete") && argNum == 2) {
            int id = Integer.parseInt(commandSlices[1]);
            diary.deleteEntry(id);
        } else if (commandName.equals("search") && argNum == 2) {
            String keyword = commandSlices[1];
            diary.searchEntry(keyword);
        } else {
            print(String.format("Wrong command: %s", command));
        }
        return true;
    }

    public static void main(String[] args) {
        String command;
        do {
            print("\nType a command");
            print("\tcreate: Create a diary entry");
            print("\tlist: List diary entries");
            print("\tread <id>: Read a diary entry with <id>");
            print("\tdelete <id>: Delete a diary entry with <id>");
            print("\tsearch <keyword>: List diary entries whose contents contain <keyword>");
            System.out.print("Command: ");
            command = scanner.nextLine();
        } while (runCommand(command));
    }
}
