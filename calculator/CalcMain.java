//Calculator java app with menu options add, substract, division, multiplication and exit. loop until exit is the choice, exception handling for invalid input

import java.util.Scanner;

public class CalcMain {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int choice = 0;
        do {
            System.out.println("1. Add");
            System.out.println("2. Subtract");
            System.out.println("3. Divide");
            System.out.println("4. Multiply");
            System.out.println("5. Sin");
            System.out.println("6. Cosine");
            System.out.println("7. Exit");
            System.out.println("Enter your choice:");
            try {
            choice = scanner.nextInt();
            if (choice < 1 || choice > 7) {
                System.out.println("Invalid choice");
                continue;
            }
            if (choice == 7) {
                System.out.println("Exiting...");
                break;
            }
            System.out.println("Enter first number:");
            int num1 = scanner.nextInt();
            System.out.println("Enter second number:");
            int num2 = scanner.nextInt();
            switch (choice) {
                case 1:
                System.out.println("Result: " + (num1 + num2));
                break;
                case 2:
                System.out.println("Result: " + (num1 - num2));
                break;
                case 3:
                System.out.println("Result: " + (num1 / num2));
                break;
                case 4:
                System.out.println("Result: " + (num1 * num2));
                break;
                case 5:
                System.out.println("Result: " + Math.sin(num1));
                break;
                case 6:
                System.out.println("Result: " + Math.cos(num1));
                break;
                default:
                System.out.println("Invalid choice");
            }
            } catch (Exception e) {
            System.out.println("Invalid input");
            scanner.next();
            }
        } while (choice != 7);
        scanner.close();
    }
}
