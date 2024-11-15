/*
Database Relationships, Pivoting Data
•	Pivoting Data
•	Avoiding errors and pitfalls
*/

-- Pivoting Data
-- Pivoting data involves transforming rows into columns to create a summary view of the data.
-- This can be done using the PIVOT operator in SQL.
-- The PIVOT operator is used to rotate rows into columns, aggregating data in the process.
-- The PIVOT operator requires an aggregate function to be applied to the pivoted data.
-- The PIVOT operator is used with the following syntax:
-- Example Using HR schema:
-- Requirement: Calculate the total salary for each job title.

-- using case cond to calculate the total salary for each job
SELECT 
    SUM(CASE WHEN job_id = 'AD_PRES' THEN salary ELSE 0 END) AS President,
    SUM(CASE WHEN job_id = 'AD_VP' THEN salary ELSE 0 END) AS VicePresident,
    SUM(CASE WHEN job_id = 'AD_ASST' THEN salary ELSE 0 END) AS Assistant,
    SUM(CASE WHEN job_id = 'FI_MGR' THEN salary ELSE 0 END) AS FinanceManager,
    SUM(CASE WHEN job_id = 'FI_ACCOUNT' THEN salary ELSE 0 END) AS Accountant,
    SUM(CASE WHEN job_id = 'AC_MGR' THEN salary ELSE 0 END) AS AccountingManager,
    SUM(CASE WHEN job_id = 'AC_ACCOUNT' THEN salary ELSE 0 END) AS Accounting
FROM HR.employees;

SELECT *
FROM (
    SELECT job_id, salary
    FROM HR.employees
)
PIVOT (
    SUM(salary)
    FOR job_id IN ('AD_PRES' AS President, 'AD_VP' AS VicePresident, 'AD_ASST' AS Assistant, 'FI_MGR' AS FinanceManager, 'FI_ACCOUNT' AS Accountant, 'AC_MGR' AS AccountingManager, 'AC_ACCOUNT' AS Accounting)
);


-- Avoiding errors and pitfalls
-- When pivoting data, it is important to avoid common errors and pitfalls:
-- 1. Ensure that the columns used for pivoting are valid and correctly specified.
-- 2. Check for null values in the pivoted columns and handle them appropriately.
-- 3. Use aggregate functions to summarize the pivoted data.
-- 4. Verify the output of the pivot operation to ensure that the data is correctly transformed.
-- 5. Test the pivot operation with different datasets to validate the results.
-- 6. Be aware of the limitations of the PIVOT operator, such as the need for explicit column names in the IN clause.
-- 7. Consider alternative approaches, such as using CASE statements or dynamic SQL, if the PIVOT operator is not suitable for the task.
-- 8. Use proper error handling and logging to capture any issues that may arise during the pivot operation.



