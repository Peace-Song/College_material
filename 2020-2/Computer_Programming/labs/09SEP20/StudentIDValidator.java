import java.util.Scanner;

public class StudentIDValidator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String studentID;

        while (true) {
            studentID = scanner.nextLine();
            
            if (studentID.equals("exit")) break;
            
            validateStudentID(studentID);
        }

        scanner.close();
    }

    private static void validateStudentID (String studentID) {
        if (!isProperLength(studentID)) {
            System.out.println("The input length should be 10.");
            return;
        }

        if (!hasProperDivision(studentID)) {
            System.out.println("Fifth character should be '-'.");
            return;
        }

        if (!hasProperDigits(studentID)) {
            System.out.println("Contains an invalid digit.");
            return;
        }

        System.out.println(studentID + " is a valid student ID.");
        return;
    }

    private static boolean isProperLength (String studentID) {
        if (studentID.length() != 10) return false;
        
        return true;
    }

    private static boolean hasProperDivision (String studentID) {
        if (studentID.charAt(4) != '-') return false;
        
        return true;
    }

    private static boolean hasProperDigits (String studentID) {
        for (int idx = 0; idx < studentID.length(); idx++) {
            if (idx == 4) continue;

            if (!('0' <= studentID.charAt(idx) && studentID.charAt(idx) <= '9')) 
                return false;
        }

        return true;
    }
}