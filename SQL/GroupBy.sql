# Oracle Group by clause used to group the result set by one or more columns. It is used in collaboration with the SELECT statement to arrange identical data into groups. The GROUP BY clause follows the WHERE clause in a SELECT statement and precedes the ORDER BY clause.
# Group By + Having clause is used to filter the group of rows formed by the Group By clause.

# Example 1: Group By with Count for each department name how many employees using HR schema
SELECT
    department_name,
    COUNT(employee_id) AS "Number of Employees"
FROM
    employees E 
    JOIN departments D
    ON E.department_id = D.department_id
GROUP BY
    E.department_id;

# Example 2: Group By with Avg salary of each department name using HR schema
SELECT
    department_name,
    AVG(salary) AS "Average Salary"
FROM
    employees E 
    JOIN departments D
    ON E.department_id = D.department_id
GROUP BY
    E.department_id;


# Example 3: Group By with Having clause to filter the group of rows formed by the Group By clause - using OE schema.
SELECT
    name,
    COUNT(oi.order_id) AS "Number of Orders"
FROM
    OE.order_items oi
JOIN
    OE.orders o
ON oi.order_id = o.order_id
JOIN OE.products p
ON oi.product_id = p.product_id
GROUP BY
    name;

