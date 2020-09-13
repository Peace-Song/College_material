public class MatrixFlip {
    public static void printFlippedMatrix(char[][] matrix) {
        flipRow(matrix);
        for (char[] row : matrix) {
            flipColumn(row);
        }
        printMatrix(matrix);
    }

    private static void flipRow(char[][] matrix) {
        char[] temp;
        for (int idx = 0; idx < matrix.length / 2; idx++) {
            temp = matrix[matrix.length - idx - 1];
            matrix[matrix.length - idx - 1] = matrix[idx];
            matrix[idx] = temp;
        }
    }

    private static void flipColumn(char[] row) {
        char temp;
        for (int idx = 0; idx < row.length / 2; idx++) {
            temp = row[row.length - idx - 1];
            row[row.length - idx - 1] = row[idx];
            row[idx] = temp;
        }
    }

    private static void printMatrix(char[][] matrix) {
        for (char[] row : matrix) {
            for (char element : row) {
                System.out.print(element);
            }
            System.out.println("");
        }
    }
}
