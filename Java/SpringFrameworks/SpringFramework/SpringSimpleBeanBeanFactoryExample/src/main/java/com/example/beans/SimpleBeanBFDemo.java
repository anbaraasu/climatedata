package com.example.beans;

import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;

// SimpleBean class demonstrating a simple bean configuration using a BeanFactory
public class SimpleBeanBFDemo {
    public static void main(String[] args) {
        // Load the bean configuration file
        BeanFactory factory = new XmlBeanFactory(new ClassPathResource("beanFactoryConfig.xml"));

        // Retrieve the SimpleBean instance
        SimpleBean simpleBean = (SimpleBean) factory.getBean("simpleBean");

        // Use the SimpleBean instance
        System.out.println(simpleBean);
    }
}