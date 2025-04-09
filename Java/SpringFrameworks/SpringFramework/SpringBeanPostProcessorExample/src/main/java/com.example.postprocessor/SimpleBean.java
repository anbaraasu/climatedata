package com.example.postprocessor;

// SimpleBean class representing a simple bean with a name property
public class SimpleBean {
    // Private field for the name property
    private String _name;

    // Constructor to initialize the SimpleBean with a name
    public SimpleBean(String name) {
        this._name = name;
    }

    // Getter for the name property
    public String getName() {
        return _name;
    }

    // Setter for the name property
    public void setName(String name) {
        this._name = name;
    }

    // Method to display the name of the bean
    public void display() {
        System.out.println("SimpleBean name: " + _name);
    }
}