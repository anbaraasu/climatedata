# Spring Boot Preventive Care

This is a Spring Boot project for a Preventive Care application. It provides RESTful APIs for managing patients, doctors, medical records, hospitals, and diagnoses.

## Project Structure

The project has the following directory structure:

```
spring-boot-preventive-care
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com
│   │   │       └── preventivecare
│   │   │           ├── config
│   │   │           ├── controller
│   │   │           ├── model
│   │   │           │   ├── Patient.java
│   │   │           │   ├── Doctor.java
│   │   │           │   ├── MedicalRecord.java
│   │   │           │   ├── Hospital.java
│   │   │           │   └── Diagnosis.java
│   │   │           ├── repository
│   │   │           └── service
│   │   └── resources
│   │       ├── application.properties
│   │       └── data.sql
│   └── test
│       ├── java
│       │   └── com
│       │       └── preventivecare
│       │           ├── controller
│       │           ├── repository
│       │           └── service
│       │               ├── MockitoExtension.java
│       │               └── PreventiveCareServiceTest.java
├── pom.xml
└── README.md
```

## Entities

The project includes the following model entities:

- `Patient`: Represents a patient.
- `Doctor`: Represents a doctor.
- `MedicalRecord`: Represents a medical record.
- `Hospital`: Represents a hospital.
- `Diagnosis`: Represents a diagnosis.

## Technologies Used

The project utilizes the following technologies:

- Spring Data REST: For creating RESTful APIs.
- Spring Data JPA: For data persistence.
- H2 Database: In-memory database for development and testing.
- Lombok: For reducing boilerplate code.
- DevTools: For automatic application restarts during development.
- Mockito: For unit testing.
- JUnit 5: For writing test cases.

## Getting Started

To run the project, follow these steps:

1. Clone the repository.
2. Open the project in your preferred IDE.
3. Build the project using Maven.
4. Run the application.
5. Access the APIs using the provided endpoints.

## API Documentation

The API documentation is generated using Swagger. You can access the documentation by running the application and visiting the following URL: `http://localhost:8080/swagger-ui.html`

## Configuration

The application properties can be found in the `application.properties` file. You can modify the properties according to your requirements.

## Database Initialization

The project includes a `data.sql` file in the resources directory. This file contains the SQL script to initialize the H2 database with sample data.

## Testing

The project includes unit tests for the services using Mockito and JUnit 5. You can run the tests using your preferred testing framework.

## License

This project is licensed under the [MIT License](LICENSE).

For more information, please refer to the [documentation](https://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/).
