//Java console program with menu options for Add, Subtract, Multiply, Divide and Exit: with exception handling

import java.util.Scanner;

public class CalcMain {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String choice = "";
        do {
            System.out.println("1. Add");
            System.out.println("2. Subtract");
            System.out.println("3. Multiply");
            System.out.println("4. Divide");
            System.out.println("5. Exit");
            System.out.println("Enter your choice: ");
            choice = scanner.nextLine();
            switch (choice) {
                case "1":
                    System.out.println("Enter first number: ");
                    int num1 = Integer.parseInt(scanner.nextLine());
                    System.out.println("Enter second number: ");
                    int num2 = Integer.parseInt(scanner.nextLine());
                    System.out.println("Result: " + (num1 + num2));
                    break;
                case "2":
                    System.out.println("Enter first number: ");
                    num1 = Integer.parseInt(scanner.nextLine());
                    System.out.println("Enter second number: ");
                    num2 = Integer.parseInt(scanner.nextLine());
                    System.out.println("Result: " + (num1 - num2));
                    break;
                case "3":
                    System.out.println("Enter first number: ");
                    num1 = Integer.parseInt(scanner.nextLine());
                    System.out.println("Enter second number: ");
                    num2 = Integer.parseInt(scanner.nextLine());
                    System.out.println("Result: " + (num1 * num2));
                    break;
                case "4":
                    System.out.println("Enter first number: ");
                    num1 = Integer.parseInt(scanner.nextLine());
                    System.out.println("Enter second number: ");
                    num2 = Integer.parseInt(scanner.nextLine());
                    if (num2 == 0) {
                        System.out.println("Cannot divide by zero");
                    } else {
                        System.out.println("Result: " + (num1 / num2));
                    }
                    break;
                case "5":
                    System.out.println("Exiting...");
                    break;
                default:
                    System.out.println("Invalid choice");
            }
        } while (!choice.equals("5"));
    }
}