import java.util.InputMismatchException;
import java.util.Scanner;

/**
 * This class represents a simple calculator program that performs basic arithmetic operations.
 */
public class CalcMain {
    /**
     * The main method of the calculator program.
     * It prompts the user for input and performs the selected arithmetic operation.
     *
     * @param args The command line arguments.
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int choice;
        int num1;
        int num2;
        boolean exit = false;

        do {
            System.out.println("Enter your choice");
            System.out.println("1. Add");
            System.out.println("2. Subtract");
            System.out.println("3. Multiply");
            System.out.println("4. Divide");
            System.out.println("5. Remainder");
            System.out.println("6. Exit");

            try {
                choice = scanner.nextInt();
                if (choice < 1 || choice > 6) {
                    System.out.println("Invalid choice");
                    continue;
                }

                if (choice == 6) {
                    exit = true;
                } else {
                    System.out.println("Enter first number: ");
                    num1 = readNumber(scanner);
                    System.out.println("Enter second number: ");
                    num2 = readNumber(scanner);

                    switch (choice) {
                        case 1:
                            performAddition(num1, num2);
                            break;
                        case 2:
                            performSubtraction(num1, num2);
                            break;
                        case 3:
                            performMultiplication(num1, num2);
                            break;
                        case 4:
                            performDivision(num1, num2);
                            break;
                        case 5:
                            performRemainder(num1, num2);
                            break;
                    }
                }
            } catch (InputMismatchException e) {
                System.out.println("Invalid input");
                scanner.nextLine();
            } catch (ArithmeticException e) {
                System.out.println(e.getMessage());
            }
        } while (!exit);

        scanner.close();
    }

    /**
     * Reads a number from the user input.
     * If an invalid input is provided, it prompts the user to enter a valid number.
     *
     * @param scanner The scanner object used to read user input.
     * @return The number entered by the user.
     */
    private static int readNumber(Scanner scanner) {
        while (true) {
            try {
                return scanner.nextInt();
            } catch (InputMismatchException e) {
                System.out.println("Invalid input. Please enter a valid number.");
                scanner.nextLine();
            }
        }
    }

    /**
     * Performs addition of two numbers and prints the result.
     *
     * @param num1 The first number.
     * @param num2 The second number.
     */
    private static void performAddition(int num1, int num2) {
        System.out.println("The sum is " + (num1 + num2));
    }

    /**
     * Performs subtraction of two numbers and prints the result.
     *
     * @param num1 The first number.
     * @param num2 The second number.
     */
    private static void performSubtraction(int num1, int num2) {
        System.out.println("The difference is " + (num1 - num2));
    }

    /**
     * Performs multiplication of two numbers and prints the result.
     *
     * @param num1 The first number.
     * @param num2 The second number.
     */
    private static void performMultiplication(int num1, int num2) {
        System.out.println("The product is " + (num1 * num2));
    }

    /**
     * Performs division of two numbers and prints the result.
     * Throws an ArithmeticException if the second number is zero.
     *
     * @param num1 The first number.
     * @param num2 The second number.
     * @throws ArithmeticException If the second number is zero.
     */
    private static void performDivision(int num1, int num2) {
        if (num2 == 0) {
            throw new ArithmeticException("Divide by zero error");
        }
        System.out.println("The division is " + (num1 / num2));
    }

    /**
     * Performs remainder calculation of two numbers and prints the result.
     *
     * @param num1 The first number.
     * @param num2 The second number.
     */
    private static void performRemainder(int num1, int num2) {
        System.out.println("The remainder is " + (num1 % num2));
    }
}
