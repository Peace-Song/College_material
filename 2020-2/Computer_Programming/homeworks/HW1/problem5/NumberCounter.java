public class NumberCounter {
    public static void countNumbers(String str0, String str1, String str2) {
        int int0 = Integer.parseInt(str0);
        int int1 = Integer.parseInt(str1);
        int int2 = Integer.parseInt(str2);
        String str = Integer.toString(int0 * int1 * int2);

        int digit_cnts[] = new int[10];
        for (int idx = 0; idx < 10; idx++) {
            digit_cnts[idx] = 0;
        }

        for (int idx = 0; idx < str.length(); idx++) {
            char ch = str.charAt(idx);
            int ch_idx = (int)(ch - '0');
            digit_cnts[ch_idx]++;
        }

        for (int idx = 0; idx < 10; idx++) {
            if (digit_cnts[idx] != 0) {
                printNumberCount(idx, digit_cnts[idx]);
            }
        }
    }

    private static void printNumberCount(int number, int count) {
        System.out.printf("%d: %d times\n", number, count);
    }
}
