/* 
Performing Extensive Analysis with Analytic Functions
•	The OVER clause
•	Specifying the ordering before applying the function
•	Splitting the result set into logical partitions
•	Calculating ranks
•	RANK and DENSE_RANK
•	ROW_NUMBER with ordered sets
•	Calculating percentiles
•	Extending the use of aggregates
•	Partitioning in multiple levels
•	Computing running totals
•	Comparing row and aggregate values
•	Top-N queries
•	Defining sliding window boundaries
•	LAG and LEAD functions
*/

-- Analytic functions -  are used to perform calculations across a set of rows that are related to the current row.

-- The OVER clause - is used to define the window of rows over which the function operates.
-- Requirement: Display the total sales amount for each order, along with the total sales amount for all orders.
SELECT CustomerID, OrderID, TotalAmount,
       SUM(TotalAmount) OVER () AS TotalSales
FROM Orders;

-- Specifying the ordering before applying the function
-- Requirement: Calculate the running total of sales for each order, ordered by the order date.
SELECT CustomerID, OrderID, TotalAmount,
       SUM(TotalAmount) OVER (ORDER BY OrderDate) AS RunningTotal
FROM Orders;

-- Splitting the result set into logical partitions
-- Requirement: Calculate the total sales for each customer, along with the total sales for all customers.
SELECT CustomerID, OrderID, TotalAmount,
       SUM(TotalAmount) OVER (PARTITION BY CustomerID) AS CustomerTotal
FROM Orders;

-- Calculating ranks
-- Requirement: Rank the customers based on the total sales amount in descending order.
SELECT CustomerID, OrderID, TotalAmount,
       RANK() OVER (ORDER BY TotalAmount DESC) AS SalesRank
FROM Orders;

-- RANK and DENSE_RANK
-- RANK() - assigns the same rank to rows with the same value, and then skips the next rank.
-- DENSE_RANK() - assigns the same rank to rows with the same value, but does not skip the next rank.
-- Requirement: Rank the customers based on the total sales amount in descending order.
SELECT CustomerID, OrderID, TotalAmount,
       RANK() OVER (ORDER BY TotalAmount DESC) AS SalesRank,
       DENSE_RANK() OVER (ORDER BY TotalAmount DESC) AS DenseSalesRank
FROM Orders;

-- ROW_NUMBER with ordered sets
-- Requirement: Calculate the row number for each order, ordered by the total amount in descending order.
SELECT CustomerID, OrderID, TotalAmount,
       ROW_NUMBER() OVER (ORDER BY TotalAmount DESC) AS RowNum
FROM Orders;

-- Calculating percentiles
-- Diff Percentage vs Percentile: Percentage is a ratio expressed as a fraction of 100, while a percentile is a value below which a given percentage of observations fall.
-- Requirement: Calculate the percentile rank of the total amount for each order.
SELECT CustomerID, OrderID, TotalAmount,
       PERCENT_RANK() OVER (ORDER BY TotalAmount DESC) AS PercentRank
FROM Orders;

-- Partitioning in multiple levels
-- Requirement: Calculate the running total of sales for each customer, ordered by the order date, and then by the customer ID.
SELECT CustomerID, OrderID, TotalAmount,
       SUM(TotalAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RunningCustomerTotal
FROM Orders;

-- Computing running totals
-- Requirement: Calculate the running total of sales for each order, ordered by the order date.
SELECT CustomerID, OrderID, TotalAmount,
       SUM(TotalAmount) OVER (ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Orders;

-- Comparing row and aggregate values
-- Requirement: Calculate the difference between the total amount of each order and the average total amount of all orders.
SELECT CustomerID, OrderID, TotalAmount,
       TotalAmount - AVG(TotalAmount) OVER () AS DifferenceFromAvg
FROM Orders;

-- Top-N queries
-- Requirement: Display the top 5 orders with the highest total amount.
SELECT CustomerID, OrderID, TotalAmount
FROM (
    SELECT CustomerID, OrderID, TotalAmount,
           ROW_NUMBER() OVER (ORDER BY TotalAmount DESC) AS RowNum
    FROM Orders
) 
-- FETCH FIRST/LAST 5 ROWS ONLY
WHERE RowNum <= 5;

-- Defining sliding window boundaries
-- Requirement: Calculate the moving average of order amounts over the last 3 orders.
SELECT CustomerID, OrderID, TotalAmount,
       AVG(TotalAmount) OVER (ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM Orders;

-- LAG and LEAD functions
-- LAG() - returns the value of a column from the previous row.
-- LEAD() - returns the value of a column from next row
SELECT CustomerID, OrderID, TotalAmount,
       LAG(TotalAmount, 1) OVER (ORDER BY OrderDate) AS PrevOrderAmount,
       LEAD(TotalAmount, 1) OVER (ORDER BY OrderDate) AS NextOrderAmount
FROM Orders;


-- Class room exercises
-- 3. Rank the customers based on the total sales amount for each month in descending order.
-- 10. Calculate the moving average of order amounts over the last 3 orders by each customer name.
-- 11. Find the customer who has placed the maximum number of orders on mar month any year.
-- 13. Use Lag to calculate the difference between the current order amount and the previous order amount.
-- 14. Use Lead to calculate the difference between the current order amount and the next order amount.
















-- Solution
-- 3. Rank the customers based on the total sales amount for each month in descending order.
SELECT CustomerID, OrderDate, TotalAmount,
       RANK() OVER (PARTITION BY EXTRACT(YEAR FROM OrderDate), EXTRACT(MONTH FROM OrderDate) ORDER BY TotalAmount DESC) AS SalesRank
FROM Orders;


-- 4. Calculate the row number for each order, ordered by the total amount in descending order.
SELECT CustomerID, OrderID, TotalAmount,
       ROW_NUMBER() OVER (ORDER BY TotalAmount DESC) AS RowNum
FROM Orders;

-- 5. Calculate the percentile rank of the total amount for each order.
SELECT CustomerID, OrderID, TotalAmount,
       PERCENT_RANK() OVER (ORDER BY TotalAmount DESC) AS PercentRank
FROM Orders;

-- 6. Calculate the average total amount for each customer, along with the total sales for all customers.
SELECT CustomerID, OrderID, TotalAmount,
       AVG(TotalAmount) OVER (PARTITION BY CustomerID) AS AvgCustomerTotal,
       SUM(TotalAmount) OVER () AS TotalSales
FROM Orders;

-- 7. Calculate the running total of sales for each customer, ordered by the order date, and then by the customer ID.
SELECT CustomerID, OrderID, TotalAmount,
       SUM(TotalAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate, CustomerID) AS RunningTotal
FROM Orders;

-- 8. Calculate the running total of sales for each customer, ordered by the order date, and then by the customer ID, including the current row.
SELECT CustomerID, OrderID, TotalAmount,
       SUM(TotalAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate, CustomerID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Orders;

-- 9. Calculate the difference between the total amount of each order and the average total amount of all orders.
SELECT CustomerID, OrderID, TotalAmount,
       TotalAmount - AVG(TotalAmount) OVER () AS DifferenceFromAvg
FROM Orders;

-- 10. Calculate the moving average of order amounts over the last 3 orders by each customer name.
SELECT CustomerID, OrderID, TotalAmount,
       AVG(TotalAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM Orders;

-- 11. Find the customer who has placed the maximum number of orders on mar month any year.
SELECT CustomerID, OrderDate, COUNT(OrderID) AS OrderCount,
       RANK() OVER (PARTITION BY EXTRACT(YEAR FROM OrderDate), EXTRACT(MONTH FROM OrderDate) ORDER BY COUNT(OrderID) DESC) AS OrderRank
FROM Orders
GROUP BY CustomerID, OrderDate;

-- 12. List the total amount spent by each customer, including subtotals for each customer, for each month then overall total.
SELECT CustomerID, OrderDate, TotalAmount,
       SUM(TotalAmount) OVER (PARTITION BY CustomerID, EXTRACT(YEAR FROM OrderDate), EXTRACT(MONTH FROM OrderDate)) AS MonthlyTotal,
       SUM(TotalAmount) OVER (PARTITION BY CustomerID) AS CustomerTotal,
       SUM(TotalAmount) OVER () AS TotalSales
FROM Orders;

-- 13. Use Lag to calculate the difference between the current order amount and the previous order amount.
SELECT CustomerID, OrderID, TotalAmount,
       TotalAmount - LAG(TotalAmount, 1) OVER (ORDER BY OrderDate) AS DiffFromPrevOrder
FROM Orders;

-- 14. Use Lead to calculate the difference between the current order amount and the next order amount.
SELECT CustomerID, OrderID, TotalAmount,
       TotalAmount - LEAD(TotalAmount, 1) OVER (ORDER BY OrderDate) AS DiffFromNextOrder
FROM Orders;
