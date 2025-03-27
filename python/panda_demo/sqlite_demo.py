import sqlite3

# -------------------------------
# Example: SQLite Database Operations
# -------------------------------

# Step 1: Connect to SQLite database (or create it if it doesn't exist)
db_path = "example.db"
conn = sqlite3.connect(db_path)
cursor = conn.cursor()
print(f"Connected to SQLite database: {db_path}")

# Step 2: Create a table
cursor.execute("""
CREATE TABLE IF NOT EXISTS Employees (
    Employee_ID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Department TEXT NOT NULL,
    Salary REAL NOT NULL,
    Years_of_Experience INTEGER NOT NULL
)
""")
print("Table 'Employees' created (if not already exists).")

# Step 3: Insert records into the table
cursor.executemany("""
INSERT INTO Employees (Employee_ID, Name, Department, Salary, Years_of_Experience)
VALUES (?, ?, ?, ?, ?)
""", [
    (1, "Alice", "HR", 50000, 5),
    (2, "Bob", "IT", 60000, 7),
    (3, "Charlie", "Finance", 55000, 6),
    (4, "David", "IT", 70000, 8),
    (5, "Eve", "HR", 65000, 10)
])
conn.commit()
print("Records inserted into 'Employees' table.")

# Step 4: Display all records
print("\nAll Records:")
for row in cursor.execute("SELECT * FROM Employees"):
    print(row)

# Step 5: Filtering - Select employees with Salary > 55000
print("\nFiltered Records (Salary > 55000):")
for row in cursor.execute("SELECT * FROM Employees WHERE Salary > 55000"):
    print(row)

# Step 6: Aggregating - Calculate the average salary
cursor.execute("SELECT AVG(Salary) AS Average_Salary FROM Employees")
average_salary = cursor.fetchone()[0]
print(f"\nAverage Salary: {average_salary}")

# Step 7: Sorting - Sort employees by Salary in descending order
print("\nSorted Records (by Salary, descending):")
for row in cursor.execute("SELECT * FROM Employees ORDER BY Salary DESC"):
    print(row)

# Step 8: Close the database connection
conn.close()
print("\nDatabase connection closed.")
