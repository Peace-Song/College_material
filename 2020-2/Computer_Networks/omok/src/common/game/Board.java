package omok.src.common.game;

public class Board {
    private GridStatus[][] board;
    private Game game;

    private final static int BOARDSIZE = 11;

    public Board(Game game) {
        this.board = new GridStatus[BOARDSIZE][BOARDSIZE];
        this.game = game;
    }

    public void putStone(int row, int col, GridStatus color) {
        if (this.board[row][col] != GridStatus.EMPTY || color == GridStatus.EMPTY) {
            System.out.println("[DEBUG] Cannot put " + color + " in row: " + row + ", col: " + col);
            return;
        }

        this.board[row][col] = color;

        if (this.checkStone(row, col)) {
            this.game.onOmokPlaced();
        }
    }

    public void printBoard() {
        // "     0   1   2   3   4   5   6   7   8   9   10 "
        // "   ---------------------------------------------"
        // " A | O | O | O | O | O | O | O | O | O | O | O |"
        // " B | O | O | O | O | O | O | O | O | O | O | O |"
        // " C | O | O | O | O | O | O | O | O | O | O | O |"

        String horizontalCoor = "     0   1   2   3   4   5   6   7   8   9   10 ";
        String horizontalLine = "   ---------------------------------------------";
        char alphabet = 'A';

        System.out.println(horizontalCoor);
        for (GridStatus[] row : this.board) {
            char stone = ' ';

            System.out.println(horizontalLine);
            System.out.print(" " + alphabet++ + " ");
            for (GridStatus col : row) {
                if (col == GridStatus.BLACK) stone = '⬤';
                else if (col == GridStatus.WHITE) stone = '○';
                System.out.print("| " + stone + " ");
            }
            System.out.println("|");
        }
        System.out.println(horizontalLine);
    }

    public boolean checkStone(int row, int col) {
        return this.checkStoneVertical(row, col)
            || this.checkStoneHorizontal(row, col)
            || this.checkStoneDiagonalLeft(row, col)
            || this.checkStoneDiagonalRight(row, col);
    }

    private boolean checkStoneVertical(int row, int col) {
        GridStatus stoneColor = this.board[row][col];
        int top = row;
        int bottom = row;

        while (top > 0 && this.board[top-1][col] == stoneColor) {
            top--;
        }

        while (bottom < BOARDSIZE - 1 && this.board[bottom+1][col] == stoneColor) {
            bottom++;
        }
        
        // more than 5 consecutive stones considered not omok
        if (bottom - top + 1 == 5) return true;
        else return false; 
    }

    private boolean checkStoneHorizontal(int row, int col) {
        GridStatus stoneColor = this.board[row][col];
        int left = col;
        int right = col;

        while (left > 0 && this.board[row][left-1] == stoneColor) {
            left--;
        }

        while (right < BOARDSIZE - 1 && this.board[row][right+1] == stoneColor) {
            right++;
        }
        
        // more than 5 consecutive stones considered not omok
        if (right - left + 1 == 5) return true;
        else return false; 
    }

    private boolean checkStoneDiagonalLeft(int row, int col) {
        GridStatus stoneColor = this.board[row][col];
        int leftTopRow = row;
        int leftTopCol = col;
        int rightBottomRow = row;
        int rightBottomCol = col;

        while (leftTopRow > 0 && leftTopCol > 0 && this.board[leftTopRow-1][leftTopCol-1] == stoneColor) {
            leftTopRow--;
            leftTopCol--;
        }

        while (rightBottomRow < BOARDSIZE - 1 && rightBottomCol < BOARDSIZE - 1 && this.board[rightBottomRow+1][rightBottomCol+1] == stoneColor) {
            rightBottomRow++;
            rightBottomCol++;
        }

        if (rightBottomCol - leftTopCol + 1 == 5 && rightBottomRow - leftTopRow + 1 == 5) return true;
        else return false;
    }

    private boolean checkStoneDiagonalRight(int row, int col) {
        GridStatus stoneColor = this.board[row][col];
        int rightTopRow = row;
        int rightTopCol = col;
        int leftBottomRow = row;
        int leftBottomCol = col;

        while (rightTopRow > 0 && rightTopCol < BOARDSIZE - 1 && this.board[rightTopRow-1][rightTopCol+1] == stoneColor) {
            rightTopRow--;
            rightTopCol++;
        }

        while (leftBottomRow < BOARDSIZE - 1 && leftBottomCol > 0 && this.board[leftBottomRow+1][leftBottomCol-1] == stoneColor) {
            leftBottomRow++;
            leftBottomCol--;
        }

        if (rightTopCol - leftBottomCol + 1 == 5 && leftBottomRow - rightTopRow + 1 == 5) return true;
        else return false;
    }


}

enum GridStatus {
    EMPTY,
    BLACK,
    WHITE
}
