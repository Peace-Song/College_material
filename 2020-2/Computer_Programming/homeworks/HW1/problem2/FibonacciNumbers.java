public class FibonacciNumbers {
    public static void printFibonacciNumbers(int n) {
        int a0 = 0;
        int a1 = 1;
        int a2;

        if (n == 1) {
            System.out.println(a0);
            return;
        }

        for (int step = 0; step < n; step++) {
            System.out.printf("%d ", a0);
            a2 = a0 + a1;
            a0 = a1;
            a1 = a2;
        }
        System.out.println("");
    }
}
