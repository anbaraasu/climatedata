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

INSERT INTO departments (department_name, location) VALUES('Admin','New York');

-- Insert sample data into "employees"
INSERT INTO employees (first_name, last_name, department_id, hire_date, salary, manager_id, email) VALUES
('John', 'Doe', 1, '2020-01-15', 85000, NULL, 'john.doe@example.com'),
('Jane', 'Smith', 1, '2018-03-10', 95000, 1, 'jane.smith@example.com'),
('Alice', 'Johnson', 2, '2021-06-20', 65000, NULL, 'alice.johnson@example.com'),
('Bob', 'Brown', 3, '2019-11-01', 75000, NULL, 'bob.brown@example.com'),
('Charlie', 'Davis', 4, '2017-05-30', 55000, NULL, 'charlie.davis@example.com');

UPDATE employees SET manager_id = 2 WHERE employee_id = 1;

UPDATE employees SET manager_id = NULL WHERE employee_id = 2;

INSERT INTO employees (first_name, last_name, department_id, hire_date, salary, manager_id, email) VALUES
('David', 'Miller', 1, '2020-01-15', 85000, NULL, 'davidmiller@example.com');
UPDATE employees SET manager_id = 2 WHERE employee_id = 6;

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
CREATE TABLE error_log (
    id SERIAL PRIMARY KEY,
    error_message TEXT,
    error_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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
        INSERT INTO error_log (error_message) VALUES (SQLERRM);
        COMMIT;
        -- Raise a notice with the error message
        RAISE NOTICE 'An error occurred: %', SQLERRM;
END;
$$;

-- Call the function to see the error handling in action
SELECT risky_operation();


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


-- =============================================================
-- SESSION #2: Writing Complex Queries
-- =============================================================
-- witout CTE
SELECT e.first_name, e.last_name, d.department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id;

-- CTE: Common Table Expression: How it works:
-- - Define a temporary result set using a WITH clause
-- - Use the temporary result set in the main query
-- - Improve readability and maintainability of complex queries
-- - Can be used for recursive queries
-- - Can be used to reference the same table multiple times

-- Query: List employees with their department names using CTE
WITH employee_department AS (
    SELECT e.first_name, e.last_name, d.department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
)
SELECT * FROM employee_department;


-- Query: List employees with their department names and location using CTE
WITH employee_department AS (
    SELECT e.first_name, e.last_name, d.department_name, d.location
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
)
SELECT * FROM employee_department;

-- Query: List employees with their department names and location using subquery
-- =============================================================
-- SESSION #3: SQL Query Optimization
-- =============================================================



/*
Optimization Techniques & Approaches
Use Indexes Wisely:

Indexes are crucial for speeding up queries by allowing the database to quickly locate data without scanning the entire table.

Best Practices: Index columns frequently used in WHERE clauses, JOIN operations, and ORDER BY clauses. Avoid over-indexing to prevent overhead on INSERT, UPDATE, and DELETE operations.

Optimize Joins:

Joins can be a major source of inefficiency, especially with large tables.

Best Practices: Use INNER JOIN when possible, as they are generally faster than OUTER JOIN. Ensure columns used in JOIN conditions are indexed and minimize the number of columns retrieved.

Analyze and Vacuum Regularly:

PostgreSQL uses a cost-based optimizer to determine the most efficient way to execute queries.

Best Practices: Regularly run the ANALYZE command to update statistics and VACUUM to reclaim storage space and maintain performance. Schedule these operations, especially on frequently updated tables1.

Use EXPLAIN to Understand Query Plans:

The EXPLAIN command shows the execution plan of a query, helping you understand how the database executes it and identify potential bottlenecks.

Key Indicators in EXPLAIN Plan
Seq Scan (Sequential Scan):

Indicates that the entire table is being scanned row by row.

Action: Consider adding indexes to the columns used in the WHERE clause or JOIN conditions to reduce the need for sequential scans.

Index Scan:

Indicates that the database is using an index to find matching rows.

Action: Ensure that the correct indexes are being used. If the index scan is still slow, consider optimizing the index or query structure.

Bitmap Heap Scan:

Combines an index scan with a bitmap heap scan to efficiently access rows.

Action: This is generally a good sign, but if performance is still an issue, review the query and index design.

Nested Loop Join:

Iterates over one table and for each row, searches the other table.

Action: Ensure that the JOIN conditions are indexed. If the dataset is large, consider using other join types like hash or merge joins.

Hash Join:

Uses a hash table to perform the join operation.

Action: Suitable for larger datasets. Ensure that enough memory is allocated for hash operations (work_mem).

Merge Join:

Sorts both tables and merges the results.

Action: Ensure the columns used in the join are indexed to facilitate sorting. Suitable for large, sorted datasets.

Cost Estimates:

Each step in the execution plan includes a cost estimate (e.g., cost=0.00..431.00).

Action: Compare the costs of different steps. High-cost steps are potential areas for optimization.

Actual Time:

Shows the actual execution time for each step (e.g., actual time=0.031..0.045).

Action: Compare the actual time with the estimated cost. Significant discrepancies may indicate outdated statistics or other issues.

Rows Estimates and Actual Rows:

Shows the estimated number of rows and the actual number of rows processed (e.g., rows=10 vs. actual rows=5).

Action: Large differences between estimated and actual rows suggest that the query planner's statistics might be outdated. Run ANALYZE to update statistics.


Optimize Query Structure:

Simplify Queries: Break down complex queries into simpler ones if possible.

Use Subqueries and CTEs: Common Table Expressions (CTEs) can make queries more readable and sometimes more efficient.

Partitioning:

Partitioning large tables can improve performance by breaking them into smaller, more manageable pieces.


Schema Optimization Example with PostgreSQL
1. Indexes:
Index the columns frequently used in WHERE clauses, JOIN conditions, and ORDER BY clauses.

sql
-- Index for employees table
CREATE INDEX idx_employees_department ON employees(department_id);
CREATE INDEX idx_employees_manager ON employees(manager_id);

-- Index for projects table
CREATE INDEX idx_projects_start_date ON projects(start_date);

-- Index for employee_projects table
CREATE INDEX idx_employee_projects_employee ON employee_projects(employee_id);
CREATE INDEX idx_employee_projects_project ON employee_projects(project_id);
2. Parallel Execution Configuration:
Enable and configure parallel query execution in PostgreSQL.

sql
-- Enable parallel queries
SET max_parallel_workers = 4;
SET max_parall`el_workers_per_gather = 2;

-- Ensure the configuration is persistent
ALTER SYSTEM SET max_parallel_workers = 4;
ALTER SYSTEM SET max_parallel_workers_per_gather = 2;
3. Using EXPLAIN:
Use the EXPLAIN command to understand the query plan and identify potential bottlenecks.

sql
-- Example query with EXPLAIN
EXPLAIN ANALYZE
SELECT e.first_name, e.last_name, d.department_name, p.project_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE e.salary > 50000
  AND p.start_date >= '2022-01-01';


4. Partitioning:
Partition large tables to improve performance.

sql
-- Example partitioning on employees table based on hire_date
CREATE TABLE employees_2022 PARTITION OF employees
FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE employees_2023 PARTITION OF employees
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

5. Task Distribution and Parallel Execution:
Utilize the driver and co-drive concept for parallel execution.

sql
-- Example parallel query
EXPLAIN (ANALYZE, VERBOSE, BUFFERS)
SELECT e.first_name, e.last_name, d.department_name, p.project_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN employee_projects ep ON e.employee_id = ep.employee_id
JOIN projects p ON ep.project_id = p.project_id
WHERE e.salary > 50000
  AND p.start_date >= '2022-01-01'

*/

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
