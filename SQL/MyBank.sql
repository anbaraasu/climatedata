use db_7885
# CREATE table customer - id auto increment, name, age, address, city, state, country, phone, email
CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    address VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    phone VARCHAR(100),
    email VARCHAR(100)
);

# CREATE table account - id auto increment, customer_id, account_number, balance
CREATE TABLE account (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    account_number VARCHAR(100),
    balance DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

# records for customer
INSERT INTO customer (name, age, address, city, state, country, phone, email) VALUES ('John Doe', 30, '123 Main St', 'New York', 'NY', 'USA', '123-456-7890', '');
INSERT INTO customer (name, age, address, city, state, country, phone, email) VALUES ('Jane Doe', 25, '123 Main St', 'New York', 'NY', 'USA', '123-456-7890', '');

# records for account
INSERT INTO account (customer_id, account_number, balance) VALUES (1, '1234567890', 1000.00);
INSERT INTO account (customer_id, account_number, balance) VALUES (2, '0987654321', 2000.00);

COMMIT;

# View creation - Customer Account details

