/*To create a shopping cart application in Oracle, you'll need to define a schema with appropriate tables for products, users, orders, and the cart itself. Here's an example of how you might structure the tables and their relationships.
Schema and Table Structure:
*/
1.	Users Table: Contains information about customers.

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR2(50) NOT NULL,
    password VARCHAR2(50) NOT NULL,
    email VARCHAR2(100),
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    created_at DATE DEFAULT SYSDATE
);
2.	Products Table: Contains details about the products that users can add to their cart.

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR2(100) NOT NULL,
    description VARCHAR2(500),
    price NUMBER(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    created_at DATE DEFAULT SYSDATE
);
3.	Shopping Cart Table: A temporary cart to hold products that a user adds before checking out.

CREATE TABLE ShoppingCart (
    cart_id INT PRIMARY KEY,
    user_id INT,
    product_id INT,
    quantity INT,
    added_at DATE DEFAULT SYSDATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
4.	Orders Table: To store orders once the user checks out.

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE DEFAULT SYSDATE,
    total_amount NUMBER(10, 2),
    status VARCHAR2(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
5.	Order Details Table: Stores the products that are part of an order.

CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price NUMBER(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
-- Insert into Users
INSERT INTO Users (user_id, username, password, email, first_name, last_name, created_at) VALUES
(1, 'johndoe', 'password123', 'john.doe@example.com', 'John', 'Doe', TO_DATE('2025-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(2, 'janedoe', 'password456', 'jane.doe@example.com', 'Jane', 'Doe', TO_DATE('2025-01-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(3, 'mike123', 'pass987', 'mike@example.com', 'Mike', 'Johnson', TO_DATE('2025-01-03 12:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(4, 'sarah_23', 'hello123', 'sarah23@example.com', 'Sarah', 'Connor', TO_DATE('2025-01-04 14:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(5, 'daveking', 'kingdave5', 'daveking@example.com', 'Dave', 'King', TO_DATE('2025-01-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(6, 'emily_77', 'emily789', 'emily77@example.com', 'Emily', 'Clark', TO_DATE('2025-01-06 08:30:00', 'YYYY-MM-DD HH24:MI:SS')),
(7, 'robert12', 'secure123', 'robert12@example.com', 'Robert', 'Lee', TO_DATE('2025-01-07 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Insert into Products
INSERT INTO Products (product_id, product_name, description, price, stock_quantity, created_at) VALUES
(1, 'Laptop', 'High-end gaming laptop', 1200.00, 10, TO_DATE('2025-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(2, 'Smartphone', 'Latest 5G smartphone', 800.00, 15, TO_DATE('2025-01-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(3, 'Wireless Mouse', 'Ergonomic wireless mouse', 50.00, 25, TO_DATE('2025-01-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(4, 'Headphones', 'Noise-cancelling headphones', 150.00, 30, TO_DATE('2025-01-03 10:30:00', 'YYYY-MM-DD HH24:MI:SS')),
(5, 'Tablet', '10-inch Android tablet', 300.00, 20, TO_DATE('2025-01-04 11:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(6, 'Smart Watch', 'Fitness tracking smartwatch', 200.00, 40, TO_DATE('2025-01-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(7, 'Bluetooth Speaker', 'Portable Bluetooth speaker', 70.00, 50, TO_DATE('2025-01-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Insert into ShoppingCart
INSERT INTO ShoppingCart (cart_id, user_id, product_id, quantity, added_at) VALUES
(1, 1, 1, 2, TO_DATE('2025-01-15 14:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(2, 1, 2, 1, TO_DATE('2025-01-15 14:05:00', 'YYYY-MM-DD HH24:MI:SS')),
(3, 2, 3, 3, TO_DATE('2025-01-16 15:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(4, 3, 4, 2, TO_DATE('2025-01-17 10:30:00', 'YYYY-MM-DD HH24:MI:SS')),
(5, 4, 5, 1, TO_DATE('2025-01-18 11:15:00', 'YYYY-MM-DD HH24:MI:SS')),
(6, 5, 6, 1, TO_DATE('2025-01-19 12:00:00', 'YYYY-MM-DD HH24:MI:SS')),
(7, 6, 7, 2, TO_DATE('2025-01-20 14:30:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Insert into Orders
INSERT INTO Orders (order_id, user_id, order_date, total_amount, status) VALUES
(1, 1, TO_DATE('2025-01-16 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2400.00, 'Pending'),
(2, 2, TO_DATE('2025-01-17 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150.00, 'Pending'),
(3, 3, TO_DATE('2025-01-18 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 300.00, 'Pending'),
(4, 4, TO_DATE('2025-01-19 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 450.00, 'Pending'),
(5, 5, TO_DATE('2025-01-20 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 200.00, 'Pending'),
(6, 6, TO_DATE('2025-01-21 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 140.00, 'Pending'),
(7, 7, TO_DATE('2025-01-22 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 140.00, 'Pending');

-- Insert into OrderDetails
INSERT INTO OrderDetails (order_detail_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 2, 1200.00),
(2, 1, 2, 1, 800.00),
(3, 2, 3, 3, 50.00),
(4, 3, 4, 2, 150.00),
(5, 4, 5, 1, 300.00),
(6, 5, 6, 1, 200.00),
(7, 6, 7, 2, 70.00);

-- SQL Exercises
1.	if user 1 wants to change the quantity of product_id = 1 (Laptop) from 2 to 5.
<SQL Solution>
2.	How to remove product_id = 7 (Bluetooth Speaker) from user 6's cart:
<SQL Solution>

3.	to find all products priced between $100 and $500:
<SQL Solution>

4.	retrieve all products with product_id values 1, 3, and 5:
<SQL Solution>

5.	to find all products whose names start with "Smart" (e.g., "Smartphone", "Smart Watch"):
<SQL Solution>

6.	create a full name of the product, combining the product_name and description:
<SQL Solution>
7.	to get the first 3 characters from the product_name:
<SQL Solution>
8.	to find products that cost more than $100 and have a stock quantity greater than 10:
<SQL Solution>

9.	to find products whose product_name does not start with the letter "A":
<SQL Solution>

10.	to find products with product_id values 2, 4, or 6:
<SQL Solution>

11.	to find products where the product_id is not 1, 3, or 5:
<SQL Solution>

12.	to find product names where the second character is "a":
<SQL Solution>
