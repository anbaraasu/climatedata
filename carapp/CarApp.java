import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

// Car class to store car details
class Car {
    private String _name;
    private String _model;
    private String _company;
    private double _price;
    private String _color;

    // Constructor
    public Car(String name, String model, String company, double price, String color) {
        this._name = name;
        this._model = model;
        this._company = company;
        this._price = price;
        this._color = color;
    }

    // Getters and setters
    public String getName() {
        return _name;
    }

    public void setName(String name) {
        this._name = name;
    }

    public String getModel() {
        return _model;
    }

    public void setModel(String model) {
        this._model = model;
    }

    public String getCompany() {
        return _company;
    }

    public void setCompany(String company) {
        this._company = company;
    }

    public double getPrice() {
        return _price;
    }

    public void setPrice(double price) {
        this._price = price;
    }

    public String getColor() {
        return _color;
    }

    public void setColor(String color) {
        this._color = color;
    }

    @Override
    public String toString() {
        return "Car [Name=" + _name + ", Model=" + _model + ", Company=" + _company + ", Price=" + _price + ", Color=" + _color + "]";
    }
}

public class CarApp {
    private static final List<Car> _carList = new ArrayList<>();
    private static final Scanner _scanner = new Scanner(System.in);

    public static void main(String[] args) {
        while (true) {
            try {
                System.out.println("\nCar App Menu:");
                System.out.println("1. Add Car");
                System.out.println("2. Delete Car");
                System.out.println("3. Update Car");
                System.out.println("4. Search Car");
                System.out.println("5. List All Cars");
                System.out.println("6. Exit");
                System.out.print("Enter your choice: ");
                int choice = Integer.parseInt(_scanner.nextLine());

                switch (choice) {
                    case 1:
                        addCar();
                        break;
                    case 2:
                        deleteCar();
                        break;
                    case 3:
                        updateCar();
                        break;
                    case 4:
                        searchCar();
                        break;
                    case 5:
                        listCars();
                        break;
                    case 6:
                        System.out.println("Exiting Car App. Goodbye!");
                        return;
                    default:
                        System.out.println("Invalid choice. Please try again.");
                }
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
            }
        }
    }

    // Add a new car
    private static void addCar() {
        try {
            System.out.print("Enter car name: ");
            String name = _scanner.nextLine();
            System.out.print("Enter car model: ");
            String model = _scanner.nextLine();
            System.out.print("Enter car company: ");
            String company = _scanner.nextLine();
            System.out.print("Enter car price: ");
            double price = Double.parseDouble(_scanner.nextLine());
            System.out.print("Enter car color: ");
            String color = _scanner.nextLine();

            _carList.add(new Car(name, model, company, price, color));
            System.out.println("Car added successfully.");
        } catch (Exception e) {
            System.out.println("Error adding car: " + e.getMessage());
        }
    }

    // Delete a car by name
    private static void deleteCar() {
        try {
            System.out.print("Enter car name to delete: ");
            String name = _scanner.nextLine();
            boolean removed = _carList.removeIf(car -> car.getName().equalsIgnoreCase(name));
            if (removed) {
                System.out.println("Car deleted successfully.");
            } else {
                System.out.println("Car not found.");
            }
        } catch (Exception e) {
            System.out.println("Error deleting car: " + e.getMessage());
        }
    }

    // Update car details by name
    private static void updateCar() {
        try {
            System.out.print("Enter car name to update: ");
            String name = _scanner.nextLine();
            for (Car car : _carList) {
                if (car.getName().equalsIgnoreCase(name)) {
                    System.out.print("Enter new model: ");
                    car.setModel(_scanner.nextLine());
                    System.out.print("Enter new company: ");
                    car.setCompany(_scanner.nextLine());
                    System.out.print("Enter new price: ");
                    car.setPrice(Double.parseDouble(_scanner.nextLine()));
                    System.out.print("Enter new color: ");
                    car.setColor(_scanner.nextLine());
                    System.out.println("Car updated successfully.");
                    return;
                }
            }
            System.out.println("Car not found.");
        } catch (Exception e) {
            System.out.println("Error updating car: " + e.getMessage());
        }
    }

    // Search for a car by name
    private static void searchCar() {
        try {
            System.out.print("Enter car name to search: ");
            String name = _scanner.nextLine();
            for (Car car : _carList) {
                if (car.getName().equalsIgnoreCase(name)) {
                    System.out.println(car);
                    return;
                }
            }
            System.out.println("Car not found.");
        } catch (Exception e) {
            System.out.println("Error searching car: " + e.getMessage());
        }
    }

    // List all cars
    private static void listCars() {
        if (_carList.isEmpty()) {
            System.out.println("No cars available.");
        } else {
            System.out.println("Car List:");
            for (Car car : _carList) {
                System.out.println(car);
            }
        }
    }
}

