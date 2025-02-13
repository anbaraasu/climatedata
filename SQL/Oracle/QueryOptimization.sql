/*
    Oracle SQL Query Optimization Strategy: 
    1. Use of Indexes
    2. Use of CTE
    3. Use of JOINS
    4. Hints
    5. Table Partitioning

    Explain plan: Used to display the execution plan for a SQL statement without executing it.

    Syntax: EXPLAIN PLAN FOR <SQL Query>
    Use the EXPLAIN PLAN statement to determine the execution plan Oracle Database follows to execute a specified SQL statement. 
    This statement inserts a row describing each step of the execution plan into a specified table. 
    It should be noted that Explain Plan has been deprecated and it is recommended that dbms_xplan be used.
*/


-- Oracle Database Project: Employee Leave Mgmt System Portal:
-- Employee - id, name, dept_name, mgr_id, gender, age 
-- Leave_Request - id, emp_id, start_date, end_date, type_id, reason, status, approved_id
-- Leave types - id, type
-- Holiday - id, date, holiday_name
-- Leave Balance  -- id, leave_type_id, max_leaves


-- create a table for "employees"
DROP TABLE IF EXISTS leave_requests;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS leave_balance;
DROP TABLE IF EXISTS leave_types;
DROP TABLE IF EXISTS holidays;



CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    dept_name VARCHAR(100),
    mgr_id INT REFERENCES employees(employee_id),
    gender CHAR(1), -- M, F, O
    age INT
);

-- Create a table for "leave_types"

CREATE TABLE leave_types (
    leave_type_id INT PRIMARY KEY,
    leave_type VARCHAR(100)
);


-- Create a table for "leave_requests"

CREATE TABLE leave_requests (
    leave_request_id INT PRIMARY KEY,
    employee_id INT REFERENCES employees(employee_id),
    start_date DATE,
    end_date DATE,
    leave_type_id INT REFERENCES leave_types(leave_type_id),
    reason VARCHAR(100),
    leave_status INT,
    approved_id INT REFERENCES employees(employee_id)
);


-- Create a table for "holidays"

CREATE TABLE holidays (
    holiday_id INT PRIMARY KEY,
    holiday_date DATE,
    holiday_name VARCHAR(100)
);

-- Create a table for "leave_balance"

CREATE TABLE leave_balance (
    leave_balance_id INT PRIMARY KEY,
    leave_type_id INT REFERENCES leave_types(leave_type_id),
    max_leaves INT
);

-- insert data for employees
INSERT INTO employees (employee_id, first_name, last_name, dept_name, mgr_id, gender, age) VALUES
(1, 'John', 'Doe', 'HR', NULL, 'M', 30),
(2, 'Jane', 'Doe', 'IT', 1, 'F', 25),
(3, 'Alice', 'Smith', 'HR', 1, 'F', 28),
(4, 'Bob', 'Johnson', 'IT', 2, 'M', 35),
(5, 'Eve', 'Williams', 'HR', 1, 'F', 32),
(6, 'Mike', 'Brown', 'IT', 2, 'M', 40),
(7, 'Sarah', 'Lee', 'HR', 1, 'F', 29),
(8, 'David', 'Wilson', 'IT', 2, 'M', 33),
(9, 'Karen', 'Anderson', 'HR', 1, 'F', 27),
(10, 'Tom', 'Thomas', 'IT', 2, 'M', 31);

-- insert data for leave_types
INSERT INTO leave_types (leave_type_id, leave_type) VALUES
(1, 'Annual Leave'),
(2, 'Resticted Leave'),
(3, 'Maternity Leave'),
(4, 'Paternity Leave');

-- insert data for holidays
INSERT INTO holidays (holiday_id, holiday_date, holiday_name) VALUES
(1, SYSDATE, 'Study Holiday');


-- insert data for leave_balance
INSERT INTO leave_balance (leave_balance_id, leave_type_id, max_leaves) VALUES
(1, 1, 10),
(2, 2, 2),
(3, 3, 15),
(4, 4, 15);

-- insert data for leave_requests
INSERT INTO leave_requests (leave_request_id, employee_id, start_date, end_date, leave_type_id, reason, leave_status, approved_id) VALUES
(1, 2, SYSDATE - 4, SYSDATE - 4, 1, 'Sick Leave', 2, 1),
(2, 4, SYSDATE - 4, SYSDATE - 4, 1, 'Sick Leave', 1, NULL),
(3, 6, SYSDATE - 4, SYSDATE - 4, 1, 'Sick Leave', 1, NULL),
(5, 10, SYSDATE - 4, SYSDATE - 4, 1, 'Sick Leave', 2, 2);

INSERT INTO leave_requests (leave_request_id, employee_id, start_date, end_date, leave_type_id, reason, leave_status, approved_id) VALUES
(4, 2, SYSDATE - 2, SYSDATE - 2, 1, 'Restricted Leave', 2, 1);

-- PLSQL BLOCK - insert 100 data from 6 to 105 for leave_requests table, random employee_id from 10 to, randome leave_type_id from 1 to 4 , radom start_date, end_date before today's date
BEGIN 
    FOR i IN 6..105 LOOP
        INSERT INTO leave_requests (leave_request_id, employee_id, start_date, end_date, leave_type_id, reason, leave_status, approved_id) VALUES
        (i, ROUND(DBMS_RANDOM.VALUE(1, 10)), SYSDATE - ROUND(DBMS_RANDOM.VALUE(1, 30)), SYSDATE - ROUND(DBMS_RANDOM.VALUE(1, 30)), ROUND(DBMS_RANDOM.VALUE(1, 4)), 'Random Leave', ROUND(DBMS_RANDOM.VALUE(1, 2)), NULL);
    END LOOP;
END;



-- Find employee name, leave type, max_leaves, approved_leaves, leave_balance for each employee
-- employees, leave_types, leave_requests, leave_balance
-- Initial Execution Time: 0.02 sec (4 rows)
-- With Index: 0.02 Sec (4 rows)
-- Without indexes Execution Time: 0.021 sec (37 rows)
-- With Index: 0.003 Sec (37 rows)

SELECT 
    full_name, lb.leave_type_id, SUM(lb.max_leaves) max_leaves, SUM(approved_leaves), 
    SUM(lb.max_leaves) - SUM(approved_leaves) AS leave_balance
FROM (SELECT 
    e.first_name || ' ' || e.last_name full_name, lr.leave_type_id, COUNT(lr.leave_request_id) AS approved_leaves
FROM
    employees e
JOIN
    leave_requests lr ON e.employee_id = lr.employee_id
JOIN
    leave_types lt ON lr.leave_type_id = lt.leave_type_id
GROUP BY
    e.first_name, e.last_name, lr.leave_type_id) el
JOIN 
    LEAVE_BALANCE lb ON lb.leave_type_id = el.leave_type_id
GROUP BY full_name, lb.leave_type_id;

-- CREATE INDEX ON leave_type_id in leave_requests and leave_balance tables
CREATE INDEX leave_requests_leave_type_id_idx ON leave_requests(leave_type_id);
CREATE INDEX leave_balance_leave_type_id_idx ON leave_balance(leave_type_id);

-- CREATE INDEX ON employee_id in leave_requests table
CREATE INDEX leave_requests_employee_id_idx ON leave_requests(employee_id);


-- Assignment: 