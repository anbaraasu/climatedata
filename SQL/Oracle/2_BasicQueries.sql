# Basic Queries from HR Schema
-- 1. Display all the employees
SELECT * FROM hr.employees;

-- 2. Display the first name, last name and salary for all employees
SELECT first_name, last_name, salary FROM hr.employees;

-- 3. Display the first name, last name and salary for all employees whose salary is greater than 12000
SELECT first_name, last_name, salary FROM hr.employees WHERE salary > 12000;

-- 4. Display the first name, last name and salary for all employees whose salary is greater than 12000 and less than 15000
SELECT first_name, last_name, salary FROM hr.employees WHERE salary > 12000 AND salary < 15000;

-- 5. Display the full name and salary for all employeees
SELECT first_name || ' ' || last_name AS full_name, salary FROM hr.employees;

-- 6. Display the full name and salary/12 for all employees
SELECT first_name || ' ' || last_name AS full_name, salary/12 AS monthly_salary FROM hr.employees;


-- 7. Display the full name and salary for all employees order by salary
SELECT first_name || ' ' || last_name AS full_name, salary FROM hr.employees ORDER BY salary;

-- 8. Display the full name and salary for all employees order by salary in descending order
SELECT first_name || ' ' || last_name AS full_name, salary FROM hr.employees ORDER BY salary DESC;

-- 9. Display the full name and salary for all employees order by salary in descending order and first name in ascending order
SELECT first_name || ' ' || last_name AS full_name, salary FROM hr.employees ORDER BY salary DESC, first_name;


-- ORDER BY 
-- 1. final step in the SQL execution
-- 2. we have other columns (not in select) can also be used
-- 3. ASC, DESC order types. ASC is default
-- 4. we have multiple columns (256)


-- Relationsl operators - >,<,>=,<=,=,!= 
-- Logical Operators - AND, OR, NOT
-- IS NULL, IFNULL, NVL 

SELECT FIRST_NAME FROM HR.EMPLOYEES WHERE ROWNUM < 6;
SELECT FIRST_NAME FROM HR.EMPLOYEES FETCH FIRST 5 ROWS ONLY;


-- 10. Single Row Functions - Example 1
SELECT first_name, UPPER(first_name) FROM hr.employees;

-- 11. Single Row Functions - Example 2
SELECT first_name, LENGTH(first_name) FROM hr.employees;

-- 12. Single Row Functions - SUBSTR - Polymorphism
SELECT first_name, SUBSTR(first_name, 1, 3) FROM hr.employees;
SELECT first_name, SUBSTR(first_name, 3) FROM hr.employees;

-- 13. Single Row Functions - INSTR - Polymorphism
-- find the first occurrence of e
SELECT INSTR('mytech Technologies','e') FROM DUAL;
-- find the occurrence of e starting from 7 position
SELECT INSTR('mytech Technologies','e',7) FROM DUAL;
-- find the second occurence from 1st position onwards
SELECT INSTR('mytech Technologies','e',1,2) FROM DUAL;
-- find the last occurence 
SELECT INSTR('mytech Technologies','o',-1) FROM DUAL;

SELECT TO_CHAR(123456,'9,99,999.00') FROM DUAL;
SELECT TO_CHAR(123456,'MONTH'), SYSDATE FROM DUAL;

-- 14. Single Row Functions - EXTRACT
SELECT first_name, EXTRACT(DAY FROM hire_date) FROM hr.employees;

-- 15. Single Row Functions - CEIL, FLOOR
SELECT salary, CEIL(salary/1000)*1000 AS ceil_salary, FLOOR(salary/1000)*1000 AS floor_salary, ROUND(salary/1000)*1000 AS rounded_salary  FROM hr.employees;

-- 16. Single Row Functions - TRUNC
SELECT salary, TRUNC(salary, -3) AS trunc_salary FROM hr.employees;

-- 17. Single Row Functions - COUNT, SUM, AVG, MIN, MAX
SELECT COUNT(*), SUM(salary), AVG(salary), MIN(salary), MAX(salary) FROM hr.employees;


-- Mask the other dights and show only last 3 dights of Salary column from employees tables of hr schema

SELECT salary, 
       LPAD(SUBSTR(salary, -3), LENGTH(salary), 'X') AS masked_salary 
FROM hr.employees;

-- Get first 3 month letter from hire_date column of employees table of hr schema
SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'MON') AS MONTH FROM HR.EMPLOYEES;