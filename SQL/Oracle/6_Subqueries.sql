--  Sub queries - Query with in Query. Types of Sub queries: 
--  Nested Sub Query - Sub query inside another sub query
    --  1. Single Row Sub Query - Returns only one row
        -- =, >, <, >=, <=, <>, !=
    --  2. Multiple Row Sub Query - Returns multiple rows
        -- IN,  NOT IN
    --  3. Multiple Column Sub Query - Returns multiple columns
--  Correlated Sub Query - Sub query depends on outer query
    --  1. Single Row Sub Query - Returns only one row
        -- =, >, <, >=, <=, <>, !=
    --  2. Multiple Row Sub Query - Returns multiple rows
        -- EXISTS, NOT EXISTS

--  Difference betwen Nested Sub Query vs Correlated Sub Query
--  Nested Sub Query - Inner query is independent of outer query, inner query is executed first and the result is passed to outer query.
--  Correlated Sub Query - Inner query is dependent on outer query, inner query is executed for each row of outer query.

-- DEMO of subquery using insert and select
--  Example for Nested Sub query
INSERT INTO HR.employees (employee_id, first_name, last_name, salary, hire_date)
SELECT empno, enam, NULL, sal, sysdate
FROM scott.emp
WHERE salary > (SELECT AVG(salary) FROM employees);

--- Example for update + select
UPDATE HR.employees
SET salary = salary * 1.1
WHERE employee_id IN (SELECT employee_id FROM HR.employees WHERE department_id = 90);



--  Example for single row Sub query 
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM
    HR.employees
WHERE
    salary > (SELECT AVG(salary) FROM employees);

--  Example for Multiple Row Sub query
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM
    HR.employees
WHERE
    salary IN (SELECT salary FROM employees WHERE department_id = 90);

--  Example for Multiple Column Sub query
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM
    HR.employees
WHERE
    (department_id, salary) IN (SELECT department_id, salary FROM employees WHERE department_id = 90);

- Example for Multiple Column Sub query using OE schema w.r.t product
-- FIND all the procucts which are having same quantity and price as in products table
SELECT
    product_id,
    product_name,
    product_price
FROM
    OE.products
WHERE
    (quantity, product_price) IN (SELECT quantity, product_price FROM products);

-- Example for correlated sub query
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM
    HR.employees e1
WHERE
    salary > (SELECT AVG(salary) FROM employees e2 WHERE e1.department_id = e2.department_id);

-- correlated sub query using OE schema, list all the customers who have placed orders
SELECT
    customer_name
FROM
    OE.customers c
WHERE
    EXISTS (SELECT 1 FROM OE.orders o WHERE o.customer_id = c.customer_id);

--using join using OE schema, list all the customers who have placed orders
SELECT
    c.customer_name
FROM
    OE.customers c
JOIN
    OE.orders o ON c.customer_id = o.customer_id;
    

--  Example for correlated sub query using OE schema 
SELECT
    order_id,
    order_date,
    customer_id,
    order_total
FROM
    OE.orders o
WHERE
    order_total > (SELECT AVG(order_total) FROM orders o2 WHERE o.customer_id = o2.customer_id);

https://www.geeksforgeeks.org/difference-between-nested-subquery-correlated-subquery-and-join-operation/

    DECLARE
        v_start_time TIMESTAMP;
        v_end_time TIMESTAMP;
        v_execution_time INTERVAL DAY TO SECOND;
        v_count NUMBER;
    BEGIN
        -- Record the start time
        v_start_time := SYSTIMESTAMP;

        -- Execute the query
        SELECT COUNT(*) INTO v_count FROM (SELECT CUST_FIRST_NAME FROM OE.CUSTOMERS c
    WHERE NOT EXISTS (SELECT 1 FROM OE.ORDERS o WHERE o.CUSTOMER_ID = c.CUSTOMER_ID));

        -- Record the end time
        v_end_time := SYSTIMESTAMP;

        -- Calculate the execution time
        v_execution_time := v_end_time - v_start_time;

        -- Output the execution time
        DBMS_OUTPUT.PUT_LINE('Execution Time: ' || v_execution_time || ' for records:' || v_count);
    END;
    /

SELECT CUST_FIRST_NAME FROM OE.CUSTOMERS WHERE CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM OE.ORDERS)

--  PLSQL Block to find the execution time of query select count(*) from hr.employees;



--  Class Room EX: OE Schema - Find the customer name who have not placed any order.. 
SELECT CUST_FIRST_NAME FROM OE.CUSTOMERS c
WHERE NOT EXISTS (SELECT 1 FROM OE.ORDERS o WHERE o.CUSTOMER_ID = c.CUSTOMER_ID)

DECLARE
    v_start_time TIMESTAMP;
    v_end_time TIMESTAMP;
    v_execution_time INTERVAL DAY TO SECOND;
    v_count NUMBER;
BEGIN
    -- Record the start time
    v_start_time := SYSTIMESTAMP;

    -- Execute the query
    SELECT COUNT(*) INTO v_count FROM (SELECT CUST_FIRST_NAME FROM OE.CUSTOMERS c
WHERE NOT EXISTS (SELECT 1 FROM OE.ORDERS o WHERE o.CUSTOMER_ID = c.CUSTOMER_ID));

    -- Record the end time
    v_end_time := SYSTIMESTAMP;

    -- Calculate the execution time
    v_execution_time := v_end_time - v_start_time;

    -- Output the execution time
    DBMS_OUTPUT.PUT_LINE('Execution Time: ' || v_execution_time);
END;
/