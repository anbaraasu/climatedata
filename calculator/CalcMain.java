//Calculator java app with menu options add, substract, division, multiplication and exit. loop until exit is the choice.

import java.util.Scanner;

/**
 * The `CalcMain` class represents a calculator program that allows users to perform basic arithmetic operations
 * and calculate the sine and cosine of a number.
 */
public class CalcMain {
    /**
     * The main method is the entry point of the program.
     *
     * @param args The command-line arguments.
     */
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int choice;
        do {
            //Add Sin and Cosine functions to the Menu options
            System.out.println("Calculator Menu");
            System.out.println("1. Add");
            System.out.println("2. Subtract");
            System.out.println("3. Multiply");
            System.out.println("4. Divide");
            System.out.println("5. Sin");
            System.out.println("6. Cosine");
            System.out.println("7. Exit");
            System.out.println("Enter your choice:");
            choice = sc.nextInt(); // Fix: Read user's input as an integer
            switch (choice) {
            case 1:
                System.out.println("Enter the first number:");
                int a = sc.nextInt();
                System.out.println("Enter the second number:");
                int b = sc.nextInt();
                System.out.println("Sum is :" + (a + b));
                break;
            case 2:
                System.out.println("Enter the first number:");
                int c = sc.nextInt();
                System.out.println("Enter the second number:");
                int d = sc.nextInt();
                System.out.println("Difference is :" + (c - d));
                break;
            case 3:
                System.out.println("Enter the first number:");
                int e = sc.nextInt();
                System.out.println("Enter the second number:");
                int f = sc.nextInt();
                System.out.println("Product is :" + (e * f));
                break;
            case 4:
                System.out.println("Enter the first number:");
                int g = sc.nextInt();
                System.out.println("Enter the second number:");
                int h = sc.nextInt();
                System.out.println("Quotient is :" + (g / h));
                break;
            case 5:
                System.out.println("Enter the number:");
                double i = sc.nextDouble();
                System.out.println("Sin is :" + Math.sin(i));
                break;
            case 6:
                System.out.println("Enter the number:");
                double j = sc.nextDouble();
                System.out.println("Cosine is :" + Math.cos(j));
                break;
            case 7:
                System.out.println("Exiting...");
                break;
            default:
                System.out.println("Invalid choice. Please enter a valid choice.");
            }
        } while (choice != 7);
        sc.close();
    }
}

