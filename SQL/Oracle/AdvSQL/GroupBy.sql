/*
GROUP BY
•	Applying conditions with HAVING
•	Calculating moving averages
•	Extending group queries
•	Nesting grouped aggregates
•	Joins and grouping
•	Introducing subtotals with CUBE and ROLLUP

*/

-- Create Customers table
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(100),
    ContactNumber VARCHAR2(15),
    Email VARCHAR2(100),
    Address VARCHAR2(255)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    OrderDate DATE,
    TotalAmount NUMBER,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderItems table
CREATE TABLE OrderItems (
    OrderItemID NUMBER PRIMARY KEY,
    OrderID NUMBER,
    ProductName VARCHAR2(100),
    Quantity NUMBER,
    Price NUMBER,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert sample data into Customers
INSERT INTO Customers VALUES (1, 'John Doe', '1234567890', 'john@example.com', '123 Elm St');
INSERT INTO Customers VALUES (2, 'Jane Smith', '0987654321', 'jane@example.com', '456 Oak St');
INSERT INTO Customers VALUES (3, 'Alice Johnson', '1112223333', 'alice@example.com', '789 Maple St');
INSERT INTO Customers VALUES (4, 'Bob Brown', '4445556666', 'bob@example.com', '101 Pine St');


-- Insert sample data into Orders
INSERT INTO Orders VALUES (1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 225000.00);
INSERT INTO Orders VALUES (2, 2, TO_DATE('2023-03-02', 'YYYY-MM-DD'), 200000.00);
INSERT INTO Orders VALUES (3, 1, TO_DATE('2023-01-03', 'YYYY-MM-DD'), 10000.00);
INSERT INTO Orders VALUES (4, 3, TO_DATE('2023-03-04', 'YYYY-MM-DD'), 75000.00);
INSERT INTO Orders VALUES (5, 1, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 2500.00);
INSERT INTO Orders VALUES (6, 2, TO_DATE('2023-03-06', 'YYYY-MM-DD'), 17500.00);
INSERT INTO Orders VALUES (7, 4, TO_DATE('2023-03-07', 'YYYY-MM-DD'), 5000.00);
INSERT INTO Orders VALUES (8, 1, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 5000.00);
INSERT INTO Orders VALUES (10, NULL, NULL,NULL);
INSERT INTO Orders VALUES (1, NULL, NULL,NULL);
INSERT INTO Orders VALUES (11, 4, SYSDATE,25);


-- Insert sample data into OrderItems
INSERT INTO OrderItems VALUES (1, 1, 'Samsung S24', 2, 150000.00);
INSERT INTO OrderItems VALUES (2, 2, 'Apple iPhone 13', 1, 200000.00);
INSERT INTO OrderItems VALUES (3, 3, 'Sony Headphones', 1, 10000.00);
INSERT INTO OrderItems VALUES (4, 4, 'HP Laptop', 1, 75000.00);
INSERT INTO OrderItems VALUES (5, 5, 'Logitech Mouse', 1, 2500.00);
INSERT INTO OrderItems VALUES (6, 6, 'Dell Monitor', 1, 17500.00);
INSERT INTO OrderItems VALUES (7, 7, 'Amazon Echo', 1, 5000.00);
INSERT INTO OrderItems VALUES (8, 8, 'Amazon Echo', 1, 5000.00);
INSERT INTO OrderItems VALUES (9, 1, 'HP Laptop', 1, 75000.00);
COMMIT:
    

-- Applying conditions with HAVING
SELECT CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Orders
GROUP BY CustomerID
HAVING SUM(TotalAmount) > 100;

-- Calculating moving averages
-- Moving averages means calculating the average of a set of values over a moving window. 
-- Example: Calculate the moving average of order amounts over the last 3 orders.
SELECT OrderDate, TotalAmount,
       AVG(TotalAmount) OVER (ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM Orders;

-- Nesting grouped aggregates with sub query
SELECT CustomerID, OrderDate, TotalAmount
FROM Orders
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);  

-- Extending group queries
-- Find the customers, total order amount who purchased either phone or laptop 
SELECT CUSTOMERNAME, SUM(laptopamount), SUM(phoneamount) 
FROM
    (SELECT customerid, SUM(0) laptopamount, SUM(totalamount) phoneamount 
FROM ORDERS O 
JOIN ORDERITEMS OI 
ON OI.ORDERID = O.ORDERID
WHERE ProductName in ('Samsung S24', 'Apple iPhone 13')
GROUP BY CUSTOMERID
UNION 
SELECT customerid, SUM(totalamount), SUM(0)
FROM ORDERS O
JOIN ORDERITEMS OI ON OI.ORDERID = O.ORDERID  WHERE ProductName in ('HP Laptop')
GROUP BY CUSTOMERID) PL,
CUSTOMERS C
WHERE C.CUSTOMERID = PL.CUSTOMERID
GROUP BY CUSTOMERNAME

-- Joins and grouping
SELECT C.CustomerName, COUNT(O.OrderID) AS OrderCount, SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

-- Introducing subtotals with CUBE 
SELECT CustomerID, OrderDate, SUM(TotalAmount) AS TotalSpent
FROM Orders
GROUP BY CUBE (CustomerID, OrderDate);

-- Introducing subtotals with CUBE and ROLLUP
SELECT CustomerID, OrderDate, SUM(TotalAmount) AS TotalSpent
FROM Orders
GROUP BY ROLLUP (CustomerID, OrderDate);

-- Diff between CUBE and ROLLUP
-- CUBE generates all possible subtotals for a given set of columns. Usecase: When you want to see all possible combinations of subtotals.
-- ROLLUP generates subtotals for a given set of columns in a hierarchical order. Usecase: When you want to see subtotals in a hierarchical order.

-- CUBE Example with all possible subtotals, order month, customer name, product name
SELECT TO_CHAR(OrderDate, 'MM-YYYY') AS OrderMonth, C.CustomerName, OI.ProductName, SUM(O.TotalAmount) AS TotalSpent
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY CUBE (TO_CHAR(OrderDate, 'MM-YYYY'), C.CustomerName, OI.ProductName);

-- CUBE Example with all hierarchical order - order month, customer name, product name
SELECT TO_CHAR(OrderDate, 'MM-YYYY') AS OrderMonth, C.CustomerName, OI.ProductName, SUM(O.TotalAmount) AS TotalSpent
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY ROLLUP (TO_CHAR(OrderDate, 'MM-YYYY'), C.CustomerName, OI.ProductName);


-- Classroom Exercises
-- 1. Find the total amount spent by each customer name who bought products more than 1 product.
-- 2. Calculate the moving average of order amounts over the last 3 orders by each customer name
-- 3. Find the customer who has placed the maximum number of orders on mar month any year.
-- 4. List the total amount spent on each product, including subtotals for each product, for each month then overall total using rollup.

































-- Solutions
-- 1.
SELECT C.CustomerName, SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY C.CustomerName
HAVING COUNT(OI.OrderItemID) > 1;

-- 2.
SELECT C.CustomerName, O.OrderDate, O.TotalAmount,
       AVG(O.TotalAmount) OVER (PARTITION BY C.CustomerName ORDER BY O.OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID;


-- 3.
SELECT C.CustomerName, COUNT(O.OrderID) AS OrderCount
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE EXTRACT(MONTH FROM O.OrderDate) = 3;

-- 4.
SELECT ProductName, TO_CHAR(OrderDate, 'MM-YYYY') AS MonthYear, SUM(TotalAmount) AS TotalSpent
FROM Orders O
JOIN OrderItems OI ON O.OrderID = OI.OrderID
GROUP BY ProductName, TO_CHAR(OrderDate, 'MM-YYYY')
WITH ROLLUP;