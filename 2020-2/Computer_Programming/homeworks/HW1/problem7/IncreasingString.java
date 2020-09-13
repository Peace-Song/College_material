public class IncreasingString {
    public static void printLongestIncreasingSubstringLength(String inputString) {
        int left_idx = 0;
        int right_idx = 0;
        int max_length = 1;

        while (true) {
            if (right_idx + 1 == inputString.length()) break;

            if (inputString.charAt(right_idx) < inputString.charAt(right_idx + 1)) {
                right_idx++;
                if (right_idx - left_idx + 1 > max_length) {
                    max_length = right_idx - left_idx + 1;
                }
            } else {
                right_idx++;
                left_idx = right_idx;
            }
        }

        System.out.println(max_length);
    }
}
