public class DrawingFigure {
    public static void drawFigure(int n) {
        for (int step = 0; step < n; step++) {
            drawStep(step);
            System.out.println("");
        }
    }

    private static void drawStep(int step) {
        int numSlash = 5 - step;

        for (int __ = 0; __ < numSlash; __++) {
            System.out.print("////");
        }
        for (int __ = 0; __ < step; __++) {
            System.out.print("********");
        }
        for (int __ = 0; __ < numSlash; __++) {
            System.out.print("\\\\\\\\");
        }
    }
}
