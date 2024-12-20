# Oracle Join - Combine one or more tables

# Types of Joins

# find emp name and manager name using Self Join using hr.employees 
SELECT
    e.first_name || ' ' || e.last_name AS "Employee",
    m.first_name || ' ' || m.last_name AS "Manager"
FROM
    hr.employees e
JOIN hr.employees m
ON e.manager_id = m.employee_id;

# use case scenario for using MINUS operator in oracle HR schema EMPLOYEES tables
SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
FROM
    hr.employees
MINUS
SELECT
    employee_id,
    first_name,
    last_name,
    job_id,
    salary
FROM
    hr.employees
WHERE
    job_id = 'IT_PROG';