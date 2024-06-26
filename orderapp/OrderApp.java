// Java Console App, CRUD on Product - ID, Name, Description, Quantity, Unit Price. Menu with List, Add and Exit. Handle empty list, input mismatch, invalid choice errors and exception.

import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class OrderApp {
    private static final Scanner scanner = new Scanner(System.in);
    private static final List<Product> products = new ArrayList<>();

    public static void main(String[] args) {
        while (true) {
            System.out.println("1. List Products");
            System.out.println("2. Add Product");
            System.out.println("3. Exit");
            System.out.print("Enter choice: ");
            try {
                int choice = scanner.nextInt();
                scanner.nextLine();
                switch (choice) {
                    case 1:
                        listProducts();
                        break;
                    case 2:
                        addProduct();
                        break;
                    case 3:
                        System.out.println("Exiting...");
                        return;
                    default:
                        System.out.println("Invalid choice, try again.");
                }
            } catch (InputMismatchException e) {
                System.out.println("Invalid input, please enter a number.");
                scanner.nextLine();
            }
        }
    }

    private static void listProducts() {
        if (products.isEmpty()) {
            System.out.println("No products available.");
        } else {
            System.out.println("ID\tName\tDescription\tQuantity\tUnit Price");
            for (Product product : products) {
                System.out.println(product);
            }
        }
    }

    private static void addProduct() {
        System.out.print("Enter ID: ");
        int id = scanner.nextInt();
        scanner.nextLine();
        System.out.print("Enter Name: ");
        String name = scanner.nextLine();
        System.out.print("Enter Description: ");
        String description = scanner.nextLine();
        System.out.print("Enter Quantity: ");
        int quantity;
        try {
            quantity = scanner.nextInt();
        } catch (InputMismatchException e) {
            System.out.println("Invalid input for Quantity, please enter a valid integer.");
            scanner.nextLine();
            return;
        }
        
        System.out.print("Enter Unit Price: ");
        double unitPrice;
        try {
            unitPrice = scanner.nextDouble();
        } catch (InputMismatchException e) {
            System.out.println("Invalid input for Unit Price, please enter a valid decimal number.");
            scanner.nextLine();
            return;
        }
        scanner.nextLine();
        products.add(new Product(id, name, description, quantity, unitPrice));
        System.out.println("Product added successfully.");
    }
}

class Product {
    private final int id;
    private final String name;
    private final String description;
    private final int quantity;
    private final double unitPrice;

    public Product(int id, String name, String description, int quantity, double unitPrice) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    @Override
    public String toString() {
        return id + "\t" + name + "\t" + description + "\t" + quantity + "\t" + unitPrice;
    }
}



