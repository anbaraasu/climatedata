package com.example.constructor;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

// Test class for Employee
public class EmployeeTest {

    private Employee employee;

    // Set up the application context before each test
    @BeforeEach
    public void setUp() {
        // Load the application context from XML configuration
        ApplicationContext context = new ClassPathXmlApplicationContext("constructorInjectionConfig.xml");
        // Retrieve the Employee bean from the context
        employee = (Employee) context.getBean("employee");
    }

    // Test to verify employee's name
    @Test
    public void testEmployeeName() {
        // Assert that the employee's name is as expected
        Assertions.assertEquals("John Doe", employee.getName(), "Employee name should be John Doe");
    }

    // Test to verify employee's department
    @Test
    public void testEmployeeDepartment() {
        // Assert that the employee's department is as expected
        Assertions.assertEquals("Engineering", employee.getDepartment().getName(), "Employee department should be Engineering");
    }
}