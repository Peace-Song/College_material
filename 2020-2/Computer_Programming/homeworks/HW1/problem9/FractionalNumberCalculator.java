public class FractionalNumberCalculator {
    public static void printCalculationResult(String equation) {
        String operand1 = equation.split(" ")[0];
        String operator = equation.split(" ")[1];
        String operand2 = equation.split(" ")[2];

        if (operator.equals("+") || operator.equals("-")) {
            System.out.println(addOrSubtract(operand1, operand2, operator.equals("+") ? true : false));
        } else {
            System.out.println(multiplyOrDivide(operand1, operand2, operator.equals("*") ? true : false));
        }
    }

    private static boolean isFrac(String number) {
        for (int idx = 0; idx < number.length(); idx++) {
            if (number.charAt(idx) == '/') {
                return true;
            }
        }
        return false;
    }

    private static String addOrSubtract(String operand1, String operand2, boolean isAdd) {
        int numerator1;
        int denominator1;
        int numerator2;
        int denominator2;
        int numerator;
        int denominator;
        int[] reduced_array;
        boolean isOperand1Frac = isFrac(operand1);
        boolean isOperand2Frac = isFrac(operand2);
        boolean isNegative;

        if (!isOperand1Frac) {
            numerator1 = Integer.parseInt(operand1);
            denominator1 = 1;
        } else {
            numerator1 = Integer.parseInt(operand1.split("/")[0]);
            denominator1 = Integer.parseInt(operand1.split("/")[1]);
        }

        if (!isOperand2Frac) {
            numerator2 = Integer.parseInt(operand2);
            denominator2 = 1;
        } else {
            numerator2 = Integer.parseInt(operand2.split("/")[0]);
            denominator2 = Integer.parseInt(operand2.split("/")[1]);
        }
        
        numerator = isAdd ? numerator1 * denominator2 + numerator2 * denominator1 : numerator1 * denominator2 - numerator2 * denominator1;
        denominator = denominator1 * denominator2;
        isNegative = numerator < 0 ? true : false;

        reduced_array = reduce(isNegative ? -numerator : numerator, denominator);

        if (isNegative) {
            return "-" + (reduced_array[1] == 1 ? Integer.toString(reduced_array[0]) : Integer.toString(reduced_array[0]) + "/" + Integer.toString(reduced_array[1]));
        } else {
            return reduced_array[1] == 1 ? Integer.toString(reduced_array[0]) : Integer.toString(reduced_array[0]) + "/" + Integer.toString(reduced_array[1]);
        }
    }

    private static String multiplyOrDivide(String operand1, String operand2, boolean isMultiply) {
        int numerator1;
        int denominator1;
        int numerator2;
        int denominator2;
        int numerator;
        int denominator;
        int[] reduced_array;
        boolean isOperand1Frac = isFrac(operand1);
        boolean isOperand2Frac = isFrac(operand2);

        if (!isOperand1Frac) {
            numerator1 = Integer.parseInt(operand1);
            denominator1 = 1;
        } else {
            numerator1 = Integer.parseInt(operand1.split("/")[0]);
            denominator1 = Integer.parseInt(operand1.split("/")[1]);
        }

        if (!isOperand2Frac) {
            numerator2 = Integer.parseInt(operand2);
            denominator2 = 1;
        } else {
            numerator2 = Integer.parseInt(operand2.split("/")[0]);
            denominator2 = Integer.parseInt(operand2.split("/")[1]);
        }

        if (!isMultiply && numerator2 == 0) {
            return "Cannot divide by zero.";
        }

        numerator = isMultiply ? numerator1 * numerator2 : numerator1 * denominator2;
        denominator = isMultiply ? denominator1 * denominator2 : denominator1 * numerator2;

        reduced_array = reduce(numerator, denominator);

        return reduced_array[1] == 1 ? Integer.toString(reduced_array[0]) : Integer.toString(reduced_array[0]) + "/" + Integer.toString(reduced_array[1]);
    }

    private static int[] reduce(int numerator, int denominator) {
        int divisor = 2;
        int[] result = new int[2];

        while (divisor <= (numerator < denominator ? numerator : denominator)) {
            if (numerator % divisor == 0 && denominator % divisor == 0) {
                numerator /= divisor;
                denominator /= divisor;
            } else {
                divisor++;
            }
        }

        result[0] = numerator;
        result[1] = numerator == 0 ? 1 : denominator;
        
        return result;
    }
}

class FractionalNumber {
    private int numerator;
    private int denominator;
}