/*
Breaking Down Complex Queries
•	Overcoming SQL limitations
•	Reducing complexity and improving performance
*/

-- 1. Breaking Down Complex Queries
-- Explain:Breaking Down Complex Queries using few realistics usecases with alternal sql solution using Oracle HR Schema

-- Usecase: 1. Rank the customers based on the total sales amount for each month in descending order.
-- Step by Step:
-- 1. get the total sales amount for each month, then add the rank function..












-- Step 1: Find the total sales amount for each customer for each month.
SELECT CustomerID, EXTRACT(YEAR FROM OrderDate) AS OrderYear, EXTRACT(MONTH FROM OrderDate) AS OrderMonth, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY CustomerID, EXTRACT(YEAR FROM OrderDate), EXTRACT(MONTH FROM OrderDate);

-- Step 2: Rank the customers based on the total sales amount for each month in descending order.
SELECT CustomerID, OrderYear, OrderMonth, TotalSales,
       RANK() OVER (PARTITION BY OrderYear, OrderMonth ORDER BY TotalSales DESC) AS SalesRank
FROM (
    SELECT CustomerID, EXTRACT(YEAR FROM OrderDate) AS OrderYear, EXTRACT(MONTH FROM OrderDate) AS OrderMonth, SUM(TotalAmount) AS TotalSales
    FROM Orders
    GROUP BY CustomerID, EXTRACT(YEAR FROM OrderDate), EXTRACT(MONTH FROM OrderDate)
);

-- Overcoming SQL limitations
-- By breaking down complex queries into smaller, more manageable steps, you can overcome these limitations and write more efficient and readable SQL code.
-- Example: If you have a complex query that involves multiple joins, aggregations, and window functions, it can be difficult to write and debug the query all at once. By breaking down the query into smaller steps, you can test each step individually and identify any issues before moving on to the next step.

-- Usecase: Calculate the employee additions for each location, department on year on year
-- Step 1: Find the number of employees added for each location, department, and year.
SELECT Location_ID, Department_Name, EXTRACT(YEAR FROM Hire_Date) AS HireYear, COUNT(Employee_ID) AS EmployeeAdditions
FROM HR.Employees e
JOIN HR.DEPARTMENTS d
ON e.DEPARTMENT_ID=d.DEPARTMENT_ID
GROUP BY Location_ID, Department_Name, EXTRACT(YEAR FROM Hire_Date);



-- Step 2: Calculate the running total of employee additions for each location, department, and year.
SELECT Location_ID, Department_Name, HireYear, EmployeeAdditions,
       SUM(EmployeeAdditions) OVER (PARTITION BY Location_ID, Department_Name ORDER BY HireYear) AS RunningTotal
FROM (
    SELECT Location_ID, Department_Name, EXTRACT(YEAR FROM Hire_Date) AS HireYear, COUNT(Employee_ID) AS EmployeeAdditions
FROM HR.Employees e
JOIN HR.DEPARTMENTS d
ON e.DEPARTMENT_ID=d.DEPARTMENT_ID
GROUP BY Location_ID, Department_Name, EXTRACT(YEAR FROM Hire_Date)
);



-- 2. Reducing Complexity and Improving Performance
-- **********************************************************
-- * 1. Simplify Nested Subqueries                          *
-- **********************************************************

-- Use Case: Get employees who earn more than the average salary of their department.

-- Original (Complex) Solution with nested subquery:
SELECT employee_id, first_name, last_name, department_id, salary
FROM hr.employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM hr.employees
    WHERE department_id = e.department_id
);

-- Optimized Solution: Use analytic function to calculate department average salary
SELECT employee_id, first_name, last_name, department_id, salary
FROM (
    SELECT employee_id, first_name, last_name, department_id, salary,
           AVG(salary) OVER (PARTITION BY department_id) AS avg_dept_salary
    FROM hr.employees
) 
WHERE salary > avg_dept_salary;

-- Explanation:
-- Using AVG as an analytic function avoids a subquery for each employee, 
-- which reduces processing time by scanning the table only once.

-- **********************************************************
-- * 2. Optimize Joins and Filters                          *
-- **********************************************************

-- Use Case: List all employees in the "Sales" department along with department name and job title.

-- Original (Complex) Solution:
SELECT e.employee_id, e.first_name, e.last_name, d.department_name, j.job_title
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id
WHERE d.department_name = 'Sales';

-- Optimized Solution: Filter departments first to reduce dataset before joining
SELECT e.employee_id, e.first_name, e.last_name, d.department_name, j.job_title
FROM (SELECT * FROM departments WHERE department_name = 'Sales') d
JOIN employees e ON e.department_id = d.department_id
JOIN jobs j ON e.job_id = j.job_id;

-- Explanation:
-- Filtering the departments table before joining reduces the number of rows 
-- in the join operation, saving processing time for larger tables.

-- **********************************************************
-- * 3. Efficient Aggregation Using GROUP BY with ROLLUP    *
-- **********************************************************

-- Use Case: Get total salary per department and a grand total across all departments.

-- Original (Complex) Solution with UNION:
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
UNION ALL
SELECT NULL AS department_id, SUM(salary) AS total_salary
FROM employees;

-- Optimized Solution: Use ROLLUP to include subtotals and grand total in a single query
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY ROLLUP (department_id);

-- Explanation:
-- ROLLUP allows subtotal and grand total calculations within one query,
-- simplifying code and reducing the need for additional subqueries or unions.

-- **********************************************************
-- * 4. Minimize Data Using EXISTS for Conditional Filtering*
-- **********************************************************

-- Use Case: Find employees who have at least one dependent.

-- Original (Complex) Solution with JOIN:
SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
JOIN dependents d ON e.employee_id = d.employee_id;

-- Optimized Solution: Use EXISTS to stop processing after the first match for each employee
SELECT employee_id, first_name, last_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM dependents d
    WHERE d.employee_id = e.employee_id
);

-- Explanation:
-- EXISTS stops processing as soon as it finds a match, 
-- which is more efficient than a JOIN when only a match confirmation is needed.

-- **********************************************************
-- * 5. Reduce Data Volume with FETCH FIRST for Pagination  *
-- **********************************************************

-- Use Case: Display the top 5 highest-paid employees in each department.

-- Original (Complex) Solution using RANK() function:
SELECT * FROM (
    SELECT employee_id, first_name, last_name, department_id, salary,
           RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
    FROM employees
) 
WHERE salary_rank <= 5;

-- Optimized Solution: Use FETCH FIRST to limit the rows directly
SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
ORDER BY department_id, salary DESC
FETCH FIRST 5 ROWS WITH TIES;

-- Explanation:
-- FETCH FIRST allows direct limitation of rows per department, 
-- avoiding the complexity of ranking and filtering subqueries.
