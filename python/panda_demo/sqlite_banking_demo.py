import sqlite3

# -------------------------------
# Example: SQLite Banking Domain Operations
# -------------------------------

# Step 1: Connect to SQLite database (or create it if it doesn't exist)
db_path = "banking.db"
conn = sqlite3.connect(db_path)
cursor = conn.cursor()
print(f"Connected to SQLite database: {db_path}")

# Step 2: Create tables with constraints
# Customers table
cursor.execute("""
CREATE TABLE IF NOT EXISTS Customers (
    Customer_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Email TEXT UNIQUE NOT NULL,
    Phone TEXT UNIQUE NOT NULL,
    Address TEXT NOT NULL
)
""")
print("Table 'Customers' created.")

# Accounts table
cursor.execute("""
CREATE TABLE IF NOT EXISTS Accounts (
    Account_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Customer_ID INTEGER NOT NULL,
    Account_Type TEXT CHECK(Account_Type IN ('Savings', 'Current')) NOT NULL,
    Balance REAL CHECK(Balance >= 0) NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
)
""")
print("Table 'Accounts' created.")

# Transactions table
cursor.execute("""
CREATE TABLE IF NOT EXISTS Transactions (
    Transaction_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Account_ID INTEGER NOT NULL,
    Transaction_Type TEXT CHECK(Transaction_Type IN ('Deposit', 'Withdrawal')) NOT NULL,
    Amount REAL CHECK(Amount > 0) NOT NULL,
    Transaction_Date TEXT NOT NULL,
    FOREIGN KEY (Account_ID) REFERENCES Accounts(Account_ID)
)
""")
print("Table 'Transactions' created.")

# Step 3: Insert records into the tables
# Insert customers
cursor.executemany("""
INSERT INTO Customers (Name, Email, Phone, Address)
VALUES (?, ?, ?, ?)
""", [
    ("Alice", "alice@example.com", "1234567890", "123 Main St"),
    ("Bob", "bob@example.com", "0987654321", "456 Elm St"),
    ("Charlie", "charlie@example.com", "1122334455", "789 Oak St")
])
conn.commit()
print("Records inserted into 'Customers' table.")

# Insert accounts
cursor.executemany("""
INSERT INTO Accounts (Customer_ID, Account_Type, Balance)
VALUES (?, ?, ?)
""", [
    (1, "Savings", 1000.0),
    (1, "Current", 5000.0),
    (2, "Savings", 2000.0),
    (3, "Savings", 1500.0)
])
conn.commit()
print("Records inserted into 'Accounts' table.")

# Insert transactions
cursor.executemany("""
INSERT INTO Transactions (Account_ID, Transaction_Type, Amount, Transaction_Date)
VALUES (?, ?, ?, ?)
""", [
    (1, "Deposit", 500.0, "2023-01-01"),
    (1, "Withdrawal", 200.0, "2023-01-02"),
    (2, "Deposit", 1000.0, "2023-01-03"),
    (3, "Withdrawal", 500.0, "2023-01-04"),
    (4, "Deposit", 300.0, "2023-01-05")
])
conn.commit()
print("Records inserted into 'Transactions' table.")

# Step 4: Display records
print("\nCustomers:")
for row in cursor.execute("SELECT * FROM Customers"):
    print(row)

print("\nAccounts:")
for row in cursor.execute("SELECT * FROM Accounts"):
    print(row)

print("\nTransactions:")
for row in cursor.execute("SELECT * FROM Transactions"):
    print(row)

# Step 5: Filtering - Select transactions with Amount > 400
print("\nFiltered Transactions (Amount > 400):")
for row in cursor.execute("SELECT * FROM Transactions WHERE Amount > 400"):
    print(row)

# Step 6: Aggregating - Calculate the total balance across all accounts
cursor.execute("SELECT SUM(Balance) AS Total_Balance FROM Accounts")
total_balance = cursor.fetchone()[0]
print(f"\nTotal Balance Across All Accounts: {total_balance}")

# Step 7: Sorting - Sort customers by Name
print("\nCustomers Sorted by Name:")
for row in cursor.execute("SELECT * FROM Customers ORDER BY Name ASC"):
    print(row)

# Step 8: Close the database connection
conn.close()
print("\nDatabase connection closed.")
