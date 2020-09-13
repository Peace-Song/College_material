public class PrimeNumbers {
    public static void printPrimeNumbers(int n) {
        int num = 2;
        
        for (int __ = 0; __ < n; __++) {
            int count = 0;

            while (true) {
                for (int divisor = 1; divisor <= num; divisor++) {
                    if (num % divisor == 0) {
                        count++;
                    }
                }

                if (count == 2) {
                    System.out.printf("%d ", num);
                    num++;
                    break;
                }
                
                num++;
                count = 0;
            }
        }
        
        System.out.println("");
    }
}
