import java.util.Scanner;

public class CalcMain {
	
	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		Calculator c = new Calculator();
		int choice;
		boolean flag = true;
		
		while(flag) {
			System.out.println("1. Add");
			System.out.println("2. Substract");
			System.out.println("3. Multiply");
			System.out.println("4. Divide");
			System.out.println("5. Exit");
			System.out.println("Enter your choice: ");
			choice = sc.nextInt();
			
			switch(choice) {
			case 1:
				System.out.print("Enter first number: ");
				int a = sc.nextInt();
				System.out.print("Enter second number: ");
				int b = sc.nextInt();
				System.out.println("Result: " + c.add(a, b));
				break;
				
			case 2:
				System.out.print("Enter first number: ");
				int a1 = sc.nextInt();
				System.out.print("Enter second number: ");
				int b1 = sc.nextInt();
				System.out.println("Result: " + c.substract(a1, b1));
				break;
				
			case 3:
				System.out.print("Enter first number: ");
				int a2 = sc.nextInt();
				System.out.print("Enter second number: ");
				int b2 = sc.nextInt();
				System.out.println("Result: " + c.multiply(a2, b2));
				break;
				
			case 4:
				System.out.print("Enter first number: ");
				int a3 = sc.nextInt();
				System.out.print("Enter second number: ");
				int b3 = sc.nextInt();
				try {
					System.out.println("Result: " + c.divide(a3, b3));
				} catch (ArithmeticException ex) {
					System.out.println("Error: " + ex.getMessage());
				}
				break;
				
			case 5:
				flag = false;
				break;
				
			default:
				System.out.println("Invalid choice!");
				break;
			}
		}
		sc.close();
	}

}
