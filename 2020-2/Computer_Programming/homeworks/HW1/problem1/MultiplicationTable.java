public class MultiplicationTable {
    public static void printMultiplicationTable(int n) {
        for (int outer_num = 1; outer_num <= n; outer_num++) {
            for (int inner_num = 1; inner_num <= n; inner_num++) {
                printOneMultiplication(outer_num, inner_num, outer_num * inner_num);
            }
        }
    }

    private static void printOneMultiplication(int a, int b, int c) {
        System.out.printf("%d times %d = %d\n", a, b, c);
    }
}