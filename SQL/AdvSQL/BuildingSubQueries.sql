/*
Building Subqueries

Self-contained subqueries
Subqueries in conditions and column expressions
Creating multilevel subqueries
Avoiding problems when subqueries return NULLs
Handling multirow subquery results
Finding gaps in number series
Correlated subqueries
Accessing values from the outer query
EXISTS vs. IN
Identifying duplicates
Avoiding accidental correlation
Common table expressions
Reusable subqueries
Recursive subqueries
Traversing hierarchies
*/

-- Self-contained subqueries - A self-contained subquery is a subquery that can run independently of the outer query.
-- Example: Find customers who have spent more than the average amount spent by all customers.
SELECT CustomerName, TotalAmount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);

-- Subqueries in conditions and column expressions - Subqueries can be used in conditions and column expressions.
SELECT Customers.CustomerName, 
       (SELECT SUM(TotalAmount) FROM Orders WHERE Orders.CustomerID = Customers.CustomerID) AS TotalAmount,
       (SELECT AVG(TotalAmount) FROM Orders) AS AverageOrderAmount
FROM Customers;

-- Creating multilevel subqueries - Subqueries can be nested to create multilevel subqueries.
-- Usecase: Find customers who have placed orders with a total amount greater than the average order amount
SELECT Customers.CustomerID, Customers.CustomerName, CustomerTotal.TotalAmount
FROM Customers
JOIN (
    SELECT CustomerID, SUM(TotalAmount) AS TotalAmount
    FROM Orders
    GROUP BY CustomerID
    HAVING SUM(TotalAmount) > (
        SELECT AVG(TotalAmount)
        FROM Orders
    )
) CustomerTotal ON Customers.CustomerID = CustomerTotal.CustomerID;

-- NULLIF, NVL, COALESCE 

-- Avoiding problems when subqueries return NULLs - Use the COALESCE function to handle NULL values in subqueries.
-- Usecase: Find customers who have placed orders with a total amount greater than the average order amount, handling NULL values.
SELECT Customers.CustomerID, Customers.CustomerName, CustomerTotal.TotalAmount
FROM Customers
JOIN (
    SELECT CustomerID, SUM(TotalAmount) AS TotalAmount
    FROM Orders
    GROUP BY CustomerID
    HAVING SUM(TotalAmount) > COALESCE((
        SELECT AVG(TotalAmount)
        FROM Orders
    ), 0)
) CustomerTotal ON Customers.CustomerID = CustomerTotal.CustomerID;

-- Handling multirow subquery results - Use the IN operator to handle subqueries that return multiple rows.
-- Usecase: Find customers who have placed orders for specific products
SELECT Customers.CustomerID, Customers.CustomerName
FROM Customers
WHERE Customers.CustomerID IN (
    SELECT DISTINCT Orders.CustomerID
    FROM Orders
    JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID
    WHERE OrderItems.ProductName IN ('HP Laptop', 'Dell Monitor','Apple iPhone 13')  
);

-- Handling multirow subquery results - Use the EXISTS operator to handle subqueries that return multiple rows.
-- Usecase: Find customers who have placed orders for specific products
SELECT Customers.CustomerID, Customers.CustomerName
FROM Customers
WHERE EXISTS (
    SELECT 1
    FROM Orders
    JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID
    WHERE Customers.CustomerID = Orders.CustomerID
    AND OrderItems.ProductName IN ('HP Laptop', 'Dell Monitor','Apple iPhone 13')
);


-- CTE
-- Finding gaps in number series - Use subqueries to find gaps in number series.
-- Usecase: Scenario: Your business requires all orders to follow a sequential numbering pattern, so that each order has a unique, incrementing Order Number with no gaps (e.g., 1001, 1002, 1003, etc.). However, due to occasional technical issues or cancellations, there are sometimes gaps in the sequence. You want to identify these gaps to ensure all order records are accounted for and address any potential data integrity issues.
WITH NumberSeries AS (
    SELECT LEVEL + (SELECT MIN(OrderID) - 1 FROM Orders) AS num
    FROM dual
    CONNECT BY LEVEL <= (SELECT MAX(OrderID) - MIN(OrderID) FROM Orders)
)
SELECT num AS missing_OrderID
FROM NumberSeries ns
LEFT JOIN Orders o ON ns.num = o.OrderID
WHERE o.OrderID IS NULL
ORDER BY num;

-- Correlated subqueries - A correlated subquery is a subquery that depends on the outer query.
-- Usecase: Find customers who have placed orders with a total amount greater than the average order amount, using a correlated subquery.
SELECT Customers.CustomerName
FROM Customers
JOIN (
    SELECT CustomerID, SUM(TotalAmount) AS TotalAmount
    FROM Orders O
    WHERE TotalAmount > (
        SELECT AVG(TotalAmount)
        FROM Orders
        WHERE CustomerID = O.CustomerID
    )
    GROUP BY CustomerID
) CustomerTotal ON Customers.CustomerID = CustomerTotal.CustomerID;

-- Accessing values from the outer query - Use the outer query values in the subquery.
-- Usecase: Find customers who have placed orders with a total amount greater than the average order amount, using the outer query values in the subquery.
SELECT  Customers.CustomerName, CustomerTotal.TotalAmount
FROM Customers
JOIN (
    SELECT CustomerID, SUM(TotalAmount) AS TotalAmount
    FROM Orders
    WHERE TotalAmount > (
        SELECT AVG(TotalAmount)
        FROM Orders
        WHERE CustomerID = Customers.CustomerID
    )
    GROUP BY CustomerID
) CustomerTotal ON Customers.CustomerID = CustomerTotal.CustomerID;

-- EXISTS vs. IN - Use EXISTS when you want to check for the existence of a subquery result, and use IN when you want to compare values.
-- Usecase: Find customers who have placed orders with a total amount greater than the average order amount, using EXISTS and IN.
SELECT Customers.CustomerName
FROM Customers
WHERE EXISTS (
    SELECT 1
    FROM Orders
    WHERE CustomerID = Customers.CustomerID
    GROUP BY CustomerID
    HAVING SUM(TotalAmount) > (
        SELECT AVG(TotalAmount)
        FROM Orders
    )
);

SELECT Customers.CustomerName
FROM Customers
WHERE Customers.CustomerID IN (
    SELECT CustomerID
    FROM Orders
    GROUP BY CustomerID
    HAVING SUM(TotalAmount) > (
        SELECT AVG(TotalAmount)
        FROM Orders
    )
);

-- Identifying duplicates - Use subqueries to identify duplicate records.
-- Usecase: Find duplicate orders based on the OrderID.
SELECT OrderID
FROM Orders
WHERE OrderID IN (
    SELECT OrderID
    FROM Orders
    GROUP BY OrderID
    HAVING COUNT(*) > 1
);

-- Avoiding accidental correlation - Avoid accidental correlation by using table aliases in subqueries.
-- Usecase: Find customers who have placed orders with a total amount greater than the average order amount, avoiding accidental correlation.
SELECT Customers.CustomerName
FROM Customers
WHERE EXISTS (
    SELECT 1
    FROM Orders O
    WHERE CustomerID = CustomerID -- Use table alias to avoid accidental correlation
    GROUP BY CustomerID
    HAVING SUM(TotalAmount) > (
        SELECT AVG(TotalAmount)
        FROM Orders
    )
);

-- Common table expressions - Use common table expressions (CTEs) to create reusable subqueries, improving readability and maintainability.
-- Usecase: Find customers who have placed orders with a total amount greater than the average order amount using a CTE.
WITH CustomerOrders AS (
    SELECT CustomerID, SUM(TotalAmount) AS TotalAmount
    FROM Orders
    GROUP BY CustomerID
)

SELECT Customers.CustomerName
FROM Customers
JOIN CustomerOrders ON Customers.CustomerID = CustomerOrders.CustomerID
WHERE TotalAmount > (
    SELECT AVG(TotalAmount)
    FROM Orders
);


-- Recursive subqueries - Use recursive subqueries to traverse hierarchies using Oracle HR Schema
-- Usecase: Find the employees who report to a specific manager and their subordinates.
WITH EmployeeHierarchy (employee_id, first_name, last_name, manager_id) AS (
  -- Anchor member: Start with the specific manager (manager ID 101 in this example)
  SELECT employee_id, first_name, last_name, manager_id
  FROM hr.employees
  WHERE manager_id = 101
  
  UNION ALL
  
  -- Recursive member: Find employees who report to the employees found in the previous step
  SELECT e.employee_id, e.first_name, e.last_name, e.manager_id
  FROM hr.employees e
  JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT employee_id, first_name, last_name, manager_id
FROM EmployeeHierarchy
ORDER BY employee_id;

-- traverse the hierarchy from the top-level manager (employee_id 100) to all employees who report to that manager.
WITH EmployeeHierarchy (employee_id, first_name, last_name, manager_id, level) AS (
  -- Anchor member: Start with the top-level manager (employee ID 100)
  SELECT employee_id, first_name, last_name, manager_id, 1 AS level
  FROM hr.employees
  WHERE manager_id = 100
  
  UNION ALL
  
  -- Recursive member: Find employees who report to the employees found in the previous step
  SELECT e.employee_id, e.first_name, e.last_name, e.manager_id, eh.level + 1
  FROM hr.employees e
  JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)

SELECT employee_id, first_name, last_name, manager_id, level
FROM EmployeeHierarchy
ORDER BY level, employee_id;















--*****************
DECLARE
  v_start_time  TIMESTAMP;
  v_end_time    TIMESTAMP;
  v_execution_time INTERVAL DAY TO SECOND;
  v_count       NUMBER;
BEGIN
  -- Capture the start time
  v_start_time := SYSTIMESTAMP;

  -- Execute the query
  SELECT COUNT(*) INTO v_count FROM (SELECT Customers.CustomerName
FROM Customers
WHERE EXISTS (
    SELECT 1
    FROM Orders O
    WHERE O.CustomerID = Customers.CustomerID -- Use table alias to avoid accidental correlation
    GROUP BY CustomerID
    HAVING SUM(TotalAmount) > (
        SELECT AVG(TotalAmount)
        FROM Orders
    )
));

	--SELECT COUNT(*) INTO v_count FROM (SELECT distinct CUST_FIRST_NAME || ' ' || CUST_LAST_NAME
    --    FROM OE.CUSTOMERS WHERE CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM
     --   OE.ORDERS));
  -- Capture the end time
  v_end_time := SYSTIMESTAMP;

  -- Calculate the execution time
  v_execution_time := v_end_time - v_start_time;

  -- Display the execution time
  DBMS_OUTPUT.PUT_LINE('Execution Time: ' || v_execution_time || ' to get records:' || v_count);
END;
/
