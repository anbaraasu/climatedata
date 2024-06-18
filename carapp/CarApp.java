// Console Java application to store - Car details like name, model, company, price, color, etc. With menu to add, delete, update, search, list car details.

import java.util.Scanner;
import java.util.ArrayList;
import java.util.List;

class Car {
    String name;
    String model;
    String company;
    double price;
    String color;

    public Car(String name, String model, String company, double price, String color) {
        this.name = name;
        this.model = model;
        this.company = company;
        this.price = price;
        this.color = color;
    }

    public void display() {
        System.out.println("Name: " + name);
        System.out.println("Model: " + model);
        System.out.println("Company: " + company);
        System.out.println("Price: " + price);
        System.out.println("Color: " + color);
        System.out.println();
    }
}

public class CarApp {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        List<Car> cars = new ArrayList<>();

        while (true) {
            System.out.println("1. Add Car");
            System.out.println("2. Delete Car");
            System.out.println("3. Update Car");
            System.out.println("4. Search Car");
            System.out.println("5. List Car");
            System.out.println("6. Exit");
            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    System.out.print("Enter name: ");
                    String name = scanner.next();
                    System.out.print("Enter model: ");
                    String model = scanner.next();
                    System.out.print("Enter company: ");
                    String company = scanner.next();
                    System.out.print("Enter price: ");
                    double price = scanner.nextDouble();
                    System.out.print("Enter color: ");
                    String color = scanner.next();
                    Car car = new Car(name, model, company, price, color);
                    cars.add(car);
                    System.out.println("Car added successfully!");
                    break;

                case 2:
                    System.out.print("Enter name: ");
                    name = scanner.next();
                    boolean found = false;
                    for (int i = 0; i < cars.size(); i++) {
                        if (cars.get(i).name.equals(name)) {
                            cars.remove(i);
                            found = true;
                            break;
                        }
                    }
                    if (found) {
                        System.out.println("Car deleted successfully!");
                    } else {
                        System.out.println("Car not found!");
                    }
                    break;

                case 3:
                    System.out.print("Enter name: ");
                    name = scanner.next();
                    found = false;
                    for (int i = 0; i < cars.size(); i++) {
                        if (cars.get(i).name.equals(name)) {
                            System.out.print("Enter new name: ");
                            name = scanner.next();
                            System.out.print("Enter new model: ");
                            model = scanner.next();
                            System.out.print("Enter new company: ");
                            company = scanner.next();
                            System.out.print("Enter new price: ");
                            price = scanner.nextDouble();
                            System.out.print("Enter new color: ");
                            color = scanner.next();
                            cars.get(i).name = name;
                            cars.get(i).model = model;
                            cars.get(i).company = company;
                            cars.get(i).price = price;
                            cars.get(i).color = color;
                            found = true;
                            break;
                        }
                    }
                    if (found) {
                        System.out.println("Car updated successfully!");
                    } else {
                        System.out.println("Car not found!");
                    }
                    break;

                case 4:
                    System.out.print("Enter name: ");
                    name = scanner.next();
                    found = false;
                    for (int i = 0; i < cars.size(); i++) {
                        if (cars.get(i).name.equals(name)) {
                            cars.get(i).display();
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        System.out.println("Car not found!");
                    }
                    break;

                case 5:
                    if (cars.size() == 0) {
                        System.out.println("No cars found!");
                    } else {
                        for (int i = 0; i < cars.size(); i++) {
                            cars.get(i).display();
                        }
                    }
                    break;

                case 6:
                    System.exit(0);
                    break;

                default:
                    
                    System.out.println("Invalid choice!");
            }
        }
    }
}