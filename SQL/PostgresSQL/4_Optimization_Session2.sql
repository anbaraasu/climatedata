DROP TABLE IF EXISTS employees;

-- Without partioning
CREATE TABLE employees (
    employee_id SERIAL ,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT, 
    hire_date DATE,
    salary NUMERIC(10, 2),
    manager_id INT,
    email VARCHAR(100) 
) ;

-- Employee with table partition w.r.t. department id
CREATE TABLE employees (
    employee_id SERIAL ,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT, 
    hire_date DATE,
    salary NUMERIC(10, 2),
    manager_id INT,
    email VARCHAR(100) 
) PARTITION BY RANGE (department_id);

DROP TABLE IF EXISTS employees_1;
CREATE TABLE employees_1 PARTITION OF employees
    FOR VALUES FROM (0) TO (2);

CREATE TABLE employees_2 PARTITION OF employees
    FOR VALUES FROM (2) TO (3);

CREATE TABLE employees_2 PARTITION OF employees
    FOR VALUES FROM (3) TO (4);


-- Insert sample data into "departments"
INSERT INTO departments (department_name, location) VALUES
('IT', 'New York'),
('HR', 'Los Angeles'),
('Finance', 'Chicago'),
('Sales', 'San Francisco');

INSERT INTO departments (department_name, location) VALUES('Admin','New York');

INSERT INTO employees (first_name, last_name, department_id, hire_date, salary, manager_id, email)
values ('John', 'Doe', 2, '2020-01-01', 10000, 1, 'j@hcl.com')
, ('Jane', 'Doe', 2, '2020-01-01', 10000, 1, 'jd@hcl.com')
, ('John', 'Smith', 2, '2020-01-01', 10000, 1, 'js@hcl.com')
, ('Jane', 'Smith', 2, '2020-01-01', 10000, 1, 'jas@hcl.com')
, ('Albert', 'Bot', 2, '2020-01-01', 10000, 1, 'ab@hcl.com');

INSERT INTO employees (first_name, last_name, department_id, hire_date, salary, manager_id, email)
values ('Bob', 'David', 1, '2020-01-01', 10000, 1, 'db@hcl.com'),
('David', 'Miller', 1, '2020-01-15', 85000, 2, 'dm@hcl.com');

SELECT * FROM Employees;
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
    employee_id INT,
    project_id INT REFERENCES projects(project_id),
    PRIMARY KEY (employee_id, project_id),
    hours_worked INT
);



-- Find all employees and their project details - (28ms) without index. 7ms with indexes.
-- Execution cose: 24 ms (without Index)
SELECT 
    first_name, last_name, project_name, start_date, end_date 
FROM
    employees e
JOIN
    employee_projects ep ON e.employee_id = ep.employee_id
JOIN
    projects p ON ep.project_id = p.project_id;


-- using CTE for above query 
-- Execution Cost: 7 ms
WITH employee_project_details AS (
    SELECT 
        first_name, last_name, project_name, start_date, end_date 
    FROM
        employees e
    JOIN
        employee_projects ep ON e.employee_id = ep.employee_id
    JOIN
        projects p ON ep.project_id = p.project_id
)
SELECT * FROM employee_project_details;

-- Using Table partitioning: 8ms
-- Without Table partitioning: 5ms
EXPLAIN ANALYZE
SELECT 
    first_name, last_name, project_name, start_date, end_date 
FROM
    employees e
JOIN
    employee_projects ep ON e.employee_id = ep.employee_id
JOIN
    projects p ON ep.project_id = p.project_id
WHERE 
    department_id = 2;



-- VACCUM ANALYZE:  Used to update the statistics of the table

-- Demo
VACUUM FULL ;