-- Oracle Triggers - A trigger is a PL/SQL block structure which is fired when a DML statements like Insert, Delete, Update is executed on a database table. A trigger is triggered automatically when an associated DML statement is executed. The triggers are database object which is bound to a table and is executed automatically. Triggers are used to maintain the integrity of the database. Triggers can be used to check the integrity of the data entered into the table. Triggers can be used to automatically generate values for specific columns. Triggers can be used to automatically update the data in the table based on the data in another table.

-- Types of Triggers
-- There are two types of triggers in Oracle:
-- - Row Level Trigger - Fires for each row affected by the triggering statement.
-- - Statement Level Trigger - Fires once for the triggering statement.

-- Syntax:
-- CREATE [OR REPLACE] TRIGGER trigger_name
-- {BEFORE | AFTER | INSTEAD OF} {INSERT | DELETE | UPDATE [OF column_name]}
-- ON table_name
-- [FOR EACH ROW]
-- [WHEN condition]
-- BEGIN
--     -- Trigger code
-- EXCEPTION
--     -- Exception handling code
-- END trigger_name;
-- /

-- Features of Triggers
-- Data Integrity (complex constraints )
-- Auditing
-- Synchronization (backup)
-- Data Validation
-- Complex Security Authorization
-- Automatic Generation of Values
-- Updating derived columns
    -- Age, AgeGroup - AgeGroup is derived from Age, age < 18 - Child, age >= 18 - Adult

--Limitations of Triggers
-- Triggers are not supported on views.
-- Triggers cannot be defined on system tables.
-- Triggers cannot be defined on temporary tables.

