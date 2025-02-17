
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

-- Find all employees and their project details - (28ms) without index. 7ms with indexes.
SELECT 
    first_name, last_name, project_name, start_date, end_date 
FROM
    employees e
JOIN
    employee_projects ep ON e.employee_id = ep.employee_id
JOIN
    projects p ON ep.project_id = p.project_id;

-- INDEX 
CREATE INDEX employee_projects_eid ON employee_projects(employee_id);
CREATE INDEX employee_projects_pid ON employee_projects(project_id);


DROP INDEX employee_projects_eid ;
DROP INDEX employee_projects_pid;

-- without index - 7 ms
-- add index and applying index scan - 22 ms
EXPLAIN ANALYZE
SELECT 
    /*+  */
    first_name, last_name, project_name, start_date, end_date 
FROM
    projects p 
JOIN
    employee_projects ep ON p.project_id = ep.project_id
JOIN
    employees e ON ep.employee_id = e.employee_id
WHERE p.project_id = 1;

-- Use merge join to display all employee names and their project details

SET enable_mergejoin = on;
SET enable_hashjoin = ON;

EXPLAIN ANALYZE
SELECT 
    first_name, last_name, project_name, start_date, end_date 
FROM
    employees e
JOIN
    employee_projects ep ON e.employee_id = ep.employee_id
JOIN
    projects p ON ep.project_id = p.project_id;


------ MERGE JOIN EXAMPLE ------------------
CREATE TABLE test_join_tbl1(
    id    INT,
    value TEXT
);

CREATE TABLE test_join_tbl2(
    id          INT,
    description TEXT
);

INSERT INTO
    test_join_tbl1(id, value)
SELECT
    i, 'Value ' || i
FROM
    generate_series(1, 1000000) AS gs(i)
ORDER BY
    random();

INSERT INTO
    test_join_tbl2(id, description)
SELECT
    i, 'Description ' || i
FROM
    generate_series(1, 1000000) AS gs(i)
ORDER BY
    random();

SET enable_mergejoin = off;

EXPLAIN ANALYZE
SELECT
  tbl1.value,
  tbl2.description
FROM
  public.test_join_tbl1 tbl1
JOIN
  public.test_join_tbl2 tbl2
ON
  tbl1.id = tbl2.id;
----------------------------------------------------------

