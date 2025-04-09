# SpringSimpleBeanBeanFactoryExample

This project demonstrates the use of a simple bean configuration using a BeanFactory in the Spring Framework. 

## Project Structure

- **src/main/java/com/example/beans/SimpleBean.java**: This file defines the `SimpleBean` class with properties and methods to demonstrate a simple bean configuration.
  
- **src/main/resources/beanFactoryConfig.xml**: This XML file contains the configuration for the BeanFactory, defining the `SimpleBean` bean.

- **src/test/java/com/example/beans/SimpleBeanTest.java**: This file contains unit tests for the `SimpleBean` class to ensure its functionality.

- **pom.xml**: This is the Maven configuration file that specifies dependencies and build settings for the project.

## Getting Started

To run this project, follow these steps:

1. **Clone the repository**:
   ```
   git clone <repository-url>
   ```

2. **Navigate to the project directory**:
   ```
   cd SpringSimpleBeanBeanFactoryExample
   ```

3. **Build the project using Maven**:
   ```
   mvn clean install
   ```

4. **Run the application**:
   You can run the application using your IDE or by executing the main method in the `SimpleBean` class.

## Dependencies

This project uses the following dependencies:

- Spring Core
- JUnit (for testing)

Make sure to check the `pom.xml` file for the complete list of dependencies.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.