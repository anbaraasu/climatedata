-- Create the sales table
CREATE TABLE sales (
    sale_id NUMBER PRIMARY KEY,
    region VARCHAR2(50),
    salesperson VARCHAR2(50),
    product_id NUMBER,
    amount NUMBER,
    sale_date DATE
);

-- Create the regions table
CREATE TABLE regions (
    region VARCHAR2(50) PRIMARY KEY,
    region_manager VARCHAR2(50)
);

-- Create the products table
CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(50),
    category VARCHAR2(50)
);

-- Insert sample data into sales table
INSERT INTO sales (sale_id, region, salesperson, product_id, amount, sale_date) VALUES (1, 'North', 'Alice', 101, 1000, TO_DATE('2023-01-01', 'YYYY-MM-DD'));
INSERT INTO sales (sale_id, region, salesperson, product_id, amount, sale_date) VALUES (2, 'North', 'Bob', 102, 1500, TO_DATE('2023-01-02', 'YYYY-MM-DD'));
INSERT INTO sales (sale_id, region, salesperson, product_id, amount, sale_date) VALUES (3, 'South', 'Charlie', 103, 2000, TO_DATE('2023-01-03', 'YYYY-MM-DD'));
INSERT INTO sales (sale_id, region, salesperson, product_id, amount, sale_date) VALUES (4, 'South', 'David', 104, 2500, TO_DATE('2023-01-04', 'YYYY-MM-DD'));
INSERT INTO sales (sale_id, region, salesperson, product_id, amount, sale_date) VALUES (5, 'North', 'Alice', 101, 1200, TO_DATE('2023-01-05', 'YYYY-MM-DD'));
INSERT INTO sales (sale_id, region, salesperson, product_id, amount, sale_date) VALUES (6, 'North', 'Bob', 102, 1600, TO_DATE('2023-01-06', 'YYYY-MM-DD'));
INSERT INTO sales (sale_id, region, salesperson, product_id, amount, sale_date) VALUES (7, 'South', 'Charlie', 103, 2100, TO_DATE('2023-01-07', 'YYYY-MM-DD'));
INSERT INTO sales (sale_id, region, salesperson, product_id, amount, sale_date) VALUES (8, 'South', 'David', 104, 2600, TO_DATE('2023-01-08', 'YYYY-MM-DD'));

-- Insert sample data into regions table
INSERT INTO regions (region, region_manager) VALUES ('North', 'Manager1');
INSERT INTO regions (region, region_manager) VALUES ('South', 'Manager2');

-- Insert sample data into products table
INSERT INTO products (product_id, product_name, category) VALUES (101, 'ProductA', 'Category1');
INSERT INTO products (product_id, product_name, category) VALUES (102, 'ProductB', 'Category1');
INSERT INTO products (product_id, product_name, category) VALUES (103, 'ProductC', 'Category2');
INSERT INTO products (product_id, product_name, category) VALUES (104, 'ProductD', 'Category2');

-- The OVER clause: Specifying the ordering before applying the function
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    SUM(s.amount) OVER (ORDER BY s.sale_date) AS running_total
FROM sales s;

-- Splitting the result set into logical partitions
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    SUM(s.amount) OVER (PARTITION BY s.region ORDER BY s.sale_date) AS running_total_by_region
FROM sales s;

-- Calculating ranks
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    RANK() OVER (ORDER BY s.amount DESC) AS rank
FROM sales s;

-- RANK and DENSE_RANK
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    RANK() OVER (PARTITION BY s.region ORDER BY s.amount DESC) AS rank_by_region,
    DENSE_RANK() OVER (PARTITION BY s.region ORDER BY s.amount DESC) AS dense_rank_by_region
FROM sales s;

-- ROW_NUMBER with ordered sets
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    ROW_NUMBER() OVER (PARTITION BY s.region ORDER BY s.sale_date) AS row_number_by_region
FROM sales s;

-- Calculating percentiles
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    PERCENT_RANK() OVER (ORDER BY s.amount DESC) AS percentile_rank
FROM sales s;

-- Extending the use of aggregates
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    AVG(s.amount) OVER (PARTITION BY s.region) AS avg_amount_by_region
FROM sales s;

-- Partitioning in multiple levels
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    SUM(s.amount) OVER (PARTITION BY s.region, s.salesperson ORDER BY s.sale_date) AS running_total_by_salesperson
FROM sales s;

-- Computing running totals
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    SUM(s.amount) OVER (ORDER BY s.sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM sales s;

-- Comparing row and aggregate values
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    s.amount - AVG(s.amount) OVER (PARTITION BY s.region) AS deviation_from_avg
FROM sales s;

-- Top-N queries
SELECT * FROM (
    SELECT 
        s.region, 
        s.salesperson, 
        s.sale_date, 
        s.amount, 
        ROW_NUMBER() OVER (ORDER BY s.amount DESC) AS row_num
    FROM sales s
)
WHERE row_num <= 3;

-- Defining sliding window boundaries
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    SUM(s.amount) OVER (ORDER BY s.sale_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS sliding_window_sum
FROM sales s;

-- Calculate the running total of sales amounts partitioned by region and ordered by sale_date.
SELECT 
    s.region, 
    s.salesperson, 
    s.sale_date, 
    s.amount, 
    SUM(s.amount) OVER (PARTITION BY s.region ORDER BY s.sale_date) AS running_total_by_region
FROM sales s;

-- Calculate the average sales amount for each product category.
SELECT 
    p.category, 
    AVG(s.amount) AS avg_sales_amount
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category;

-- Calculate the rank of salespersons within each region based on their total sales amount.
SELECT 
    s.region, 
    s.salesperson, 
    SUM(s.amount) AS total_sales, 
    RANK() OVER (PARTITION BY s.region ORDER BY SUM(s.amount) DESC) AS rank_by_region
FROM sales s
GROUP BY s.region, s.salesperson;