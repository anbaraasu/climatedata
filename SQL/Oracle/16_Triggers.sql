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
-- DECLARE
-- BEGIN
--     -- Trigger code
-- EXCEPTION
--     -- Exception handling code
-- END trigger_name;
-- /

-- Features of Triggers
-- Data Integrity (complex constraints )
-- Auditing (few cols in every tables - createdby, modifiedby, createddate, MODIFIEDdate or separate table), LOG  (master or important or critical tables.. )
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

DROP TABLE PERSON_DETAILS;
CREATE TABLE PERSON_DETAILS(ID INT, NAME VARCHAR2(10), AGE INT, AGE_GROUP VARCHAR2(10) INVISIBLE, SALARY NUMBER(15,2));

SELECT * FROM PERSON_DETAILS;

-- Trigger Demo for using BEFORE INSERT or UPDATE 
CREATE OR REPLACE TRIGGER person_age_group_trg
BEFORE INSERT OR UPDATE OF AGE
ON PERSON_DETAILS 
FOR EACH ROW
-- trigger when age is not null value
WHEN (NEW.AGE IS NOT NULL)
BEGIN
    -- Trigger code here
    -- You can access the values of the new row using :NEW.column_name
    -- For example, :NEW.ID, :NEW.NAME, :NEW.AGE, :NEW.AGE_GROUP
    -- TO REF VAR :OLD, :NEW
    -- :OLD - Represents the old value of the column in case of an update or delete operation
    -- :NEW - Represents the new value of the column in case of an insert or update operation
    -- Perform any necessary validations or modifications to the new row values
    
    -- Example: Set AGE_GROUP based on AGE
    IF :NEW.AGE < 18 THEN
        --:NEW.AGE_GROUP := 'Child';
        DBMS_OUTPUT.PUT_LINE('Child');
    ELSE
        --:NEW.AGE_GROUP := 'Adult';
        DBMS_OUTPUT.PUT_LINE('Adult');
    END IF;
    
    -- You can also raise an exception to prevent the insert or update if needed
    -- Example: Prevent inserting or updating rows with AGE < 0
    IF :NEW.AGE < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Age cannot be negative');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Trigger fired..');
END person_age_group_trg;
/


CREATE SEQUENCE PERSON_DETAILS_SEQ;

DROP TABLE PERSON_DETAILS;
CREATE TABLE PERSON_DETAILS(ID INT, NAME VARCHAR2(10), AGE INT, AGE_GROUP VARCHAR2(10), SALARY NUMBER(15,2));





CREATE OR REPLACE TRIGGER PERSON_DETAILS_ID_SEQ_TRG BEFORE INSERT ON PERSON_DETAILS FOR EACH ROW
BEGIN
    SELECT PERSON_DETAILS_SEQ.NEXTVAL INTO :NEW.ID FROM DUAL;
END;
/

INSERT INTO PERSON_DETAILS(NAME, AGE, SALARY) VALUES('A', 21, 1000);

SELECT * FROM PERSON_DETAILS;


CREATE TABLE PERSON_AUDIT(ID INT PRIMARY KEY, PERSON_ID INT, 
OLD_SALARY NUMBER(15,2), NEW_SALARY NUMBER(15,2), 
ACTION CHAR(1), ACTION_DATE DATE, USER_NAME VARCHAR2(50));

CREATE SEQUENCE PERSON_AUDIT_SEQ;

-- Realistic Usecase for AFTER INSERT/UPDATE
CREATE OR REPLACE TRIGGER trg_person_audit
AFTER INSERT OR UPDATE OR DELETE OF SALARY
ON PERSON_DETAILS
FOR EACH ROW
WHEN (NEW.SALARY IS NOT NULL)
DECLARE
    AUDIT_REC PERSON_AUDIT%ROWTYPE;
BEGIN
    -- Log the changes to a separate table
    AUDIT_REC.ID := PERSON_AUDIT_SEQ.NEXTVAL;
    
    AUDIT_REC.ACTION_DATE := SYSDATE;
    AUDIT_REC.USER_NAME := USER;
    AUDIT_REC.PERSON_ID := :NEW.ID;
    AUDIT_REC.NEW_SALARY := :NEW.SALARY;

    IF INSERTING THEN   
        AUDIT_REC.ACTION := 'I';
    ELSIF UPDATING THEN
        AUDIT_REC.OLD_SALARY := :OLD.SALARY;
        AUDIT_REC.ACTION := 'U';
    ELSE -- ELSIF DELETING THEN
        AUDIT_REC.PERSON_ID := :OLD.ID;
        AUDIT_REC.OLD_SALARY := :OLD.SALARY;
        AUDIT_REC.ACTION := 'D';
    END IF;

    -- Insert the audit record into the audit table
    INSERT INTO PERSON_AUDIT VALUES AUDIT_REC;
END trg_person_audit;
/

TRUNCATE TABLE PERSON_DETAILS;
SELECT * FROM PERSON_AUDIT;

-- TEST
INSERT INTO PERSON_DETAILS(ID, NAME, AGE, SALARY) VALUES(2, 'B', 25, 2000);

SELECT * FROM PERSON_AUDIT;

-- TEST
INSERT INTO PERSON_DETAILS(ID, NAME, AGE, SALARY) VALUES(1, 'A', 21, 5000);

SELECT * FROM PERSON_AUDIT;

UPDATE PERSON_DETAILS SET SALARY = 3000 WHERE ID = 2;

SELECT * FROM PERSON_AUDIT;

DELETE FROM PERSON_DETAILS;

SELECT * FROM PERSON_AUDIT;

SELECT * FROM PERSON_DETAILS;

-- iTime table - id (pk), emp_name, week_num, hours_worked, createdby, modifiedby, createddate, updatedate
DROP TABLE ITime;
CREATE TABLE iTime(
    id INT PRIMARY KEY, 
    emp_name VARCHAR2(50), 
    week_num INT, 
    hours_worked INT, 
    approved_emp_name VARCHAR2(50),
    createdby VARCHAR2(50),
    modifiedby VARCHAR2(50), 
    createddate DATE, 
    updatedate DATE);

-- trigger to update createdby, modifiedby, createddate, updatedate
CREATE OR REPLACE TRIGGER iTime_trg
BEFORE INSERT OR UPDATE 
ON iTime
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.CREATEDBY := USER;
        :NEW.CREATEDDATE := SYSDATE;
    END IF;
    
    IF UPDATING THEN
        :NEW.MODIFIEDBY := USER;
        :NEW.UPDATEDATE := SYSDATE;
    END IF;
END iTime_trg;
/
SELECT * FROM iTime;
-- TEST
INSERT INTO iTime(ID, EMP_NAME, WEEK_NUM, HOURS_WORKED) VALUES(1, 'A', 1, 40);
SELECT * FROM iTime;
UPDATE iTime SET approved_emp_name = 'B' WHERE ID = 1;
SELECT * FROM iTime;

-- seq for itime audit pk 
DROP SEQUENCE ITime_AUDIT_SEQ;
CREATE SEQUENCE ITime_AUDIT_SEQ;

-- itime Audit Table 
DROP TABLE ITime_AUDIT;
CREATE TABLE ITime_AUDIT(
    id INT PRIMARY KEY, 
    emp_name VARCHAR2(50), 
    old_hours_worked INT,
    new_hours_worked INT,
    action CHAR(1),
    action_date DATE,
    user_name VARCHAR2(50)
);

-- trigger for itime audit 
CREATE OR REPLACE TRIGGER iTime_audit_trg
AFTER INSERT OR UPDATE OR DELETE
ON iTime
FOR EACH ROW
DECLARE
    AUDIT_REC ITime_AUDIT%ROWTYPE;
BEGIN
    AUDIT_REC.EMP_NAME := :NEW.EMP_NAME;
    AUDIT_REC.ACTION_DATE := SYSDATE;
    AUDIT_REC.USER_NAME := USER;
    AUDIT_REC.ID := ITime_AUDIT_SEQ.nextval;
    IF INSERTING THEN
        AUDIT_REC.ACTION := 'I';
        AUDIT_REC.new_hours_worked := :NEW.hours_worked;
    ELSIF UPDATING THEN
        AUDIT_REC.old_hours_worked := :OLD.hours_worked;
        AUDIT_REC.new_hours_worked := :NEW.hours_worked;
        AUDIT_REC.ACTION := 'U';
    ELSE -- DELETING
        AUDIT_REC.old_hours_worked := :OLD.hours_worked;
        AUDIT_REC.EMP_NAME := :OLD.EMP_NAME;
        AUDIT_REC.ACTION := 'D';
    END IF;
    
    INSERT INTO ITime_AUDIT VALUES AUDIT_REC;
END iTime_audit_trg;   
/

TRUNCATE TABLE ITime;
TRUNCATE TABLE ITime_AUDIT;

SELECT * FROM ITime_AUDIT ORDER BY ACTION_DATE DESC;
-- TEST
INSERT INTO iTime(ID, EMP_NAME, WEEK_NUM, HOURS_WORKED) VALUES(1, 'A', 1, 40);
INSERT INTO iTime(ID, EMP_NAME, WEEK_NUM, HOURS_WORKED) VALUES(2, 'B', 1, 40);
SELECT * FROM ITime_AUDIT ORDER BY ACTION_DATE DESC;
UPDATE iTime SET approved_emp_name = 'B' WHERE ID = 1;
SELECT * FROM ITime_AUDIT ORDER BY ACTION_DATE DESC;
DELETE FROM iTime;
SELECT * FROM ITime_AUDIT ORDER BY ACTION_DATE DESC;


-- itime backup table
DROP TABLE ITime_BACKUP;
CREATE TABLE ITime_BACKUP AS SELECT * FROM ITime WHERE 1 = 2;

-- trigger for itime backup
-- trigger for itime backup
CREATE OR REPLACE TRIGGER iTime_backup_trg
AFTER INSERT OR UPDATE OR DELETE
ON iTime
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO ITime_BACKUP 
        VALUES (:NEW.id, :NEW.emp_name, :NEW.week_num, :NEW.hours_worked, :NEW.approved_emp_name, :NEW.createdby, :NEW.modifiedby, :NEW.createddate, :NEW.updatedate);
    ELSIF UPDATING THEN
        UPDATE ITime_BACKUP SET emp_name = :NEW.emp_name, 
        week_num = :NEW.week_num, 
        hours_worked = :NEW.hours_worked, 
        approved_emp_name = :NEW.approved_emp_name, 
        createdby = :NEW.createdby, 
        modifiedby = :NEW.modifiedby, 
        createddate = :NEW.createddate, 
        updatedate = :NEW.updatedate WHERE id = :NEW.id;
    END IF;
END iTime_backup_trg;
/

TRUNCATE TABLE ITime;
TRUNCATE TABLE ITime_AUDIT;

SELECT * FROM ITime_AUDIT ORDER BY ACTION_DATE DESC;
-- TEST
INSERT INTO iTime(ID, EMP_NAME, WEEK_NUM, HOURS_WORKED) VALUES(1, 'A', 1, 40);
INSERT INTO iTime(ID, EMP_NAME, WEEK_NUM, HOURS_WORKED) VALUES(2, 'B', 1, 40);
SELECT * FROM ITime_AUDIT ORDER BY ACTION_DATE DESC;
UPDATE iTime SET approved_emp_name = 'B' WHERE ID = 1;
SELECT * FROM ITime_AUDIT ORDER BY ACTION_DATE DESC;
DELETE FROM iTime;
SELECT * FROM ITime_AUDIT ORDER BY ACTION_DATE DESC;

SELECT * FROM ITIME_BACKUP;
