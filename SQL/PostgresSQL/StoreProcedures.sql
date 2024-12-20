-- PostgresSQL Database
-- Creating Customers table
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

-- Creating Branches table
CREATE TABLE Branches (
    BranchID SERIAL PRIMARY KEY,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200)
);

-- Creating Accounts table
CREATE TABLE Accounts (
    AccountID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    BranchID INT REFERENCES Branches(BranchID),
    AccountType VARCHAR(50),
    Balance DECIMAL(10, 2),
    CreatedDate DATE
);

-- Creating Transactions table
CREATE TABLE Transactions (
    TransactionID SERIAL PRIMARY KEY,
    AccountID INT REFERENCES Accounts(AccountID),
    TransactionType VARCHAR(50),
    Amount DECIMAL(10, 2),
    TransactionDate TIMESTAMP
);

-- Inserting data into Customers table
INSERT INTO Customers (FirstName, LastName, DateOfBirth, Email, Phone) VALUES
('John', 'Doe', '1985-01-15', 'john.doe@example.com', '123-456-7890'),
('Jane', 'Smith', '1990-02-20', 'jane.smith@example.com', '123-456-7891'),
('Michael', 'Johnson', '1982-03-25', 'michael.johnson@example.com', '123-456-7892'),
('Emily', 'Davis', '1995-04-30', 'emily.davis@example.com', '123-456-7893'),
('David', 'Miller', '1988-05-10', 'david.miller@example.com', '123-456-7894'),
('Sarah', 'Wilson', '1979-06-12', 'sarah.wilson@example.com', '123-456-7895'),
('James', 'Brown', '1980-07-19', 'james.brown@example.com', '123-456-7896'),
('Laura', 'Taylor', '1992-08-23', 'laura.taylor@example.com', '123-456-7897'),
('Robert', 'Anderson', '1984-09-27', 'robert.anderson@example.com', '123-456-7898'),
('Linda', 'Thomas', '1987-10-29', 'linda.thomas@example.com', '123-456-7899');

-- Inserting data into Branches table
INSERT INTO Branches (BranchName, BranchAddress) VALUES
('Central Branch', '123 Main St, City, Country'),
('West Branch', '456 Elm St, City, Country'),
('East Branch', '789 Oak St, City, Country');

-- Inserting data into Accounts table
INSERT INTO Accounts (CustomerID, BranchID, AccountType, Balance, CreatedDate) VALUES
(1, 1, 'Savings', 1000.00, '2022-01-01'),
(2, 1, 'Checking', 1500.00, '2022-02-01'),
(3, 2, 'Savings', 2000.00, '2022-03-01'),
(4, 2, 'Checking', 2500.00, '2022-04-01'),
(5, 3, 'Savings', 3000.00, '2022-05-01'),
(6, 3, 'Checking', 3500.00, '2022-06-01'),
(7, 1, 'Savings', 4000.00, '2022-07-01'),
(8, 2, 'Checking', 4500.00, '2022-08-01'),
(9, 3, 'Savings', 5000.00, '2022-09-01'),
(10, 1, 'Checking', 5500.00, '2022-10-01');

-- Inserting data into Transactions table
INSERT INTO Transactions (AccountID, TransactionType, Amount, TransactionDate) VALUES
(1, 'Deposit', 500.00, '2023-01-01 10:00:00'),
(2, 'Withdrawal', 200.00, '2023-01-02 11:00:00'),
(3, 'Deposit', 300.00, '2023-01-03 12:00:00'),
(4, 'Withdrawal', 400.00, '2023-01-04 13:00:00'),
(5, 'Deposit', 500.00, '2023-01-05 14:00:00'),
(6, 'Withdrawal', 600.00, '2023-01-06 15:00:00'),
(7, 'Deposit', 700.00, '2023-01-07 16:00:00'),
(8, 'Withdrawal', 800.00, '2023-01-08 17:00:00'),
(9, 'Deposit', 900.00, '2023-01-09 18:00:00'),
(10, 'Withdrawal', 1000.00, '2023-01-10 19:00:00');

# Stored Procedures is a set of SQL statements that are stored in the database and can be called by name to perform a specific task. Stored procedures can be used to encapsulate complex logic, improve performance, and enhance security.

# Stored Procedure Demo
# Use case: Get top 10 transactions for a specific account
CREATE OR REPLACE FUNCTION GenerateMiniTransactions(account_id INT)
RETURNS TABLE (
    TransactionID INT,
    TransactionType VARCHAR(50),
    Amount DECIMAL(10, 2),
    TransactionDate TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT TransactionID, TransactionType, Amount, TransactionDate
    FROM Transactions
    WHERE AccountID = account_id
    ORDER BY TransactionDate DESC
    LIMIT 10;
END;

$$ LANGUAGE plpgsql;

# Calling the stored procedure
SELECT * FROM GenerateMiniTransactions(1);