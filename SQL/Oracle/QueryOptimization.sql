/*
    Oracle SQL Query Optimization Strategy: 
    
    1. Use of Indexes
    2. Table Partitioning
    3. Use of CTE
    4. Use of JOINS
    5. Hints    

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


-- with out partioning
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(100) UNIQUE,
    last_name VARCHAR(100),
    dept_name VARCHAR(100),
    mgr_id INT REFERENCES employees(employee_id),
    gender CHAR(1), -- M, F, O
    age INT
);

-- employee with partition on mgr_id 
-- CREATE TABLE employees (
--     employee_id INT PRIMARY KEY,
--     first_name VARCHAR(100) UNIQUE,
--     last_name VARCHAR(100),
--     dept_name VARCHAR(100),
--     mgr_id INT REFERENCES employees(employee_id),
--     gender CHAR(1), -- M, F, O
--     age INT
-- ) PARTITION BY RANGE (mgr_id) (
--     PARTITION p0 VALUES LESS THAN (2),
--     PARTITION p1 VALUES LESS THAN (4),
--     PARTITION p_null VALUES LESS THAN (MAXVALUE) -- Partition for NULL values
-- );



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
(1, 'John', 'Doe', 'HR', NULL, 'M', 30);
INSERT INTO employees (employee_id, first_name, last_name, dept_name, mgr_id, gender, age) VALUES
(2, 'Jane', 'Doe', 'IT', 1, 'F', 25);
INSERT INTO employees (employee_id, first_name, last_name, dept_name, mgr_id, gender, age) VALUES
(3, 'Alice', 'Smith', 'HR', 1, 'F', 28);
INSERT INTO employees (employee_id, first_name, last_name, dept_name, mgr_id, gender, age) VALUES
(4, 'Bob', 'Johnson', 'IT', 2, 'M', 35);
INSERT INTO employees (employee_id, first_name, last_name, dept_name, mgr_id, gender, age) VALUES
(5, 'Eve', 'Williams', 'HR', 1, 'F', 32);
INSERT INTO employees (employee_id, first_name, last_name, dept_name, mgr_id, gender, age) VALUES
(6, 'Mike', 'Brown', 'IT', 2, 'M', 40);
INSERT INTO employees (employee_id, first_name, last_name, dept_name, mgr_id, gender, age) VALUES
(7, 'Sarah', 'Lee', 'HR', 1, 'F', 29);
INSERT INTO employees (employee_id, first_name, last_name, dept_name, mgr_id, gender, age) VALUES
(8, 'David', 'Wilson', 'IT', 2, 'M', 33);
INSERT INTO employees (employee_id, first_name, last_name, dept_name, mgr_id, gender, age) VALUES
(9, 'Karen', 'Anderson', 'HR', 1, 'F', 27);
INSERT INTO employees (employee_id, first_name, last_name, dept_name, mgr_id, gender, age) VALUES
(10, 'Tom', 'Thomas', 'IT', 2, 'M', 31);

-- insert data for leave_types
INSERT INTO leave_types (leave_type_id, leave_type) VALUES
(1, 'Annual Leave');
INSERT INTO leave_types (leave_type_id, leave_type) VALUES(2, 'Resticted Leave');
INSERT INTO leave_types (leave_type_id, leave_type) VALUES(3, 'Maternity Leave');
INSERT INTO leave_types (leave_type_id, leave_type) VALUES(4, 'Paternity Leave');

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
(1, 2, SYSDATE - 4, SYSDATE - 4, 1, 'Sick Leave', 2, 1);
INSERT INTO leave_requests (leave_request_id, employee_id, start_date, end_date, leave_type_id, reason, leave_status, approved_id) VALUES(2, 4, SYSDATE - 4, SYSDATE - 4, 1, 'Sick Leave', 1, NULL);
INSERT INTO leave_requests (leave_request_id, employee_id, start_date, end_date, leave_type_id, reason, leave_status, approved_id) VALUES(3, 6, SYSDATE - 4, SYSDATE - 4, 1, 'Sick Leave', 1, NULL);
INSERT INTO leave_requests (leave_request_id, employee_id, start_date, end_date, leave_type_id, reason, leave_status, approved_id) VALUES(5, 10, SYSDATE - 4, SYSDATE - 4, 1, 'Sick Leave', 2, 2);

INSERT INTO leave_requests (leave_request_id, employee_id, start_date, end_date, leave_type_id, reason, leave_status, approved_id) VALUES
(4, 2, SYSDATE - 2, SYSDATE - 2, 1, 'Restricted Leave', 2, 1);

-- PLSQL BLOCK - insert 100 data from 6 to 105 for leave_requests table, random employee_id from 10 to, randome leave_type_id from 1 to 4 , radom start_date, end_date before today's date
BEGIN 
    FOR i IN 6..105 LOOP
        INSERT INTO leave_requests (leave_request_id, employee_id, start_date, end_date, leave_type_id, reason, leave_status, approved_id) VALUES
        (i, ROUND(DBMS_RANDOM.VALUE(1, 10)), SYSDATE - ROUND(DBMS_RANDOM.VALUE(1, 30)), SYSDATE - ROUND(DBMS_RANDOM.VALUE(1, 30)), ROUND(DBMS_RANDOM.VALUE(1, 4)), 'Random Leave', ROUND(DBMS_RANDOM.VALUE(1, 2)), NULL);
    END LOOP;
END;

SELECT 
    e.first_name, leave_type, COUNT(lr.leave_request_id) AS no_of_leave_days
FROM
    leave_requests lr
JOIN
    employees e ON e.employee_id = lr.employee_id
JOIN
    leave_types lt ON lr.leave_type_id = lt.leave_type_id
GROUP BY
    e.first_name, leave_type;


-- Find employee name, leave type, max_leaves, approved_leaves, leave_balance for each employee
-- employees, leave_types, leave_requests, leave_balance
-- Initial Execution Time: 0.02 sec (4 rows)
-- With Index: 0.02 Sec (4 rows)
-- Without indexes Execution Time: 0.021 sec (37 rows)
-- With Index: 0.003 Sec (37 rows)

WITH employee_leaves AS (
    SELECT 
        e.first_name || ' ' || e.last_name AS full_name, 
        lr.leave_type_id, 
        COUNT(lr.leave_request_id) AS approved_leaves
    FROM
        employees e
    JOIN
        leave_requests lr ON e.employee_id = lr.employee_id
    JOIN
        leave_types lt ON lr.leave_type_id = lt.leave_type_id
    GROUP BY
        e.first_name, e.last_name, lr.leave_type_id
)
SELECT 
    full_name, 
    lb.leave_type_id, 
    SUM(lb.max_leaves) AS max_leaves, 
    SUM(approved_leaves), 
    SUM(lb.max_leaves) - SUM(approved_leaves) AS leave_balance
FROM 
    employee_leaves el
JOIN 
    leave_balance lb ON lb.leave_type_id = el.leave_type_id
GROUP BY 
    full_name, lb.leave_type_id;

-- CREATE INDEX ON leave_type_id in leave_requests and leave_balance tables
CREATE INDEX leave_requests_leave_type_id_idx ON leave_requests(leave_type_id);
CREATE INDEX leave_balance_leave_type_id_idx ON leave_balance(leave_type_id);

-- CREATE INDEX ON employee_id in leave_requests table
CREATE INDEX leave_requests_employee_id_idx ON leave_requests(employee_id);

DROP INDEX  leave_requests_leave_type_id_idx;
DROP INDEX  leave_balance_leave_type_id_idx;
DROP INDEX  leave_requests_employee_id_idx;

-- EXPLAIN PLAN <SET STATEMENT_ID = 'TIM'> FOR <QUERY>
-- SET AUTOTRACE ON
-- SET AUTOTRACE TRACEONLY

DROP TABLE PLAN_TABLE;
create table PLAN_TABLE ( 
        statement_id       varchar2(255), 
        plan_id            number, 
        timestamp          date, 
        remarks            varchar2(4000), 
        operation          varchar2(100), 
        options            varchar2(255), 
        object_node        varchar2(128), 
        object_owner       varchar2(100), 
        object_name        varchar2(100), 
        object_alias       varchar2(65), 
        object_instance    numeric, 
        object_type        varchar2(100), 
        optimizer          varchar2(255), 
        search_columns     number, 
        id                 numeric, 
        parent_id          numeric, 
        depth              numeric, 
        position           numeric, 
        cost               numeric, 
        cardinality        numeric, 
        bytes              numeric, 
        other_tag          varchar2(255), 
        partition_start    varchar2(255), 
        partition_stop     varchar2(255), 
        partition_id       numeric, 
        other              long, 
        distribution       varchar2(100), 
        cpu_cost           numeric, 
        io_cost            numeric, 
        temp_space         numeric, 
        access_predicates  varchar2(4000), 
        filter_predicates  varchar2(4000), 
        projection         varchar2(4000), 
        time               numeric, 
        qblock_name        varchar2(100), 
        other_xml          clob 
);

delete from plan_table;

EXPLAIN PLAN   
    SET STATEMENT_ID = 'GETLEAVEBAL'  
    FOR  SELECT 
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


SELECT LPAD('............................',2*(LEVEL-1))||operation operation, options,   
object_name, position   
    FROM plan_table   
    START WITH id = 0 AND statement_id = 'GETLEAVEBAL'  
    CONNECT BY PRIOR id = parent_id AND statement_id = 'GETLEAVEBAL';


-- Use of CTE
-- Common Table Expressions (CTE) are temporary result sets that are defined within the execution scope of a single SELECT, INSERT, UPDATE, DELETE, or CREATE VIEW statement.



-- Hints: Used to provide information to the optimizer on how to execute the SQL statement
-- Syntax: /*+ HINT */

-- Sample Hints: 
-- /*+ INDEX(table_name index_name) */
-- /*+ FULL(table_name) */
-- /*+ ORDERED */
-- /*+ LEADING(table_name) */
-- /*+ USE_MERGE(table_name) */
-- /*+ USE_HASH(table_name) */

-- hints to not to use index
-- /*+ NO_INDEX(table_name index_name) */




-- Display first name, no of leave days 
-- Time: 0.01 sec where leave_request is leading
-- Time: 0.01 sec where employee is leading
-- Time: 0.003 second with index with employee as leading
-- Time: 0.016 second with index with leave_requests as leading
SELECT 
    e.first_name, leave_type, COUNT(lr.leave_request_id) AS no_of_leave_days
FROM
    leave_requests lr
JOIN
    employees e ON e.employee_id = lr.employee_id
JOIN
    leave_types lt ON lr.leave_type_id = lt.leave_type_id
GROUP BY
    e.first_name, leave_type;


-- time taken: -0.011 seconds index
-- WITH  CTE: - 0.017 second
-- WITH CTE w/o index: 0.013 sec (37 rows)
-- Without indexes Execution Time: 0.021 sec (37 rows)

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


WITH employee_leaves AS (
    SELECT 
        e.first_name || ' ' || e.last_name AS full_name, 
        lr.leave_type_id, 
        COUNT(lr.leave_request_id) AS approved_leaves
    FROM
        employees e
    JOIN
        leave_requests lr ON e.employee_id = lr.employee_id
    JOIN
        leave_types lt ON lr.leave_type_id = lt.leave_type_id
    GROUP BY
        e.first_name, e.last_name, lr.leave_type_id
)
SELECT 
    full_name, 
    lb.leave_type_id, 
    SUM(lb.max_leaves) AS max_leaves, 
    SUM(approved_leaves), 
    SUM(lb.max_leaves) - SUM(approved_leaves) AS leave_balance
FROM 
    employee_leaves el
JOIN 
    leave_balance lb ON lb.leave_type_id = el.leave_type_id
GROUP BY 
    full_name, lb.leave_type_id;


-- display all the Table Partitions for the given table "employees"
SELECT 
    table_name, partition_name, high_value
FROM
    user_tab_partitions
WHERE
    table_name = 'EMPLOYEES';

-- list all the views in dba
SELECT 
    view_name
FROM
    dba_views;

-- Meta tables/views
user_tab_partitions
all_views
all_tables
all_objects
dba_objects
user_objects
user_indexes
user_views
user_tables
user_tab_columns

-- constraints meta tables/views
user_constraints



SELECT /*+ NO_INDEX(leave_balance, leave_balance_leave_type_id_idx) */
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


