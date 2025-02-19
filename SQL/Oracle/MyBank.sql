# MYSQL Database 
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

# CREATE table transaction - id, account id, type, amount, remarks
CREATE TABLE transaction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    type VARCHAR(100),
    amount DECIMAL(10, 2),
    remarks VARCHAR(100),
    FOREIGN KEY (account_id) REFERENCES account(id)
);

# alter transaction table to add transaction_date


# records for customer
INSERT INTO customer (name, age, address, city, state, country, phone, email) VALUES ('John Doe', 30, '123 Main St', 'New York', 'NY', 'USA', '123-456-7890', '');
INSERT INTO customer (name, age, address, city, state, country, phone, email) VALUES ('Jane Doe', 25, '123 Main St', 'New York', 'NY', 'USA', '123-456-7890', '');

# records for account
INSERT INTO account (customer_id, account_number, balance) VALUES (1, '1234567890', 1000.00);
INSERT INTO account (customer_id, account_number, balance) VALUES (2, '0987654321', 2000.00);

# records for transaction
INSERT INTO transaction (account_id, type, amount, remarks) VALUES (1, 'credit', 100.00, 'Initial Deposit');
INSERT INTO transaction (account_id, type, amount, remarks) VALUES (2, 'credit', 200.00, 'Initial Deposit');
COMMIT;


# View to show last 10 transaction for the customer of saving accounts
CREATE VIEW saving_account_transaction AS
SELECT c.name, a.account_number, t.type, t.amount, t.remarks
FROM customer c
JOIN account a ON c.id = a.customer_id
JOIN transaction t ON a.id = t.account_id
WHERE a.account_number LIKE '1%'
ORDER BY t.id DESC
LIMIT 10;


-- Oracle Pl/SQL create a procedure to dislay top 10 accounts and use a functions to calculate the balance
CREATE OR REPLACE PROCEDURE top_accounts
IS
    CURSOR c1 IS
    SELECT c.name, a.account_number, a.balance
    FROM customer c
    JOIN account a ON c.id = a.customer_id
    ORDER BY a.balance DESC
    LIMIT 10;
BEGIN
    FOR r1 IN c1
    LOOP
        DBMS_OUTPUT.PUT_LINE(r1.name || ' ' || r1.account_number || ' ' || r1.balance);
    END LOOP;
END;
/

-- Oracle Pl/SQL create a function to calculate the balance
CREATE OR REPLACE FUNCTION calculate_balance(account_id IN INT)
RETURN DECIMAL
IS
    total_balance DECIMAL;
BEGIN
    SELECT SUM(amount) INTO total_balance
    FROM transaction
    WHERE account_id = account_id;
    RETURN total_balance;
END;
/


