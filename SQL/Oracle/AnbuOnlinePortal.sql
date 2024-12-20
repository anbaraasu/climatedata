-- Create Sequences
CREATE SEQUENCE customer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE product_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Orders_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE payment_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE review_seq START WITH 1 INCREMENT BY 1;

-- Create Tables
CREATE TABLE Customer (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone VARCHAR2(15) UNIQUE NOT NULL,
    address VARCHAR2(255) NOT NULL
);

CREATE TABLE Product (
    product_id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description VARCHAR2(255),
    price NUMBER CHECK (price > 0),
    stock NUMBER CHECK (stock >= 0)
);

CREATE TABLE Orders (
    order_id NUMBER PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    order_date DATE DEFAULT SYSDATE,
    total_amount NUMBER CHECK (total_amount >= 0),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Payment (
    payment_id NUMBER PRIMARY KEY,
    order_id NUMBER NOT NULL,
    payment_date DATE DEFAULT SYSDATE,
    amount NUMBER CHECK (amount >= 0),
    payment_method VARCHAR2(50) CHECK (payment_method IN ('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer')),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE ProductReview (
    review_id NUMBER PRIMARY KEY,
    product_id NUMBER NOT NULL,
    customer_id NUMBER NOT NULL,
    rating NUMBER CHECK (rating BETWEEN 1 AND 5),
    review_text VARCHAR2(255),
    review_date DATE DEFAULT SYSDATE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create Triggers
CREATE OR REPLACE TRIGGER trg_customer_id
BEFORE INSERT ON Customer
FOR EACH ROW
BEGIN
    :NEW.customer_id := customer_seq.NEXTVAL;
END;
/
CREATE OR REPLACE TRIGGER trg_product_id
BEFORE INSERT ON Product
FOR EACH ROW
BEGIN
    :NEW.product_id := product_seq.NEXTVAL;
END;
/
CREATE OR REPLACE TRIGGER trg_order_id
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    :NEW.order_id := orders_seq.NEXTVAL;
END;
/
CREATE OR REPLACE TRIGGER trg_payment_id
BEFORE INSERT ON Payment
FOR EACH ROW
BEGIN
    :NEW.payment_id := payment_seq.NEXTVAL;
END;
/
CREATE OR REPLACE TRIGGER trg_review_id
BEFORE INSERT ON ProductReview
FOR EACH ROW
BEGIN
    :NEW.review_id := review_seq.NEXTVAL;
END;
/
-- Create Views
CREATE VIEW CustomerOrders AS
SELECT c.customer_id, c.name, o.order_id, o.order_date, o.total_amount
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id;

CREATE VIEW ProductReviews AS
SELECT p.product_id, p.name, r.review_id, r.rating, r.review_text, r.review_date
FROM Product p
JOIN ProductReview r ON p.product_id = r.product_id;

-- Top 5 Products by Sales, quantity sold, number of customers, product review rating
CREATE OR REPLACE VIEW Top5Products AS
SELECT 
    p.product_id,
    p.name,
    SUM(o.total_amount) AS total_sales,
    SUM(oi.quantity) AS quantity_sold,
    COUNT(DISTINCT o.customer_id) AS number_of_customers,
    AVG(r.rating) AS average_rating
FROM 
    Product p
JOIN 
    OrderItem oi ON p.product_id = oi.product_id
JOIN 
    Orders o ON oi.order_id = o.order_id
LEFT JOIN 
    ProductReview r ON p.product_id = r.product_id
GROUP BY 
    p.product_id, p.name
ORDER BY 
    total_sales DESC, quantity_sold DESC, number_of_customers DESC, average_rating DESC
FETCH FIRST 5 ROWS ONLY;


-- Create Indexes
CREATE INDEX idx_product_name ON Product(name);
CREATE INDEX idx_Orders_customer_id ON Orders(customer_id);
CREATE INDEX idx_payment_Orders_id ON Payment(order_id);
CREATE INDEX idx_review_product_id ON ProductReview(product_id);
CREATE INDEX idx_review_customer_id ON ProductReview(customer_id);

-- Create Packages
CREATE OR REPLACE PACKAGE ShoppingPkg AS
    PROCEDURE AddCustomer(p_name VARCHAR2, p_email VARCHAR2, p_phone VARCHAR2, p_address VARCHAR2);
    FUNCTION GetCustomerOrders(p_customer_id NUMBER) RETURN SYS_REFCURSOR;
    PROCEDURE AddProduct(p_name VARCHAR2, p_description VARCHAR2, p_price NUMBER, p_stock NUMBER);
    FUNCTION GetProductReviews(p_product_id NUMBER) RETURN SYS_REFCURSOR;
END ShoppingPkg;
/
CREATE OR REPLACE PACKAGE BODY ShoppingPkg AS
    PROCEDURE AddCustomer(p_name VARCHAR2, p_email VARCHAR2, p_phone VARCHAR2, p_address VARCHAR2) IS
    BEGIN
        INSERT INTO Customer (name, email, phone, address) VALUES (p_name, p_email, p_phone, p_address);
    END AddCustomer;

    FUNCTION GetCustomerOrders(p_customer_id NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT * FROM CustomerOrders WHERE customer_id = p_customer_id;
        RETURN v_cursor;
    END GetCustomerOrders;

    PROCEDURE AddProduct(p_name VARCHAR2, p_description VARCHAR2, p_price NUMBER, p_stock NUMBER) IS
    BEGIN
        INSERT INTO Product (name, description, price, stock) VALUES (p_name, p_description, p_price, p_stock);
    END AddProduct;

    FUNCTION GetProductReviews(p_product_id NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT * FROM ProductReviews WHERE product_id = p_product_id;
        RETURN v_cursor;
    END GetProductReviews;
END ShoppingPkg;
/

-- Test Data
INSERT INTO Customer (customer_id, name, email, phone, address) VALUES (customer_seq.NEXTVAL, 'John Doe', 'email@email.com', '123-456-7890', '123 Main St');
INSERT INTO Customer (customer_id, name, email, phone, address) VALUES (customer_seq.NEXTVAL, 'Jane Smith', 'email@email.com', '123-456-7890', '456 Elm St');

-- Test data for mobile category products
INSERT INTO Product (product_id, name, description, price, stock) VALUES (product_seq.NEXTVAL, 'iPhone 12', 'Apple iPhone 12', 799, 100);
INSERT INTO Product (product_id, name, description, price, stock) VALUES (product_seq.NEXTVAL, 'Samsung Galaxy S21', 'Samsung Galaxy S21', 899, 50);

-- Test data for laptop category products
INSERT INTO Product (product_id, name, description, price, stock) VALUES (product_seq.NEXTVAL, 'MacBook Pro', 'Apple MacBook Pro', 1299, 75);
INSERT INTO Product (product_id, name, description, price, stock) VALUES (product_seq.NEXTVAL, 'Dell XPS 13', 'Dell XPS 13', 999, 100);

-- Test data for orders
INSERT INTO Orders (order_id, customer_id, total_amount) VALUES (orders_seq.NEXTVAL, 1, 799);
INSERT INTO Orders (order_id, customer_id, total_amount) VALUES (orders_seq.NEXTVAL, 2, 1299);

-- Test data for payments
INSERT INTO Payment (payment_id, order_id, amount, payment_method) VALUES (payment_seq.NEXTVAL, 1, 799, 'Credit Card');
INSERT INTO Payment (payment_id, order_id, amount, payment_method) VALUES (payment_seq.NEXTVAL, 2, 1299, 'Credit Card');


-- Procedure to order the previesouly orders items as new order on every month automatically for each customer
CREATE OR REPLACE PROCEDURE AutoOrder AS
BEGIN
    FOR c IN (SELECT DISTINCT customer_id FROM Orders)
    LOOP
        INSERT INTO Orders (order_id, customer_id, total_amount)
        SELECT orders_seq.NEXTVAL, c.customer_id, SUM(total_amount)
        FROM Orders
        WHERE customer_id = c.customer_id
        AND EXTRACT(MONTH FROM order_date) = EXTRACT(MONTH FROM SYSDATE)
        GROUP BY customer_id;
    END LOOP;
END AutoOrder;
/
