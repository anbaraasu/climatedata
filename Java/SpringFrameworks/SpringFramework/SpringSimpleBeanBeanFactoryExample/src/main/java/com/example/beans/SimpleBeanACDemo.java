package com.example.beans;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SimpleBeanACDemo {
    public static void main(String[] args) {
        // Load the bean configuration file
        ApplicationContext context = new ClassPathXmlApplicationContext("beanFactoryConfig.xml");

        // Retrieve the SimpleBean instance
        SimpleBean simpleBean = (SimpleBean) context.getBean("simpleBean");

        // Use the SimpleBean instance
        System.out.println(simpleBean);
    }
}
