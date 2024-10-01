/*
Performing Extensive Analysis with Analytic Functions

The OVER clause:
	- Specifying the ordering before applying the function
	- Splitting the result set into logical partitions
	- Calculating ranks
	- RANK and DENSE_RANK
	- ROW_NUMBER with ordered sets
	- Calculating percentiles
	- Extending the use of aggregates
	- Partitioning in multiple levels
	- Computing running totals
	- Comparing row and aggregate values
	- Top-N queries
	- Defining sliding window boundaries

Table: sales
Columns:
	- region: VARCHAR2(50)
	- salesperson: VARCHAR2(50)
	- amount: NUMBER
	- sale_date: DATE

Sample Data:
	- Sample data for regions North and South with salespersons Alice, Bob, Charlie, and David.

Analytic Functions Demonstrated:
	- SUM() OVER (ORDER BY sale_date): Running total of sales amounts ordered by sale_date.
	- SUM() OVER (PARTITION BY region ORDER BY sale_date): Running total of sales amounts partitioned by region and ordered by sale_date.
	- RANK() OVER (ORDER BY amount DESC): Rank of sales amounts in descending order.
	- RANK() and DENSE_RANK() OVER (PARTITION BY region ORDER BY amount DESC): Rank and dense rank of sales amounts partitioned by region in descending order.
	- ROW_NUMBER() OVER (PARTITION BY region ORDER BY sale_date): Row number of sales amounts partitioned by region and ordered by sale_date.
	- PERCENT_RANK() OVER (ORDER BY amount DESC): Percentile rank of sales amounts in descending order.
	- AVG(amount) OVER (PARTITION BY region): Average sales amount partitioned by region.
	- SUM(amount) OVER (PARTITION BY region, salesperson ORDER BY sale_date): Running total of sales amounts partitioned by region and salesperson, ordered by sale_date.
	- SUM(amount) OVER (ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW): Running total of sales amounts ordered by sale_date with unbounded preceding rows.
	- amount - AVG(amount) OVER (PARTITION BY region): Deviation of sales amount from the average amount partitioned by region.
	- ROW_NUMBER() OVER (ORDER BY amount DESC): Top-N queries to get the top 3 sales amounts.
	- SUM(amount) OVER (ORDER BY sale_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING): Sliding window sum of sales amounts ordered by sale_date with 1 preceding and 1 following row.
*/

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

-- The OVER clause: Specifying the ordering before applying the function
SELECT 
    region, 
    salesperson, 
    sale_date, 
    amount, 
    SUM(amount) OVER (ORDER BY sale_date) AS running_total
FROM sales;

-- Splitting the result set into logical partitions
SELECT 
    region, 
    salesperson, 
    sale_date, 
    amount, 
    SUM(amount) OVER (PARTITION BY region ORDER BY sale_date) AS running_total_by_region
FROM sales;

-- Calculating ranks
SELECT 
    region, 
    salesperson, 
    sale_date, 
    amount, 
    RANK() OVER (ORDER BY amount DESC) AS rank
FROM sales;

-- RANK and DENSE_RANK
SELECT 
    region, 
    salesperson, 
    sale_date, 
    amount, 
    RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS rank_by_region,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS dense_rank_by_region
FROM sales;

-- ROW_NUMBER with ordered sets
SELECT 
    region, 
    salesperson, 
    sale_date, 
    amount, 
    ROW_NUMBER() OVER (PARTITION BY region ORDER BY sale_date) AS row_number_by_region
FROM sales;

-- Calculating percentiles
SELECT 
    region, 
    salesperson, 
    sale_date, 
    amount, 
    PERCENT_RANK() OVER (ORDER BY amount DESC) AS percentile_rank
FROM sales;

-- Extending the use of aggregates
SELECT 
    region, 
    salesperson, 
    sale_date, 
    amount, 
    AVG(amount) OVER (PARTITION BY region) AS avg_amount_by_region
FROM sales;

-- Partitioning in multiple levels
SELECT 
    region, 
    salesperson, 
    sale_date, 
    amount, 
    SUM(amount) OVER (PARTITION BY region, salesperson ORDER BY sale_date) AS running_total_by_salesperson
FROM sales;

-- Computing running totals
SELECT 
    region, 
    salesperson, 
    sale_date, 
    amount, 
    SUM(amount) OVER (ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM sales;

-- Comparing row and aggregate values
SELECT 
    region, 
    salesperson, 
    sale_date, 
    amount, 
    amount - AVG(amount) OVER (PARTITION BY region) AS deviation_from_avg
FROM sales;

-- Top-N queries
SELECT * FROM (
    SELECT 
        region, 
        salesperson, 
        sale_date, 
        amount, 
        ROW_NUMBER() OVER (ORDER BY amount DESC) AS row_num
    FROM sales
)
WHERE row_num <= 3;

-- Defining sliding window boundaries
SELECT 
    region, 
    salesperson, 
    sale_date, 
    amount, 
    SUM(amount) OVER (ORDER BY sale_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS sliding_window_sum
FROM sales;

