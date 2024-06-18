# Spring Boot Preventive Care

This is a Spring Boot project for a Preventive Care application. The application provides REST endpoints for managing care entries. It uses Spring Data JPA with an H2 database for data persistence.

## Project Structure

```
spring-boot-preventive-care
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com
│   │   │       └── preventivecare
│   │   │           ├── config
│   │   │           │   └── SwaggerConfig.java
│   │   │           ├── controller
│   │   │           │   └── PreventiveCareController.java
│   │   │           ├── model
│   │   │           │   └── CareEntry.java
│   │   │           ├── repository
│   │   │           │   └── CareEntryRepository.java
│   │   │           └── service
│   │   │               └── PreventiveCareService.java
│   │   └── resources
│   │       ├── application.properties
│   │       └── data.sql
│   └── test
│       └── java
│           └── com
│               └── preventivecare
│                   └── PreventiveCareApplicationTests.java
├── pom.xml
└── README.md
```

## Files

- `src/main/java/com/preventivecare/config/SwaggerConfig.java`: This file is a configuration class for Swagger. It sets up the Swagger documentation for the API.

- `src/main/java/com/preventivecare/controller/PreventiveCareController.java`: This file contains a controller class `PreventiveCareController` which handles the REST endpoints for the Preventive Care API.

- `src/main/java/com/preventivecare/model/CareEntry.java`: This file contains the `CareEntry` model class which represents a care entry in the application.

- `src/main/java/com/preventivecare/repository/CareEntryRepository.java`: This file contains the `CareEntryRepository` interface which extends `JpaRepository` and provides methods for interacting with the `CareEntry` entity in the database.

- `src/main/java/com/preventivecare/service/PreventiveCareService.java`: This file contains the `PreventiveCareService` class which provides business logic for the Preventive Care API.

- `src/main/resources/application.properties`: This file contains the configuration properties for the Spring Boot application, such as database connection details.

- `src/main/resources/data.sql`: This file contains SQL statements to initialize the H2 database with sample data.

- `src/test/java/com/preventivecare/PreventiveCareApplicationTests.java`: This file contains the test class `PreventiveCareApplicationTests` which can be used to write unit tests for the application.

- `pom.xml`: This file is the Maven configuration file for the project. It lists the dependencies and plugins required for building and running the Spring Boot application.

## Getting Started

To run the application, you can use the following command:

```
mvn spring-boot:run
```

This will start the application on `http://localhost:8080`.

## API Documentation

The API documentation is available using Swagger. You can access it at `http://localhost:8080/swagger-ui.html`.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.