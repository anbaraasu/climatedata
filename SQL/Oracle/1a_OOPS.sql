# OOPS in Oracle SQL
# Class in Oracle DB: A class is a user-defined data type that encapsulates data and operations into a single unit. It is a blueprint for creating objects.
# Object in Oracle DB: An object is an instance of a class. It is a data structure that contains data and methods to operate on that data.
# Encapsulation in Oracle DB: Encapsulation is the process of combining data and methods into a single unit (class). It helps in hiding the internal details of an object and protecting the data from external access.
# Inheritance in Oracle DB: Inheritance is a mechanism in which a class (child class) inherits properties and methods from another class (parent class). It helps in reusing code and creating a hierarchy of classes.
# Polymorphishm in Oracle DB: Polymorphism is the ability of an object to take on multiple forms. It allows objects of different classes to be treated as objects of a common superclass.

-- Creating a class (object type) in Oracle DB
CREATE TYPE Address AS OBJECT (
    Street VARCHAR2(50),
    City VARCHAR2(50),
    State VARCHAR2(50),
    ZipCode VARCHAR2(10)
);



-- Creating a class (object type) with methods in Oracle DB
CREATE TYPE Person AS OBJECT (
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    BirthDate DATE,
    Email VARCHAR2(50),
    Phone VARCHAR2(15),
    PersonAddress Address,
    MEMBER FUNCTION GetFullName RETURN VARCHAR2
);

-- Creating a table with object type column in Oracle DB
CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    EmployeeName VARCHAR2(100),
    EmployeeAddress Address
);

-- Creating a table with object type column and methods in Oracle DB
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    CustomerInfo Person
);

-- Creating a method for the Person class in Oracle DB
CREATE TYPE BODY Person AS
    MEMBER FUNCTION GetFullName RETURN VARCHAR2 IS
    BEGIN
        RETURN FirstName || ' ' || LastName;
    END;
END;

-- Inserting data into Employees table in Oracle DB
INSERT INTO Employees (EmployeeID, EmployeeName, EmployeeAddress) VALUES (
    1,
    'John Doe',
    Address('123 Main St', 'City', 'State', '12345')
);

-- Inserting data into Customers table in Oracle DB
INSERT INTO Customers (CustomerID, CustomerInfo) VALUES (
    1,
    Person('Jane', 'Smith', '1990-02-20', 'test@example.com', '123-456-7890', Address('456 Elm St', 'City', 'State', '54321'))
);

-- Encapsulation in Oracle DB
-- Creating a class (object type) with private attributes and methods in Oracle DB
CREATE TYPE Person AS OBJECT (
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    BirthDate DATE,
    Email VARCHAR2(50),
    Phone VARCHAR2(15),
    Address Address,
    PRIVATE,
    MEMBER FUNCTION GetFullName RETURN VARCHAR2
);

-- Inheritance in Oracle DB
-- Creating a parent class (object type) in Oracle DB
CREATE TYPE Person AS OBJECT (
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    BirthDate DATE,
    Email VARCHAR2(50),
    Phone VARCHAR2(15),
    Address Address
);

-- Creating a child class (object type) that inherits from the parent class in Oracle DB
CREATE TYPE Employee UNDER Person (
    EmployeeID NUMBER,
    HireDate DATE,
    Salary NUMBER
);

-- Creating manager child class
CREATE TYPE Manager UNDER Employee (
    Department VARCHAR2(50)
);

-- Creating a table with object type column and inheritance in Oracle DB
CREATE TABLE Employees (
    EmployeeInfo Employee
);

-- GetFullName Method implementation in Oracle DB
CREATE TYPE BODY Person AS
    MEMBER FUNCTION GetFullName RETURN VARCHAR2 IS
    BEGIN
        RETURN FirstName || ' : ' || LastName;
    END;
END;

-- Polymorphism - Poly - Many. Morph - forms. Many Forms
SELECT TO_CHAR(123.45) FROM DUAL; -- Output: '123.45'
SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY') FROM DUAL; -- Output: '01-JAN-2022'
SELECT TO_CHAR(123456, '999,999') FROM DUAL; -- Output: ' 123,456'



