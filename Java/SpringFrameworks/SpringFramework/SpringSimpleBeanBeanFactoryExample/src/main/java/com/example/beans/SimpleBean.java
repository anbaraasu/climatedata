package com.example.beans;

// SimpleBean class demonstrating a simple bean configuration using a BeanFactory
public class SimpleBean {
    // Private field for the message property
    private String name;

    private int value;

    // Getter for the message property
    public String getName() {
        return name;
    }

    // Setter for the message property
    public void setName(String name) {
        this.name = name;
    }
    // Getter for the value property
    public int getValue() {
        return value;
    }

    // Setter for the value property
    public void setValue(int value) {
        this.value = value;
    }

    //tostring
    @Override
    public String toString() {
        return "SimpleBean{" +
                "name='" + name + '\'' +
                ", value=" + value +
                '}';
    }
   
}