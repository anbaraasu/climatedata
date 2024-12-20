# Data Store - Memory, file, database
# Data - Raw facts and figures
# Information - Processed data
# Database - Collection of related data

# Database Management System - Software that manages the database
# RDBMS - Relational Database Management System - Data is stored in tables, rows and columns. Eg: Oracle, MySQL, SQL Server, DB2, PostgreSQL

# ACID properties
# A - Atomicity - All or nothing
# C - Consistency - Data is in a consistent state before and after the transaction
# I - Isolation - Transactions are isolated from each other
# D - Durability - Once a transaction is committed, it is permanent. (Hardware Failure)


# Entity relationship diagram
# Entity - Real world object
# Attribute - Property of an entity
# Relationship - Association between entities
# One to One - One entity is associated with one entity. Example: Person and Aadhar
# One to Many - One entity is associated with many entities. Example: Department and Employees
# Many to Many - Many entities are associated with many entities. Example: Students and Training, Authors and Books
# Many to One - Many entities are associated with one entity. Example: Employees and Department

# Normalization - Process of organizing data in a database. To reduce redundancy/duplicate/anomalies and improve data integrity. 


https://www.geeksforgeeks.org/introduction-of-database-normalization/


# Normalization - Process of organizing data in a database. To reduce redundancy/duplicate/anomalies and improve data integrity. 


# 1NF - Each column should have a single value. Example: Multiple Mobile Numbers should be split into Multiple rows, not columns

# 2NF - 1NF + No partial dependencies - All non-key attributes are fully functional dependent on the primary key. Example: Employee ID, Project ID, Hours worked. Employee ID and Project ID are the primary key. Hours worked is dependent on both Employee ID and Project ID

# 3NF - 2NF + No transitive dependencies non prime attributes

# BCNF (3.5 NF) - 3NF + No non-trivial dependencies

# 4NF - Multivalued dependencies
# 5NF - Join dependencies


# Transaction concepts
# Transaction - A single unit of work that is performed on the database. It is a sequence of operations that are treated as a single unit of work.
# Commit - Save the transaction
# Rollback - Undo the transaction
# Savepoint - A point in a transaction when you can roll back to without rolling back the entire transaction. Use case: If you do bulk employee insert of 100 records, you can savepoint after every 25 employee insert. If 26th employee insert fails, you can rollback to the savepoint and continue from there.


# Different Data Models : Relational, Object Oriented, OORDBMS
# RDBMS - Relational Database Management System. Example: Oracle, MySQL, SQL Server, DB2, PostgreSQL.
# OODBMS - Object Oriented Database Management System. Example: ObjectDB
    # OOPS: Object Oriented Programming System. Classes and Objects, Inheritance, Polymorphism, Encapsulation, Abstraction.
# ORDBMS - RDBMS + OODBMS = Object Relational Database Management System. Example: Oracle



Pending Topics:
-- types of Normalization (1NF, 2NF,3NF, BCNF)
https://www.geeksforgeeks.org/introduction-of-database-normalization/

# 1NF - Each column should have a single value. Example: Multiple Mobile Numbers should be split into Multiple rows, not columns

# 2NF - 1NF + No partial dependencies - All non-key attributes are fully functional dependent on the primary key. Example: Employee ID, Project ID, Hours worked. Employee ID and Project ID are the primary key. Hours worked is dependent on both Employee ID and Project ID

# 3NF - 2NF + No transitive dependencies
# BCNF - 3NF + No non-trivial dependencies
# 4NF - Multivalued dependencies
# 5NF - Join dependencies



# Savepoint - A point in a transaction when you can roll back to without rolling back the entire transaction. Use case: If you do bulk employee insert of 100 records, you can savepoint after every 25 employee insert. If 26th employee insert fails, you can rollback to the savepoint and continue from there.


# Introduction to Oracle database
# Oracle is a relational database management system. It is a product of Oracle Corporation. Oracle does not fully confirm to ORDBMS, but it has some features of ORDBMS. Oracle is a multi-model database management system. It supports SQL, PL/SQL, Java, XML, JSON, etc. 


