//Console Java application to store 
//Car details like name, model, company, price, color, etc.
//have menu to add, delete, update, search, list car details.

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class CarApp {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		List<Car> cars = new ArrayList<>();
		int choice = 0;
		do {
			System.out.println("1. Add Car");
			System.out.println("2. Delete Car");
			System.out.println("3. Update Car");
			System.out.println("4. Search Car");
			System.out.println("5. List Car");
			System.out.println("6. Exit");
			System.out.println("Enter your choice: ");
			choice = scanner.nextInt();
			switch (choice) {
			case 1:
				System.out.println("Enter Car Name: ");
				String name = scanner.next();
				System.out.println("Enter Car Model: ");
				String model = scanner.next();
				System.out.println("Enter Car Company: ");
				String company = scanner.next();
				System.out.println("Enter Car Price: ");
				double price = scanner.nextDouble();
				System.out.println("Enter Car Color: ");
				String color = scanner.next();
				Car car = new Car(name, model, company, price, color);
				cars.add(car);
				break;
			case 2:
				System.out.println("Enter Car Name: ");
				String deleteName = scanner.next();
				for (Car c : cars) {
					if (c.getName().equals(deleteName)) {
						cars.remove(c);
						break;
					}
				}
				break;
			case 3:
				System.out.println("Enter Car Name: ");
				String updateName = scanner.next();
				for (Car c : cars) {
					if (c.getName().equals(updateName)) {
						System.out.println("Enter Car Model: ");
						c.setModel(scanner.next());
						System.out.println("Enter Car Company: ");
						c.setCompany(scanner.next());
						System.out.println("Enter Car Price: ");
						c.setPrice(scanner.nextDouble());
						System.out.println("Enter Car Color: ");
						c.setColor(scanner.next());
						break;
					}
				}
				break;
			case 4:
				System.out.println("Enter Car Name: ");
				String searchName = scanner.next();
				for (Car c : cars) {
					if (c.getName().equals(searchName)) {
						System.out.println(c);
						break;
					}
				}
				break;
			case 5:
				for (Car c : cars) {
					System.out.println(c);
				}
				break;
			case 6:
				System.out.println("Exiting...");
				break;
			default:
				System.out.println("Invalid choice");
			}
		} while (choice != 6);
		scanner.close();
	}
}

//car class for above application
class Car {
	private String name;
	private String model;
	private String company;
	private double price;
	private String color;

	public Car(String name, String model, String company, double price, String color) {
		this.name = name;
		this.model = model;
		this.company = company;
		this.price = price;
		this.color = color;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	@Override
    public String toString() {
        return "Car [name=" + name + ", model=" + model + ", company=" + company + ", price=" + price + ", color=" + color
                + "]";
    }
}