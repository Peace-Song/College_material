import java.util.Scanner;

public class XDrawing {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int size;
        int xIndex;

        while (true) {
            size = scanner.nextInt();
            xIndex = 0;
            
            if (size == 0) break;

            for (int row = 0; row < size; row++) {
                for (int column = 0; column < size; column++) {
                    System.out.print(column == xIndex || column == size - xIndex - 1 ? "X" : "O");
                }
                System.out.println("");
                xIndex++;
            }
        }

        scanner.close();
    }
}