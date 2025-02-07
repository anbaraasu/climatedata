-- =============================================================
-- PostgreSQL Training Script
-- Covers Sessions: Stored Procedures, Functions, Complex Queries, Optimization, and Performance Fixes
-- Duration: 4 Sessions
-- =============================================================

-- https://www.postgresql.org/about/ 
-- Postgres Overview:
-- - Open-source object-relational database management system (University of California at Berkeley in 1986 by a team led by Michael Stonebraker) 
-- - Supports SQL and is ACID-compliant
-- - Features include: JSON support, Indexing, Replication, and more
-- - Commonly used in web applications and data warehousing

-- Object-relational database management system (ORDBMS): 
-- - Combines the features of both relational databases and object-oriented databases
-- - Supports complex data types, inheritance, and methods

-- Latest version: PostgreSQL 17. PostgreSQL 12 EOL Notice

-- Why Postgres?
-- - Easy to use and setup
-- - Supports complex queries and transactions
-- - Good performance and scalability
-- - Active community and support

-- =============================================================

-- STEP 1: Setup the Training Database
DROP DATABASE IF EXISTS training_db;
CREATE DATABASE training_db;

-- use the database
\c training_db;

-- STEP 2: Create Realistic Tables and Populate Them with Data
-- Create a table for "employees"
DROP TABLE IF EXISTS training_db.employees;
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    hire_date DATE,
    salary NUMERIC(10, 2),
    manager_id INT,
    email VARCHAR(100) UNIQUE
);

-- Create a table for "departments"
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);

-- Create a table for "projects"
DROP TABLE IF EXISTS projects;
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    budget NUMERIC(15, 2)
);

-- Create a table for "employee_projects" (many-to-many relationship)
DROP TABLE IF EXISTS employee_projects;
CREATE TABLE employee_projects (
    employee_id INT REFERENCES employees(employee_id),
    project_id INT REFERENCES projects(project_id),
    PRIMARY KEY (employee_id, project_id),
    hours_worked INT
);



-- Insert sample data into "departments"
INSERT INTO departments (department_name, location) VALUES
('IT', 'New York'),
('HR', 'Los Angeles'),
('Finance', 'Chicago'),
('Sales', 'San Francisco');

-- Insert sample data into "employees"
INSERT INTO employees (first_name, last_name, department_id, hire_date, salary, manager_id, email) VALUES
('John', 'Doe', 1, '2020-01-15', 85000, NULL, 'john.doe@example.com'),
('Jane', 'Smith', 1, '2018-03-10', 95000, 1, 'jane.smith@example.com'),
('Alice', 'Johnson', 2, '2021-06-20', 65000, NULL, 'alice.johnson@example.com'),
('Bob', 'Brown', 3, '2019-11-01', 75000, NULL, 'bob.brown@example.com'),
('Charlie', 'Davis', 4, '2017-05-30', 55000, NULL, 'charlie.davis@example.com');

-- Insert sample data into "projects"
INSERT INTO projects (project_name, start_date, end_date, budget) VALUES
('Website Redesign', '2023-01-01', '2023-06-30', 120000),
('HR System Upgrade', '2023-02-15', '2023-07-15', 80000),
('Financial Analysis Tool', '2023-03-01', '2023-12-31', 150000);

-- Insert sample data into "employee_projects"
INSERT INTO employee_projects (employee_id, project_id, hours_worked) VALUES
(1, 1, 120),
(2, 1, 100),
(3, 2, 150),
(4, 3, 200);

-- =============================================================
-- SESSION #1: Stored Procedures and Functions
-- =============================================================


-- Procedure: Loop from 1 to 10, and print only even numbers
DROP PROCEDURE IF EXISTS print_even_numbers;
CREATE PROCEDURE print_even_numbers()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 10 LOOP
        IF i % 2 = 0 THEN
            RAISE NOTICE 'Even Number: %', i;
        END IF;
        i := i + 1;
    END LOOP;
END;
$$;



CALL print_even_numbers();

-- Procedure: Update employee salary
DROP PROCEDURE IF EXISTS update_salary;
CREATE PROCEDURE update_salary(emp_id INT, new_salary NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employees SET salary = new_salary WHERE employee_id = emp_id;
END;
$$;

-- Procedure: Update employee salary
DROP PROCEDURE IF EXISTS update_salary;
CREATE PROCEDURE update_salary(emp_id INT, new_salary NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE employees SET salary = new_salary WHERE employee_id = emp_id;
    IF NOT FOUND THEN
        RAISE NOTICE 'Employee not found with ID %', emp_id;
    ELSE
        RAISE NOTICE 'Salary updated for Employee ID %', emp_id;
    END IF;
END;
$$;

-- Procedure : INOUT parameter example - salary as input and return the pf amount 
DROP PROCEDURE IF EXISTS calculate_pf;
CREATE PROCEDURE calculate_pf(INOUT salary NUMERIC, OUT pf_amount NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    pf_amount := salary * 0.12;
    salary := salary - pf_amount;
END;
$$;

-- Call the procedure using variables - 10800, 90000
DO $$
DECLARE
    emp_salary NUMERIC := 90000;
    pf NUMERIC;
BEGIN
    RAISE NOTICE 'Employee Salary before PF: %', emp_salary;
    CALL calculate_pf( emp_salary, pf);
    RAISE NOTICE 'Employee Salary after PF: %', emp_salary;
    RAISE NOTICE 'PF Amount: %', pf;
END;
$$;


-- Call the procedure
CALL update_salary(1, 90000);

-- Function: Calculate annual bonus for employees

DROP FUNCTION IF EXISTS calculate_bonus;
CREATE FUNCTION calculate_bonus(emp_id INT) RETURNS NUMERIC AS $$
DECLARE
    emp_salary NUMERIC;
    bonus NUMERIC;
BEGIN
    SELECT salary INTO emp_salary FROM employees WHERE employee_id = emp_id;
    bonus := emp_salary * 0.10;
    RETURN bonus;
END;
$$ LANGUAGE plpgsql;

-- Call the function
SELECT calculate_bonus(1);


-- with exceptoin
DROP FUNCTION IF EXISTS calculate_bonus;
CREATE OR REPLACE FUNCTION calculate_bonus(emp_id INT) RETURNS NUMERIC AS $$
DECLARE
    emp_salary NUMERIC;
    bonus NUMERIC;
BEGIN
    SELECT salary INTO emp_salary FROM employees WHERE employee_id = emp_id;
    IF emp_salary IS NULL THEN
        RAISE EXCEPTION 'Employee not found';
    END IF;
    bonus := emp_salary * 0.10;
    RETURN bonus;
END;
$$ LANGUAGE plpgsql;

-- Call the function
SELECT calculate_bonus(1);


-- LOG table
DROP TABLE IF EXISTS error_log;
CREATE TABLE error_log (
    id SERIAL PRIMARY KEY,
    error_message TEXT,
    error_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    program_name TEXT,
    user_name TEXT DEFAULT current_user
);

CREATE OR REPLACE FUNCTION risky_operation()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
    -- Code that may cause an error
    PERFORM 1 / 0;
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error details
        INSERT INTO error_log (error_message,program_name) VALUES (SQLERRM,'risky_operation');
        -- Raise a notice with the error message
        RAISE NOTICE 'An error occurred: %', SQLERRM;
END;
$$;

-- Call the function to see the error handling in action
SELECT risky_operation();
SELECT * FROM ERROR_LOG;

-- GET STACKED DIAGNOSTICS command is used to obtain detailed information about the error that caused the current exception to be raised. It’s particularly useful in scenarios where you need to log or analyze the error in-depth, such as capturing the error message, SQLSTATE code, and other diagnostic details.

CREATE OR REPLACE FUNCTION get_stacked_diagnostics_example() 
RETURNS void 
AS $$
DECLARE
    error_message TEXT;
    error_detail TEXT;
    error_hint TEXT;
BEGIN
    -- Intentional error for demonstration
    PERFORM 1 / 0;
EXCEPTION
    WHEN OTHERS THEN
        -- Retrieve error details using GET STACKED DIAGNOSTICS
        GET STACKED DIAGNOSTICS error_message = MESSAGE_TEXT,
                                error_detail = PG_EXCEPTION_DETAIL,
                                error_hint = PG_EXCEPTION_HINT;
        
        -- Log the error details
        RAISE NOTICE 'Error Message: %', error_message;
        RAISE NOTICE 'Error Detail: %', error_detail;
        RAISE NOTICE 'Error Hint: %', error_hint;
END;
$$ LANGUAGE plpgsql;

-- Call the function
SELECT get_stacked_diagnostics_example();



--Assignment #1:  Create procedure to print the Employees for under each project

-- Sample output:
-- Project: Website Redesign
-- Employees: John Doe, Jane Smith
-- Total Hours Worked: 220
--(Table and sample data are available in SP_Functions_ex.sql file).. 

