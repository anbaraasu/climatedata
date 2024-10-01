-- Create the sales table
CREATE TABLE sales (
	region VARCHAR2(50),
	salesperson VARCHAR2(50),
	amount NUMBER,
	sale_date DATE
);

-- Insert sample data
INSERT INTO sales (region, salesperson, amount, sale_date) VALUES ('North', 'Alice', 1000, TO_DATE('2023-01-01', 'YYYY-MM-DD'));
INSERT INTO sales (region, salesperson, amount, sale_date) VALUES ('North', 'Bob', 1500, TO_DATE('2023-01-02', 'YYYY-MM-DD'));
INSERT INTO sales (region, salesperson, amount, sale_date) VALUES ('South', 'Charlie', 2000, TO_DATE('2023-01-03', 'YYYY-MM-DD'));
INSERT INTO sales (region, salesperson, amount, sale_date) VALUES ('South', 'David', 2500, TO_DATE('2023-01-04', 'YYYY-MM-DD'));
INSERT INTO sales (region, salesperson, amount, sale_date) VALUES ('North', 'Alice', 1200, TO_DATE('2023-01-05', 'YYYY-MM-DD'));
INSERT INTO sales (region, salesperson, amount, sale_date) VALUES ('North', 'Bob', 1600, TO_DATE('2023-01-06', 'YYYY-MM-DD'));
INSERT INTO sales (region, salesperson, amount, sale_date) VALUES ('South', 'Charlie', 2100, TO_DATE('2023-01-07', 'YYYY-MM-DD'));
INSERT INTO sales (region, salesperson, amount, sale_date) VALUES ('South', 'David', 2600, TO_DATE('2023-01-08', 'YYYY-MM-DD'));

-- Create the regions table
CREATE TABLE regions (
	region VARCHAR2(50),
	region_manager VARCHAR2(50)
);

-- Insert sample data into regions table
INSERT INTO regions (region, region_manager) VALUES ('North', 'Manager1');
INSERT INTO regions (region, region_manager) VALUES ('South', 'Manager2');


-- Write SQL query to retrieve the total sales amount for each region from the 'sales' table.
-- It groups the results by region and filters the groups to include only those with a total sales amount greater than 3000.
-- The result set includes two columns: 'region' and 'total_sales'.

SELECT region, SUM(amount) AS total_sales
FROM sales
GROUP BY region
HAVING SUM(amount) > 3000;

-- Calculating Moving Averages
/*
    Write SQL query to calculate a moving average of sales amounts for each region.
    
    Columns Selected:
    - region: The region where the sale occurred.
    - salesperson: The salesperson who made the sale.
    - sale_date: The date of the sale.
    - amount: The amount of the sale.
    - moving_avg: The moving average of the sales amount for the current row and the two preceding rows within the same region, ordered by sale_date.

    The moving average is computed using the window function AVG() with the following specifications:
    - PARTITION BY region: The data is partitioned by the region.
    - ORDER BY sale_date: The data within each partition is ordered by the sale date.
    - ROWS BETWEEN 2 PRECEDING AND CURRENT ROW: The window frame includes the current row and the two preceding rows.
*/
SELECT 
	region, 
	salesperson, 
	sale_date, 
	amount, 
	AVG(amount) OVER (PARTITION BY region ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM sales;

-- Extending Group Queries
SELECT region, salesperson, SUM(amount) AS total_sales
FROM sales
GROUP BY GROUPING SETS (
	(region, salesperson),
	(region),
	()
);

-- Nesting Grouped Aggregates
SELECT region, total_sales
FROM (
	SELECT region, SUM(amount) AS total_sales
	FROM sales
	GROUP BY region
)
ORDER BY total_sales DESC;

-- Joins and Grouping
SELECT r.region, r.region_manager, SUM(s.amount) AS total_sales
FROM sales s
JOIN regions r ON s.region = r.region
GROUP BY r.region, r.region_manager;

-- Introducing Subtotals with ROLLUP
SELECT region, salesperson, SUM(amount) AS total_sales
FROM sales
GROUP BY ROLLUP (region, salesperson);

-- Introducing Subtotals with CUBE
SELECT region, salesperson, SUM(amount) AS total_sales
FROM sales
GROUP BY CUBE (region, salesperson);
