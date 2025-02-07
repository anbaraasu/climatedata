--Advanced SQL Techniques in PostgreSQL
-- 1. Common Table Expressions (CTEs)
-- 2. Window Functions
-- 3. Subqueries
-- 4. Joins
-- 5. Set Operations

-- JOINS in postgresSQL
-- 1. INNER JOIN
-- 2. LEFT JOIN
-- 3. RIGHT JOIN
-- 4. FULL JOIN
-- 5. CROSS JOIN
-- 6. SELF JOIN
-- 7. NATURAL JOIN

-- SUB QUERIES ()
-- 1. Single Row Subquery - =, >, <, >=, <=, <>
-- 2. Multiple Row Subquery - IN, EXISTS, NOT IN, NOT EXISTS
-- 3. Multiple Column Subquery
-- Correlated Subquery - Dependent
-- Nested Subquery - Independent

-- SET Operations (VENN DIAGRAMS)
-- 1. UNION
-- 2. UNION ALL
-- 3. INTERSECT
-- 4. EXCEPT (MINUS)
-- Rules for SET
    -- 1. Number of columns should be same
    -- 2. Data types should be same (family)
    -- 3. Order by should be present in last compound query
    -- 4. Alias name should be given to the columns in first query

-- Window Functions
-- 1. Aggregate Functions - SUM, AVG, COUNT, MIN, MAX
-- 2. Ranking Functions - ROW_NUMBER, RNK, DENSE_RANK, NTILE

-- 3. Analytic Functions - LAG, LEAD, FIRST_VALUE, LAST_VALUE

-- CTE
-- 1. Recursive CTE
-- 2. Non-Recursive CTE

-- Display employee name, project name

SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME, PROJECT_NAME 
FROM 
    EMPLOYEES E 
LEFT JOIN 
    EMPLOYEE_PROJECTS EP
ON
    EP.EMPLOYEE_ID = E.EMPLOYEE_ID
LEFT JOIN
    PROJECTS P
ON 
    P.PROJECT_ID = EP.PROJECT_ID;


-- Sub Queries -- find the employees who salary is above the average salary of HR department 
SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME 
FROM 
    EMPLOYEES E
WHERE 
    SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 2);



-- Sub Queries -- find the employees who salary is above the average salary of each employee's department 


SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME 
FROM 
    EMPLOYEES EO
WHERE 
    SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES EI WHERE EI.DEPARTMENT_ID = EO.DEPARTMENT_ID);

-- FIND DEPART WHERE NO EMPLOYEES - with join
INSERT INTO departments (department_name, location) VALUES('Admin','New York');

SELECT 
    DEPARTMENT_NAME
FROM
    DEPARTMENTS D
LEFT JOIN
    EMPLOYEES E
ON
    D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE
    E.EMPLOYEE_ID IS NULL;


-- FIND DEPART WHERE NO EMPLOYEES - using correlated subquery
SELECT 
    DEPARTMENT_NAME
FROM
    DEPARTMENTS D
WHERE
    NOT EXISTS (SELECT 1 FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID);


-- SET OPERATIONS using union with NULL VALUES
SELECT NULL FROM EMPLOYEES 
UNION ALL
SELECT NULL FROM DEPARTMENTS;


-- -- 2. Ranking Functions - ROW_NUMBER, RNK, DENSE_RANK, NTILE using Salary in employees table
INSERT INTO employees (first_name, last_name, department_id, hire_date, salary, manager_id, email) VALUES
('David', 'Miller', 1, '2020-01-15', 85000, NULL, 'davidmiller@example.com');

SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME, SALARY,
    ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS ROW_RNK,
    RANK() OVER (ORDER BY SALARY DESC) AS RNK,
    DENSE_RANK() OVER (ORDER BY SALARY DESC) AS DENSE_RNK,
    NTILE(3) OVER (ORDER BY SALARY DESC) AS NTILE_RNK
FROM
    EMPLOYEES;








### **Assignment 1: Employee Project Hours and Budget Utilization**

#### **Objective:**  
Generate a report for each employee that lists the projects they are working on, the total hours worked, and the percentage of the project budget utilized based on the total hours worked by all employees in that project.

- For each employee, show:
  - Employee details (`employee_id`, `first_name`, `last_name`, `department_name`).
  - Project details (`project_name`, `hours_worked`, and the percentage of the project budget utilized).
  - Use **OUTER JOINS** to include employees who may not have worked on any project.
  - Use **CTEs** to calculate the total hours worked on each project.


### **Assignment 2: Employee Salary Comparison by Department**

#### **Objective:**  
Create a query to compare each employee’s salary with the average salary of their department. Flag employees who earn more than 25% above the department average.

- For each employee, display:
  - `employee_id`, `first_name`, `last_name`, `department_name`, `salary`.
  - `department_avg_salary` (average salary for the employee''s department).
  - A flag `salary_comparison` indicating if the employee earns more than 25% above the department average.


### **Assignment 3: Projects Managed by Employees vs. Average Budget Utilization**

#### **Objective:**  
Create a report showing each manager''s projects, how much budget has been used compared to the department's average budget utilization for those projects. The report should flag managers whose projects have an average budget utilization more than 10% below the department's average.

- For each manager (an employee with a `manager_id`):
  - Show their managed projects (`project_name`).
  - The total budget utilized across all employees in the project.
  - Compare the total budget utilization against the department’s average and flag if it is more than 10% below average.

-- Analytic Functions - LAG, LEAD, FIRST_VALUE, LAST_VALUE
-- LAG - get the previous row value
-- LEAD - get the next row value
-- FIRST_VALUE - get the first row value
-- LAST_VALUE - get the last row value

-- Display employee name, salary, previous salary, next salary, first salary, last salary
SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME, SALARY,
    LAG(SALARY) OVER (ORDER BY SALARY DESC) AS PREV_EMP_SALARY,
    LEAD(SALARY) OVER (ORDER BY SALARY DESC) AS NEXT_EMP_SALARY,
    FIRST_VALUE(SALARY) OVER (ORDER BY SALARY DESC) AS FIRST_EMP_SALARY,
    LAST_VALUE(SALARY) OVER (ORDER BY SALARY DESC) AS LAST_EMP_SALARY
FROM
    EMPLOYEES;

-- CTE - Common Table Expressions
-- 1. Recursive CTE
-- 2. Non-Recursive CTE

-- CTE(15ms) - Project id, name and use cte exp with employees and display emp-name, proj name.
WITH PROJECTS_CTE AS (
    SELECT 
        PROJECT_ID, PROJECT_NAME
    FROM
        PROJECTS
)
SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME, PROJECT_NAME
FROM
    EMPLOYEES E
JOIN
    EMPLOYEE_PROJECTS EP
ON
    E.EMPLOYEE_ID = EP.EMPLOYEE_ID
JOIN
    PROJECTS_CTE P
ON
    P.PROJECT_ID = EP.PROJECT_ID;


-- wihout CTE 1.1 sec
SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS EMPLOYEE_NAME, PROJECT_NAME
FROM
    EMPLOYEES E
JOIN
    EMPLOYEE_PROJECTS EP
ON
    E.EMPLOYEE_ID = EP.EMPLOYEE_ID
JOIN
    PROJECTS P
ON
    P.PROJECT_ID = EP.PROJECT_ID;


-- Recursive CTE - to find the emp hierarchy, emp_id, manager_id, emp_name, manager_name, level
UPDATE employees SET manager_id = 2 WHERE employee_id = 1;
UPDATE employees SET manager_id = 1 WHERE employee_id = 6;
UPDATE employees SET manager_id = NULL WHERE employee_id = 2;
WITH RECURSIVE EMPLOYEE_HIERARCHY AS (
    SELECT 
        EMPLOYEE_ID, MANAGER_ID, FIRST_NAME || ' ' || LAST_NAME AS EMP_NAME, ' ' AS MGR_NAME
    FROM
        EMPLOYEES
    WHERE
        MANAGER_ID IS NULL
    UNION ALL
    SELECT 
        E.EMPLOYEE_ID, E.MANAGER_ID, E.FIRST_NAME || ' ' || E.LAST_NAME AS EMP_NAME, EH.EMP_NAME AS MGR_NAME
    FROM
        EMPLOYEES E
    JOIN
        EMPLOYEE_HIERARCHY EH
    ON
        E.MANAGER_ID = EH.EMPLOYEE_ID
)
SELECT 
    EMPLOYEE_ID, MANAGER_ID, EMP_NAME, MGR_NAME
FROM
    EMPLOYEE_HIERARCHY;
