import java.util.Scanner;

public class Eratosthenes {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int limit;
        int count;

        while (true) {
            limit = scanner.nextInt();

            if (limit == 0) break;
            
            for (int curr_num = 1; curr_num < limit; curr_num++) {
                count = 0;

                for (int divisor = 1; divisor <= curr_num; divisor++) {
                    if (curr_num % divisor == 0) count++;
                }

                if (count == 2) System.out.printf("%d ", curr_num);
            }

            System.out.println("");
        }
        
        scanner.close();
    }
}
