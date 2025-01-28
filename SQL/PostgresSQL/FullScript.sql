-- =============================================================
-- PostgreSQL Training Script
-- Covers Sessions: Stored Procedures, Functions, Complex Queries, Optimization, and Performance Fixes
-- Duration: 4 Sessions
-- =============================================================

-- STEP 1: Setup the Training Database
DROP DATABASE IF EXISTS training_db;
CREATE DATABASE training_db;
\c training_db;

-- STEP 2: Create Realistic Tables and Populate Them with Data
-- Create a table for "employees"
DROP TABLE IF EXISTS employees;
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

-- Function: Calculate annual bonus for employees
DROP FUNCTION IF EXISTS calculate_bonus;
CREATE FUNCTION calculate_bonus(emp_id INT) RETURNS NUMERIC AS $$
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

-- Call the procedure
CALL update_salary(1, 90000);

-- =============================================================
-- SESSION #2: Writing Complex Queries
-- =============================================================

-- Query: List employees with their department names
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Query: Total budget for all projects
SELECT SUM(budget) AS total_budget FROM projects;

-- Query: Employees working on a specific project
SELECT e.first_name, e.last_name, p.project_name
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE p.project_name = 'Website Redesign';

-- =============================================================
-- SESSION #3: SQL Query Optimization
-- =============================================================

-- Example: Create indexes for optimization
CREATE INDEX idx_employees_department_id ON employees(department_id);
CREATE INDEX idx_projects_start_date ON projects(start_date);

-- Query Plan Analysis
EXPLAIN ANALYZE 
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- =============================================================
-- SESSION #4: Fixing SQL Performance Issues
-- =============================================================

-- Example: Analyzing a slow query
EXPLAIN ANALYZE 
SELECT e.first_name, e.last_name, p.project_name
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE p.budget > 100000;

-- Optimized Query: Use indexes and reduce joins
EXPLAIN ANALYZE 
SELECT e.first_name, e.last_name, p.project_name
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE p.budget > 100000
  AND e.department_id = 1;

-- =============================================================
-- BACKUP AND RECOVERY (Theory)
-- Backup Example
-- pg_dump -U postgres -F c -b -v -f "/path/to/backup_file.backup" training_db;

-- Restore Example
-- pg_restore -U postgres -d training_db "/path/to/backup_file.backup";

-- =============================================================
-- END OF SCRIPT
-- =============================================================
