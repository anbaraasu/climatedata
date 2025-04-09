package com.example.constructor;

/**
 * Employee class representing an employee with a name and department.
 */
public class Employee {
    // Private fields for employee properties
    private final String _name; // Employee name
    private final Department _department; // Employee's department

    
    /**
     * Constructor for Employee class.
     * 
     * @param name       the name of the employee
     * @param department the department of the employee
     */
    public Employee(String name, Department department) {
        this._name = name;
        this._department = department;
    }

    /**
     * Gets the name of the employee.
     * 
     * @return the name of the employee
     */
    public String getName() {
        return _name;
    }

    /**
     * Gets the department of the employee.
     * 
     * @return the department of the employee
     */
    public Department getDepartment() {
        return _department;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "name='" + _name + '\'' +
                ", department=" + _department +
                '}';
    }
}