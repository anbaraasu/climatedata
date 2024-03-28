//Java console program with menu options for Add, Subtract, Multiply, Divide, remainder and Exit: with exception handling for divide by zero, input mismatch and invalid choice
import java.util.InputMismatchException;
import java.util.Scanner;

public class CalcMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int choice;
        double num1, num2;
        do {
            System.out.println("Calculator Menu");
            System.out.println("1. Add");
            System.out.println("2. Subtract");
            System.out.println("3. Multiply");
            System.out.println("4. Divide");
            System.out.println("5. Exit");
            System.out.println("Enter your choice: ");
            try {
                choice = sc.nextInt();
                if (choice == 5) {
                    System.out.println("Exiting the program");
                    break;
                }
                System.out.println("Enter first number: ");
                num1 = sc.nextDouble();
                System.out.println("Enter second number: ");
                num2 = sc.nextDouble();
                switch (choice) {
                    case 1:
                        System.out.println("Result: " + (num1 + num2));
                        break;
                    case 2:
                        System.out.println("Result: " + (num1 - num2));
                        break;
                    case 3:
                        System.out.println("Result: " + (num1 * num2));
                        break;
                    case 4:
                        if (num2 == 0) {
                            throw new ArithmeticException("Divide by zero error");
                        }
                        System.out.println("Result: " + (num1 / num2));
                        break;
                    default:
                        System.out.println("Invalid choice");
                }
            } catch (InputMismatchException e) {
                System.out.println("Invalid input. Please enter a number");
                sc.nextLine();
            } catch (ArithmeticException e) {
                System.out.println(e.getMessage());
            }
        } while (true);
        sc.close();
    }
}