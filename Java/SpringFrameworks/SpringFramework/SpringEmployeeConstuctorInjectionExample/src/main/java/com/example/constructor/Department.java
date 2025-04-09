package com.example.constructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;

// Department class representing a department in the organization
public class Department {
    // Private fields for department properties
    private String name;
    private String location;

    @Autowired
    private Address address;

    @Bean
    public Address address(){
        return new Address();
    }
    // Constructor for default Department 
    public Department() {
        this.name = "Default Department";
        this.location = "Default Location";
    }

    // Constructor for Department class
    public Department(String name, String location) {
        this.name = name;
        this.location = location;
    }

    // Getter for department name
    public String getName() {
        return name;
    }

    // Setter for department name
    public void setName(String name) {
        this.name = name;
    }

    // Getter for department location
    public String getLocation() {
        return location;
    }

    // Setter for department location
    public void setLocation(String location) {
        this.location = location;
    }
    // Getter for address
    public Address getAddress() {
        return address;
    }

    // Setter for address
    public void setAddress(Address address) {
        this.address = address;
    }

    // Override toString method for better representation
    @Override
    public String toString() {
        return "Department{" +
                "name='" + name + '\'' +
                ", location='" + address + '\'' +
                '}';
    }
}