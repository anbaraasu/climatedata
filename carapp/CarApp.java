// Console Java application to store - Car details like name, model, company, price, color, etc. With menu to add, delete, update, search, list car details.

import java.util.Scanner;

class Car {
    String name;
    String model;
    String company;
    double price;
    String color;
    String fuelType;
    int year;

    Car(String name, String model, String company, double price, String color, String fuelType, int year) {
        this.name = name;
        this.model = model;
        this.company = company;
        this.price = price;
        this.color = color;
        this.fuelType = fuelType;
        this.year = year;
    }

    void display() {
        System.out.println("Name: " + name);
        System.out.println("Model: " + model);
        System.out.println("Company: " + company);
        System.out.println("Price: " + price);
        System.out.println("Color: " + color);
        System.out.println("Fuel Type: " + fuelType);
        System.out.println("Year: " + year);
    }
}

