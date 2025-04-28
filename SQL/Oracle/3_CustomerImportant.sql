--Applying Precedence in a Complex Expression
-- Rules: Order of evaluation
-- 1. Parentheses
-- 2. Exponentiation
-- 3. Multiplication and Division
-- 4. Addition and Subtraction
-- 5. Left to right


--Consider a more complex expression:

SELECT 2 * 3 + 4 / 2 + 10 - 2 FROM dual; 


/* 
The order of evaluation is as follows:

2 * 3 (Multiplication) -> 6
4 / 2 (Division) -> 2
10 + 6 + 2 (Addition) -> 18
18 - 2 (Subtraction) -> 16

*/

-- Limiting Rows Returned in a SQL Statement
-- The SQL SELECT statement allows you to limit the number of rows returned by using the FETCH FIRST clause. The FETCH FIRST clause is an ANSI SQL standard clause that is used to limit the number of rows returned by a query.

SELECT first_name, last_name FROM hr.employees ORDER BY first_name FETCH FIRST 5 ROWS ONLY;
SELECT first_name, last_name FROM hr.employees WHERE ROWNUM <= 6;
-- SELECT first_name, last_name FROM hr.employees LIMIT 5; (SQLITE, MYSQL);

-- Using Substitution Variables
-- Substitution variables are used in SQL*Plus to prompt the user for input values. Substitution variables are defined using the DEFINE command and are referenced using the & symbol.

-- Using the DEFINE and VERIFY commands
-- The DEFINE command is used to define a substitution variable in SQL*Plus. The VERIFY command is used to display the current value of a substitution variable.

DEFINE emp_id = 100;
SELECT first_name, last_name FROM hr.employees WHERE employee_id = &emp_id;



-- Using the ACCEPT command
-- The ACCEPT command is used to prompt the user for input in SQL*Plus. The ACCEPT command takes the following syntax:

ACCEPT variable_name [datatype] [FORMAT format] [PROMPT text]

ACCEPT e_id NUMBER PROMPT 'Enter Employee ID: ';
SELECT first_name, last_name FROM hr.employees WHERE employee_id = &emp_id;

-- Performing arithmetic with date data
-- You can perform arithmetic with date data in Oracle SQL. For example, you can add or subtract days from a date, or calculate the difference between two dates.

SELECT hire_date, hire_date + 7 AS "Hire Date + 7 Days" FROM hr.employees WHERE employee_id = 100;

-- date format  in where condition hire_date = '2023-10-01'
DEFINE FETCH_DT = '2013-03-15';
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE FROM hr.employees WHERE hire_date >= TO_DATE('&FETCH_DT', 'YYYY-MM-DD');


-- Applying the NVL, NULLIF, and COALESCE functions to data
-- The NVL, NULLIF, and COALESCE functions are used to handle NULL values in SQL. The NVL function returns a specified value if the input value is NULL. The NULLIF function returns NULL if the two input values are equal. The COALESCE function returns the first non-NULL value in a list of values.

SELECT first_name, NVL(commission_pct, 0) AS commission_pct FROM hr.employees WHERE employee_id = 100;

-- NULLIF - The NULLIF function returns NULL if the two input values are equal.
SELECT  NULLIF(department_id, 50) FROM hr.employees;

-- COALESCE - The COALESCE function returns the first non-NULL value in a list of values, or NULL if all values are NULL.
SELECT COALESCE(commission_pct, 0) FROM hr.employees WHERE employee_id = 100;

-- Dropping columns and setting column UNUSED
-- You can drop columns from a table using the ALTER TABLE DROP COLUMN statement. You can also set a column to UNUSED using the ALTER TABLE SET UNUSED statement. UNUSED - The UNUSED clause is used to mark a column as unused. The column is not physically removed from the table, but it is no longer accessible to SQL statements.
-- to disable the column instead of dropping it, you can use the SET UNUSED clause.
ALTER TABLE hr.employees DROP COLUMN commission_pct; --(ALTER TABLE EMPLOYEE SET UNUSED (commission_pct);)

ALTER TABLE hr.employees SET UNUSED (commission_pct);

--Creating and using Temporary Tables
--Temporary tables are used to store data temporarily in a database. They are useful for storing intermediate results or temporary data that is needed for a specific task. Temporary tables are created using the CREATE GLOBAL TEMPORARY TABLE statement.

CREATE GLOBAL TEMPORARY TABLE temp_employees
(
    employee_id NUMBER,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50)
);

INSERT INTO temp_employees(employee_id, first_name, last_name)
SELECT employee_id, first_name, last_name FROM hr.employees WHERE department_id = 50;

SELECT * FROM temp_employees;


-- In case of simuntaneously DML query, how to prevent  (FOR UPDATE, NO WAIT, SKIP LOCKED)
-- 1. Use the SELECT FOR UPDATE statement to lock the rows that are being updated.
-- 2. Use the NOWAIT option to prevent waiting for locks to be released.
-- 3. Use the SKIP LOCKED option to skip locked rows and continue processing the remaining rows.
