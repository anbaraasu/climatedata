// Console Java application to store - Car details like name, model, company, price, color, etc. With menu to add, delete, update, search, list car details. 
import java.util.ArrayList;
import java.util.Scanner;
import java.util.Iterator;

public class CarApp {
    private static ArrayList<Car> carList = new ArrayList<Car>();

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int option = 0;
        do {
            System.out.println("\n1. Add Car\n2. Delete Car\n3. Update Car\n4. Search Car\n5. List all Cars\n6. Exit\nEnter your choice: ");
            option = sc.nextInt();
            sc.nextLine();
            switch (option) {
                case 1:
                    addCar(sc);
                    break;
                case 2:
                    deleteCar(sc);
                    break;
                case 3:
                    updateCar(sc);
                    break;
                case 4:
                    searchCar(sc);
                    break;
                case 5:
                    listCars();
                    break;
                case 6:
                    System.out.println("Exiting the program...");
                    break;
                default:
                    System.out.println("Invalid option. Please enter again.");
                    break;
            }
        } while (option != 6);
        sc.close();
    }

    private static void addCar(Scanner sc) {
        System.out.println("Enter car name: ");
        String name = sc.nextLine();
        System.out.println("Enter car model: ");
        String model = sc.nextLine();
        System.out.println("Enter car company: ");
        String company = sc.nextLine();
        System.out.println("Enter car price: ");
        double price = sc.nextDouble();
        sc.nextLine();
        System.out.println("Enter car color: ");
        String color = sc.nextLine();
        Car car = new Car(name, model, company, price, color);
        carList.add(car);
        System.out.println("Car added successfully.");
    }

    private static void deleteCar(Scanner sc) {
        System.out.println("Enter car name to delete: ");
        String name = sc.nextLine();
        Iterator<Car> it = carList.iterator();
        while (it.hasNext()) {
            Car car = it.next();
            if (car.getName().equals(name)) {
                it.remove();
                System.out.println("Car deleted successfully.");
                return;
            }
        }
        System.out.println("Car not found.");
    }

    private static void updateCar(Scanner sc) {
        System.out.println("Enter car name to update: ");
        String name = sc.nextLine();
        for (Car car : carList) {
            if (car.getName().equals(name)) {
                System.out.println("Enter car model: ");
                car.setModel(sc.nextLine());
                System.out.println("Enter car company: ");
                car.setCompany(sc.nextLine());
                System.out.println("Enter car price: ");
                car.setPrice(sc.nextDouble());
                sc.nextLine();
                System.out.println("Enter car color: ");
                car.setColor(sc.nextLine());
                System.out.println("Car updated successfully.");
                return;
            }
        }
        System.out.println("Car not found.");
    }

    private static void searchCar(Scanner sc) {
        System.out.println("Enter car name to search: ");
        String name = sc.nextLine();
        for (Car car : carList) {
            if (car.getName().equals(name)) {
                System.out.println("Car found: " + car);
                return;
            }
        }
        System.out.println("Car not found.");
    }

    private static void listCars() {
        if (carList.isEmpty()) {
            System.out.println("No cars found.");
            return;
        }
        System.out.println("List of cars:");
        for (Car car : carList) {
            System.out.println(car);
        }
    }
}