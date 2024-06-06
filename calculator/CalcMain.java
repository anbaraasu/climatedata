//Calculator java app with menu options add, substract, division, multiplication and exit. loop until exit is the choice, exception handling for invalid inputs


import java.util.Scanner;

/**
 * The `CalcMain` class is the main class of the calculator program.
 * It allows the user to perform basic arithmetic operations on two numbers.
 */
public class CalcMain {

    /**
     * The main method of the `CalcMain` class.
     * It prompts the user for input and performs the selected arithmetic operation.
     *
     * @param args The command-line arguments passed to the program.
     */
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		int choice = 0;
		int num1 = 0;
		int num2 = 0;
		while (choice != 5) {
			System.out.println("Enter 1 for addition, 2 for substraction, 3 for division, 4 for multiplication and 5 for exit");
			try {
				choice = Integer.parseInt(scanner.nextLine());
			} catch (Exception e) {
				System.out.println("Invalid input, please enter a number between 1 and 5");
				scanner.nextLine();
				continue;
			}
			if (choice == 5)
				break;
			System.out.println("Enter first number");
			try {
				num1 = scanner.nextInt();
			} catch (Exception e) {
				System.out.println("Invalid input, please enter a number");
				scanner.nextLine();
				continue;
			}
			System.out.println("Enter second number");
			try {
				num2 = scanner.nextInt();
			} catch (Exception e) {
				System.out.println("Invalid input, please enter a number");
				scanner.nextLine();
				continue;
			}
			switch (choice) {
			case 1:
				System.out.println("Addition of " + num1 + " and " + num2 + " is " + (num1 + num2));
				break;
			case 2:
				System.out.println("Substraction of " + num1 + " and " + num2 + " is " + (num1 - num2));
				break;
			case 3:
				System.out.println("Division of " + num1 + " and " + num2 + " is " + (num1 / num2));
				break;
			case 4:
				System.out.println("Multiplication of " + num1 + " and " + num2 + " is " + (num1 * num2));
				break;
			default:
				System.out.println("Invalid choice, please enter a number between 1 and 5");
			}
		}
		scanner.close();
	}
}
