/*
	Calculate Console App with menu options and exception handlings. 
 */
import java.util.Scanner;

public class SME_Calc_Main {

	private double _result;

	public SME_Calc_Main() {
		_result = 0.0;
	}

	// Method to add two numbers
	public double add(double a, double b) {
		return a + b;
	}

	// Method to subtract two numbers
	public double subtract(double a, double b) {
		return a - b;
	}

	// Method to multiply two numbers
	public double multiply(double a, double b) {
		return a * b;
	}

	// Method to divide two numbers
	public double divide(double a, double b) throws ArithmeticException {
		if (b == 0) {
			throw new ArithmeticException("Division by zero is not allowed.");
		}
		return a / b;
	}

	// Method to calculate the cosine of a number
	public double cosine(double a) {
		return Math.cos(a);
	}

	// Main method to run the calculator app
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		SME_Calc_Main calculator = new SME_Calc_Main();
		boolean exit = false;

		while (!exit) {
			System.out.println("Calculator Menu:");
			System.out.println("1. Add");
			System.out.println("2. Subtract");
			System.out.println("3. Multiply");
			System.out.println("4. Divide");
			System.out.println("5. Cosine");
			System.out.println("6. Exit");
			System.out.print("Choose an option: ");

			try {
				int choice = scanner.nextInt();
				double num1, num2;

				switch (choice) {
					case 1:
						System.out.print("Enter first number: ");
						num1 = scanner.nextDouble();
						System.out.print("Enter second number: ");
						num2 = scanner.nextDouble();
						System.out.println("Result: " + calculator.add(num1, num2));
						break;
					case 2:
						System.out.print("Enter first number: ");
						num1 = scanner.nextDouble();
						System.out.print("Enter second number: ");
						num2 = scanner.nextDouble();
						System.out.println("Result: " + calculator.subtract(num1, num2));
						break;
					case 3:
						System.out.print("Enter first number: ");
						num1 = scanner.nextDouble();
						System.out.print("Enter second number: ");
						num2 = scanner.nextDouble();
						System.out.println("Result: " + calculator.multiply(num1, num2));
						break;
					case 4:
						System.out.print("Enter first number: ");
						num1 = scanner.nextDouble();
						System.out.print("Enter second number: ");
						num2 = scanner.nextDouble();
						try {
							System.out.println("Result: " + calculator.divide(num1, num2));
						} catch (ArithmeticException e) {
							System.out.println(e.getMessage());
						}
						break;
					case 5:
						System.out.print("Enter the number: ");
						num1 = scanner.nextDouble();
						System.out.println("Result: " + calculator.cosine(num1));
						break;
					case 6:
						exit = true;
						break;
					default:
						System.out.println("Invalid choice. Please try again.");
				}
			} catch (Exception e) {
				System.out.println("Invalid input. Please enter a number.");
				scanner.next(); // Clear the invalid input
			}
		}

		scanner.close();
		System.out.println("Calculator exited.");
	}
}
