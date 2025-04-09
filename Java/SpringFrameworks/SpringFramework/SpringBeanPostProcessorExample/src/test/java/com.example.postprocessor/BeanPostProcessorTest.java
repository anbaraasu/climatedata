package com.example.postprocessor;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

// Test class for CustomBeanPostProcessor
public class BeanPostProcessorTest {

    private ApplicationContext context;

    // Set up the application context before each test
    @BeforeEach
    public void setUp() {
        // Load the application context from XML configuration
        context = new ClassPathXmlApplicationContext("postProcessorConfig.xml");
    }

    // Test to verify the CustomBeanPostProcessor functionality
    @Test
    public void testBeanPostProcessor() {
        // Retrieve the SimpleBean from the application context
        SimpleBean simpleBean = (SimpleBean) context.getBean("simpleBean");

        // Assert that the bean is not null
        Assertions.assertNotNull(simpleBean, "The SimpleBean should not be null");

        // Assert that the property has been modified by the post-processor
        Assertions.assertEquals("Modified Value", simpleBean.getProperty(), "The property value should be modified by the post-processor");
    }
}