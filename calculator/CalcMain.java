//Java console program with menu options for Add, Subtract, Multiply, Divide and Exit:


import java.util.Scanner;

public class CalcMain {

    /**
        * The main method of the calculator program.
        * It allows the user to perform basic arithmetic operations.
        *
        * @param args the command line arguments
        */
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int choice;
        do {
            System.out.println("1. Add");
            System.out.println("2. Subtract");
            System.out.println("3. Multiply");
            System.out.println("4. Divide");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");
            choice = sc.nextInt();
            switch (choice) {
                case 1:
                    System.out.print("Enter number 1: ");
                    int num1 = sc.nextInt();
                    System.out.print("Enter number 2: ");
                    int num2 = sc.nextInt();
                    System.out.println("Sum = " + (num1 + num2));
                    break;
                case 2:
                    System.out.print("Enter number 1: ");
                    num1 = sc.nextInt();
                    System.out.print("Enter number 2: ");
                    num2 = sc.nextInt();
                    System.out.println("Difference = " + (num1 - num2));
                    break;
                case 3:
                    System.out.print("Enter number 1: ");
                    num1 = sc.nextInt();
                    System.out.print("Enter number 2: ");
                    num2 = sc.nextInt();
                    System.out.println("Product = " + (num1 * num2));
                    break;
                case 4:
                    System.out.print("Enter number 1: ");
                    num1 = sc.nextInt();
                    System.out.print("Enter number 2: ");
                    num2 = sc.nextInt();
                    System.out.println("Quotient = " + (num1 / num2));
                    break;
                case 5:
                    System.out.println("Exiting...");
                    break;
                default:
                    System.out.println("Invalid choice!");
            }
        } while (choice != 5);
    }
}