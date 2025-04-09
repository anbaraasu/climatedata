package com.example.beans;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

// Test class for SimpleBean
public class SimpleBeanTest {

    private SimpleBean simpleBean;

    // Set up the application context before each test
    @BeforeEach
    public void setUp() {
        ApplicationContext context = new ClassPathXmlApplicationContext("beanFactoryConfig.xml");
        simpleBean = (SimpleBean) context.getBean("simpleBean");
    }

    // Test to check if the SimpleBean is not null
    @Test
    public void testSimpleBeanNotNull() {
        Assertions.assertNotNull(simpleBean, "SimpleBean should not be null");
    }

    // Test to check the property value of SimpleBean
    @Test
    public void testSimpleBeanProperty() {
        simpleBean.setProperty("Test Property");
        Assertions.assertEquals("Test Property", simpleBean.getProperty(), "Property value should match");
    }
}