# ClimatePortal

This is a Spring Boot web project that consumes a Spring Boot REST API web service. It uses JSP, Bootstrap, and JavaScript for the frontend.

## Project Structure

```
ClimatePortal
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com
│   │   │       └── sme
│   │   │           ├── ClimatePortalApplication.java
│   │   │           ├── controller
│   │   │           │   └── ClimateController.java
│   │   │           ├── model
│   │   │           │   └── Climate.java
│   │   │           └── service
│   │   │               └── ClimateService.java
│   │   ├── resources
│   │   │   ├── application.properties
│   │   │   └── static
│   │   │       ├── css
│   │   │       │   └── bootstrap.min.css
│   │   │       ├── js
│   │   │       │   └── script.js
│   │   │       └── images
│   │   └── webapp
│   │       ├── WEB-INF
│   │       │   └── views
│   │       │       └── climate.jsp
│   │       └── index.jsp
│   └── test
│       └── java
│           └── com
│               └── sme
│                   └── ClimatePortalApplicationTests.java
├── .mvn
│   └── wrapper
│       ├── MavenWrapperDownloader.java
│       ├── maven-wrapper.jar
│       └── maven-wrapper.properties
├── mvnw
├── mvnw.cmd
├── pom.xml
└── README.md
```

## Project Description

The project consists of the following files:

- `src/main/java/com/sme/ClimatePortalApplication.java`: This file is the entry point of the Spring Boot application. It contains the main method to start the application.

- `src/main/java/com/sme/controller/ClimateController.java`: This file contains the controller class `ClimateController` which handles the REST API endpoints for consuming the Spring Boot REST API web service.

- `src/main/java/com/sme/model/Climate.java`: This file contains the `Climate` model class which represents the data structure for climate information.

- `src/main/java/com/sme/service/ClimateService.java`: This file contains the `ClimateService` class which provides the business logic for fetching climate data from the Spring Boot REST API web service.

- `src/main/resources/application.properties`: This file contains the configuration properties for the Spring Boot application.

- `src/main/resources/static/css/bootstrap.min.css`: This file is a CSS file that contains the Bootstrap styles for the web application.

- `src/main/resources/static/js/script.js`: This file is a JavaScript file that contains custom scripts for the web application.

- `src/main/resources/static/images`: This directory contains images used in the web application.

- `src/main/webapp/WEB-INF/views/climate.jsp`: This file is a JSP file that represents the view for displaying climate data.

- `src/main/webapp/index.jsp`: This file is a JSP file that represents the home page of the web application.

- `src/test/java/com/sme/ClimatePortalApplicationTests.java`: This file contains the test class `ClimatePortalApplicationTests` for testing the Spring Boot application.

- `.mvn/wrapper/MavenWrapperDownloader.java`: This file is a Maven wrapper file used for downloading the Maven wrapper files.

- `.mvn/wrapper/maven-wrapper.jar`: This file is a Maven wrapper file used for running Maven commands.

- `.mvn/wrapper/maven-wrapper.properties`: This file is a Maven wrapper configuration file.

- `mvnw`: This file is a shell script used for running Maven commands on Unix-based systems.

- `mvnw.cmd`: This file is a batch script used for running Maven commands on Windows systems.

- `pom.xml`: This file is the Maven project object model (POM) file that contains the project configuration and dependencies.

## Getting Started

To run the project, follow these steps:

1. Clone the repository.

2. Open the project in your preferred IDE.

3. Build the project using Maven.

4. Run the `ClimatePortalApplication` class to start the Spring Boot application.

5. Access the web application at `http://localhost:8080`.

## Dependencies

The project uses the following dependencies:

- Spring Boot
- Spring MVC
- JSP
- Bootstrap
- JavaScript

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.