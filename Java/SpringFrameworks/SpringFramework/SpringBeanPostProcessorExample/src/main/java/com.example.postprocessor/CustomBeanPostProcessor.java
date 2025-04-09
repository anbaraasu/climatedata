package com.example.postprocessor;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;

// CustomBeanPostProcessor implements the BeanPostProcessor interface
public class CustomBeanPostProcessor implements BeanPostProcessor {

    // This method is called before the bean's initialization callback
    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
        // Add custom logic before the bean is initialized
        System.out.println("Before Initialization: " + beanName);
        return bean; // Return the bean instance
    }

    // This method is called after the bean's initialization callback
    @Override
    public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
        // Add custom logic after the bean is initialized
        System.out.println("After Initialization: " + beanName);
        return bean; // Return the bean instance
    }
}