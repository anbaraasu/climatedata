# Spring Framework Project Overview

This repository contains multiple examples demonstrating the use of the Spring Framework. Each example showcases different features and configurations of Spring, including BeanFactory, ApplicationContext, setter injection, constructor injection, and BeanPostProcessor.

## Project Structure

The project is organized into several sub-projects, each focusing on a specific aspect of the Spring Framework:

1. **SpringSimpleBeanBeanFactoryExample**
   - Demonstrates the use of a simple bean configuration using a `BeanFactory`.
   - Contains a `SimpleBean` class and its corresponding XML configuration.

2. **SpringSimpleBeanApplicationContextExample**
   - Similar to the BeanFactory example but uses an `ApplicationContext` for bean management.
   - Includes a `SimpleBean` class with its XML configuration.

3. **SpringEmployeeSetterInjectionExample**
   - Illustrates setter injection in Spring.
   - Contains `Employee` and `Department` classes with their configuration for setter injection.

4. **SpringEmployeeConstuctorInjectionExample**
   - Demonstrates constructor injection in Spring.
   - Similar to the setter injection example but uses constructor-based dependency injection.

5. **SpringBeanPostProcessorExample**
   - Shows how to use a custom `BeanPostProcessor` to modify bean instances during their initialization.
   - Includes a `CustomBeanPostProcessor` class and its configuration.

## Getting Started

To get started with any of the examples, follow these steps:

1. Clone the repository:
   ```
   git clone <repository-url>
   ```

2. Navigate to the desired example directory:
   ```
   cd SpringFramework/<example-directory>
   ```

3. Build the project using Maven:
   ```
   mvn clean install
   ```

4. Run the application:
   ```
   mvn spring-boot:run
   ```

## Dependencies

Each example has its own `pom.xml` file that specifies the necessary dependencies for that particular project. Ensure that you have Maven installed on your machine to manage these dependencies.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.