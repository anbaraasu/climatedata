
# Sub queries - Query with in Query. Types of Sub queries: 
# Nested Sub Query - Sub query inside another sub query
# 1. Single Row Sub Query - Returns only one row
# 2. Multiple Row Sub Query - Returns multiple rows
# 3. Multiple Column Sub Query - Returns multiple columns
# Correlated Sub Query - Sub query depends on outer query

# Difference betwen Nested Sub Query vs Correlated Sub Query
# Nested Sub Query - Inner query is independent of outer query, inner query is executed first and the result is passed to outer query.
# Correlated Sub Query - Inner query is dependent on outer query, inner query is executed for each row of outer query.

# Example for single row Sub query 
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM
    HR.employees
WHERE
    salary > (SELECT AVG(salary) FROM employees);

# Example for Multiple Row Sub query
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM
    HR.employees
WHERE
    salary IN (SELECT salary FROM employees WHERE department_id = 90);

# Example for Multiple Column Sub query
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM
    HR.employees
WHERE
    (department_id, salary) IN (SELECT department_id, salary FROM employees WHERE department_id = 90);

# Example for correlated sub query
SELECT
    employee_id,
    first_name,
    last_name,
    salary
FROM
    HR.employees e1
WHERE
    salary > (SELECT AVG(salary) FROM employees e2 WHERE e1.department_id = e2.department_id);

# Example for correlated sub query using OE schema 
SELECT
    order_id,
    order_date,
    customer_id,
    order_total
FROM
    OE.orders o
WHERE
    order_total > (SELECT AVG(order_total) FROM orders o2 WHERE o.customer_id = o2.customer_id);
