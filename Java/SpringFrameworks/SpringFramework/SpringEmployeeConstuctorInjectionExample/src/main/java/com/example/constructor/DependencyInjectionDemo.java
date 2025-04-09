package com.example.constructor;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class DependencyInjectionDemo {
    public static void main(String[] args) {

        //Application Context   Spring configuration file "consturctorInjectionConfig.xml"
        ApplicationContext context = new ClassPathXmlApplicationContext("beanConfig.xml");
        // Retrieve the Employee bean from the application context
        Employee employee = (Employee) context.getBean("employee");

        // Print the employee details
        System.out.println(employee);

    }    
}
