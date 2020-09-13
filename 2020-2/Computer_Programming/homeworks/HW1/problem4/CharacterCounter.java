public class CharacterCounter {
    public static void countCharacter(String str) {
        int char_cnts[] = new int[26];
        for (int idx = 0; idx < 26; idx++) {
            char_cnts[idx] = 0;
        }

        for (int idx = 0; idx < str.length(); idx++) {
            char ch = str.charAt(idx);
            int ch_idx = (int)(ch - 'a');
            char_cnts[ch_idx]++;
        }

        for (int idx = 0; idx < 26; idx++) {
            if (char_cnts[idx] != 0) {
                printCount((char)('a' + idx), char_cnts[idx]);
            }
        }
    }

    private static void printCount(char character, int count) {
        System.out.printf("%c: %d times\n", character, count);
    }
}