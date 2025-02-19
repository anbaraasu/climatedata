-- Oracle Database : SQL Optimization

/*
common use cases and the types of indexes that would benefit them:

1. Primary Key Index
Use Case: Ensuring uniqueness and fast access to rows based on the primary key.
Index Type: B-tree index (default for primary keys).
Example:
2. Foreign Key Index
Use Case: Improving join performance between related tables.
Index Type: B-tree index.
Example:
3. Clustered Index
Use Case: Optimizing queries that retrieve data based on a range of values or that sort data by a specific column.
Index Type: Clustered index.
Example:
4. Bitmap Index
Use Case: Optimizing queries on columns with low cardinality (few unique values), such as gender or status columns.
Index Type: Bitmap index.
Example:
5. Composite Index
Use Case: Optimizing queries that filter on multiple columns.
Index Type: Composite index.
Example:
6. Function-Based Index
Use Case: Optimizing queries that use functions on columns in the WHERE clause.
Index Type: Function-based index.
Example:
7. Full-Text Index
Use Case: Optimizing text search queries.
Index Type: Full-text index.
Example:
Example SQL Code with Indexes
*/
-- Drop sequences if they exist
DROP SEQUENCE employees_seq_sq;
DROP SEQUENCE departments_seq_sq;
DROP SEQUENCE projects_seq_sq;

-- Create sequences for primary keys
CREATE SEQUENCE employees_seq_sq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE departments_seq_sq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE projects_seq_sq START WITH 1 INCREMENT BY 1;

DROP TABLE employee_projects_sq CASCADE CONSTRAINTS;
CREATE TABLE employee_projects_sq (
    employee_id NUMBER REFERENCES employees_sq(employee_id),
    project_id NUMBER REFERENCES projects_sq(project_id),
    PRIMARY KEY (employee_id, project_id),
    hours_worked NUMBER
);

DROP TABLE employees_sq CASCADE CONSTRAINTS;
CREATE TABLE employees_sq (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    department_id NUMBER REFERENCES departments_sq(department_id), 
    hire_date DATE,
    salary NUMBER(10, 2),
    manager_id NUMBER
);

-- Create a table for "departments"
DROP TABLE departments_sq CASCADE CONSTRAINTS;
CREATE TABLE departments_sq (
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(100),
    location VARCHAR2(100)
);

-- Create a table for "projects"
DROP TABLE projects_sq CASCADE CONSTRAINTS;
CREATE TABLE projects_sq (
    project_id NUMBER PRIMARY KEY,
    project_name VARCHAR2(100),
    start_date DATE,
    end_date DATE,
    budget NUMBER(15, 2)
);

-- Create indexes
CREATE INDEX employees_sq_dept_id_idx ON employees_sq(department_id);
CREATE CLUSTER INDEX departments_sq_cluster_idx ON departments_sq(location);
CREATE BITMAP INDEX employees_sq_dept_id_bitmap_idx ON employees_sq(department_id);
CREATE INDEX employee_projects_sq_composite_idx ON employee_projects_sq(employee_id, project_id);
CREATE INDEX employees_sq_upper_last_name_idx ON employees_sq(UPPER(last_name));
CREATE INDEX employees_sq_text_idx ON employees_sq(first_name, last_name) INDEXTYPE IS CTXSYS.CONTEXT;

-- Insert data into the "departments" table
INSERT INTO departments_sq (department_id, department_name, location) VALUES (departments_seq_sq.NEXTVAL, 'HR', 'New York');
INSERT INTO departments_sq (department_id, department_name, location) VALUES (departments_seq_sq.NEXTVAL, 'Engineering', 'San Francisco');
INSERT INTO departments_sq (department_id, department_name, location) VALUES (departments_seq_sq.NEXTVAL, 'Marketing', 'Los Angeles');
INSERT INTO departments_sq (department_id, department_name, location) VALUES (departments_seq_sq.NEXTVAL, 'Finance', 'Chicago');
INSERT INTO departments_sq (department_id, department_name, location) VALUES (departments_seq_sq.NEXTVAL, 'Sales', 'Seattle');
INSERT INTO departments_sq (department_id, department_name, location) VALUES (departments_seq_sq.NEXTVAL, 'Operations', 'Dallas');
INSERT INTO departments_sq (department_id, department_name, location) VALUES (departments_seq_sq.NEXTVAL, 'IT', 'Boston');
INSERT INTO departments_sq (department_id, department_name, location) VALUES (departments_seq_sq.NEXTVAL, 'Legal', 'Washington DC');
INSERT INTO departments_sq (department_id, department_name, location) VALUES (departments_seq_sq.NEXTVAL, 'Customer Service', 'Atlanta');
INSERT INTO departments_sq (department_id, department_name, location) VALUES (departments_seq_sq.NEXTVAL, 'Research and Development', 'Denver');
INSERT INTO departments_sq (department_id, department_name, location) VALUES (departments_seq_sq.NEXTVAL, 'Quality Assurance', 'Houston');

-- Insert data into the "employees" table
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'John', 'Doe', 1, TO_DATE('2010-01-01', 'YYYY-MM-DD'), 50000, NULL);
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'Jane', 'Smith', 1, TO_DATE('2012-05-15', 'YYYY-MM-DD'), 60000, 1);
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'Alice', 'Johnson', 1, TO_DATE('2014-03-20', 'YYYY-MM-DD'), 55000, 2);
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'Bob', 'Brown', 1, TO_DATE('2015-08-10', 'YYYY-MM-DD'), 65000, 1);
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'Eve', 'Williams', 3, TO_DATE('2016-04-25', 'YYYY-MM-DD'), 70000, NULL);
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'Mike', 'Jones', 3, TO_DATE('2018-01-15', 'YYYY-MM-DD'), 75000, 5);
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'Sarah', 'Lee', 3, TO_DATE('2019-06-30', 'YYYY-MM-DD'), 60000, 5);
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'Chris', 'Davis', 3, TO_DATE('2020-02-20', 'YYYY-MM-DD'), 65000, 5);
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'Amy', 'Miller', 2, TO_DATE('2021-09-10', 'YYYY-MM-DD'), 80000, NULL);
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'Tom', 'Wilson', 4, TO_DATE('2022-03-05', 'YYYY-MM-DD'), 70000, NULL);
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'Emily', 'Moore', 5, TO_DATE('2023-11-20', 'YYYY-MM-DD'), 75000, NULL);
INSERT INTO employees_sq (employee_id, first_name, last_name, department_id, hire_date, salary, manager_id) VALUES (employees_seq_sq.NEXTVAL, 'Kevin', 'Taylor', 6, TO_DATE('2024-07-15', 'YYYY-MM-DD'), 85000, NULL);

-- Insert data into the "projects" table
INSERT INTO projects_sq (project_id, project_name, start_date, end_date, budget) VALUES (projects_seq_sq.NEXTVAL, 'Project A', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2021-01-01', 'YYYY-MM-DD'), 100000);
INSERT INTO projects_sq (project_id, project_name, start_date, end_date, budget) VALUES (projects_seq_sq.NEXTVAL, 'Project B', TO_DATE('2021-02-01', 'YYYY-MM-DD'), TO_DATE('2022-02-01', 'YYYY-MM-DD'), 150000);
INSERT INTO projects_sq (project_id, project_name, start_date, end_date, budget) VALUES (projects_seq_sq.NEXTVAL, 'Project C', TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2023-03-01', 'YYYY-MM-DD'), 200000);
INSERT INTO projects_sq (project_id, project_name, start_date, end_date, budget) VALUES (projects_seq_sq.NEXTVAL, 'Project D', TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-01', 'YYYY-MM-DD'), 250000);
INSERT INTO projects_sq (project_id, project_name, start_date, end_date, budget) VALUES (projects_seq_sq.NEXTVAL, 'Project E', TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2025-05-01', 'YYYY-MM-DD'), 300000);
INSERT INTO projects_sq (project_id, project_name, start_date, end_date, budget) VALUES (projects_seq_sq.NEXTVAL, 'Project F', TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2026-06-01', 'YYYY-MM-DD'), 150000);
INSERT INTO projects_sq (project_id, project_name, start_date, end_date, budget) VALUES (projects_seq_sq.NEXTVAL, 'Project G', TO_DATE('2026-07-01', 'YYYY-MM-DD'), TO_DATE('2027-07-01', 'YYYY-MM-DD'), 200000);
INSERT INTO projects_sq (project_id, project_name, start_date, end_date, budget) VALUES (projects_seq_sq.NEXTVAL, 'Project H', TO_DATE('2027-08-01', 'YYYY-MM-DD'), TO_DATE('2028-08-01', 'YYYY-MM-DD'), 250000);
INSERT INTO projects_sq (project_id, project_name, start_date, end_date, budget) VALUES (projects_seq_sq.NEXTVAL, 'Project I', TO_DATE('2028-09-01', 'YYYY-MM-DD'), TO_DATE('2029-09-01', 'YYYY-MM-DD'), 100000);
INSERT INTO projects_sq (project_id, project_name, start_date, end_date, budget) VALUES (projects_seq_sq.NEXTVAL, 'Project J', TO_DATE('2029-10-01', 'YYYY-MM-DD'), TO_DATE('2030-10-01', 'YYYY-MM-DD'), 150000);

-- Insert data into the "employee_projects" table
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (1, 1, 100);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (1, 2, 150);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (2, 1, 200);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (2, 2, 100);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (3, 1, 150);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (3, 2, 250);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (4, 1, 100);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (4, 2, 200);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (5, 3, 150);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (5, 4, 200);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (6, 3, 100);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (6, 4, 150);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (7, 3, 200);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (7, 4, 250);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (8, 3, 150);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (8, 4, 200);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (9, 5, 100);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (9, 6, 150);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (10, 7, 200);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (11, 8, 250);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (12, 9, 150);
INSERT INTO employee_projects_sq (employee_id, project_id, hours_worked) VALUES (12, 10, 200);

-- Query to find the employees who have worked on more than one project
SELECT e.first_name, e.last_name, COUNT(ep.project_id) AS num_projects
FROM employees_sq e
JOIN employee_projects_sq ep ON e.employee_id = ep.employee_id
GROUP BY e.first_name, e.last_name
HAVING COUNT(ep.project_id) > 1;

-- Query to find the employees who have worked on more than one project with index hint
SELECT /*+ INDEX(ep employee_projects_sq_pid_idx) */ e.first_name, e.last_name, COUNT(ep.project_id) AS num_projects
FROM employees_sq e
JOIN employee_projects_sq ep ON e.employee_id = ep.employee_id
GROUP BY e.first_name, e.last_name
HAVING COUNT(ep.project_id) > 1;

-- SYS_C00354408 avoid index using hint
SELECT /*+ NO_INDEX(ep SYS_C00354408) */ e.first_name, e.last_name, COUNT(ep.project_id) AS num_projects
FROM employees_sq e
JOIN employee_projects_sq ep ON e.employee_id = ep.employee_id
GROUP BY e.first_name, e.last_name
HAVING COUNT(ep.project_id) > 1;

-- Create an index on the employee_projects_sq table
CREATE INDEX employee_projects_sq_pid_idx ON employee_projects_sq(project_id);

-- Query to find the employees who have worked on more than one project with index hint
SELECT /*+ INDEX(ep employee_projects_sq_pid_idx) */ e.first_name, e.last_name, COUNT(ep.project_id) AS num_projects
FROM employees_sq e
JOIN employee_projects_sq ep ON e.employee_id = ep.employee_id
GROUP BY e.first_name, e.last_name
HAVING COUNT(ep.project_id) > 1;

-- create clustered index on location of dept
CREATE CLUSTER INDEX departments_sq_cluster_idx ON departments_sq(location);

-- bitmap index on dept id in emp table
CREATE BITMAP INDEX employees_sq_dept_id_bitmap_idx ON employees_sq(department_id);

-- execution time: 0.007 seconds
SELECT /*+ INDEX(ep SYS_C00354408) */ e.first_name, e.last_name, COUNT(ep.project_id) AS num_projects
FROM employees_sq e
JOIN employee_projects_sq ep ON e.employee_id = ep.employee_id
GROUP BY e.first_name, e.last_name
HAVING COUNT(ep.project_id) > 1;

-- execution time: 0.007 seconds
SELECT /*+ NO_INDEX(ep SYS_C00354408) */ e.first_name, e.last_name, COUNT(ep.project_id) AS num_projects
FROM employees_sq e
JOIN employee_projects_sq ep ON e.employee_id = ep.employee_id
GROUP BY e.first_name, e.last_name
HAVING COUNT(ep.project_id) > 1;
