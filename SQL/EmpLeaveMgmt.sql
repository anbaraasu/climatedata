/*
#######################################################################################
# PROJECT NAME: EMPLOYEE LEAVE MGMT SYSTEM
# SQUAD: ELM SQUAD
#  
# MEMBERS: ANBU
# NORMALIZATION LEVEL: 3NF
#
#######################################################################################
*/

-- TABLE EMPLOYEES - contains employee details - developed by Anbu
CREATE TABLE EMPLOYEES (
    ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR2(15),
    LAST_NAME VARCHAR2(15),
    EMAIL VARCHAR2(30) UNIQUE ,
    GENDER CHAR(1) ,
    PHONE_NUMBER VARCHAR2(15),
    HIRE_DATE DATE, 
    DESIGNATION VARCHAR2(50),
    SALARY NUMBER(15,2) ,
    CONSTRAINT CHK_SALARY CHECK (SALARY > 0),
    CONSTRAINT NN_FIRST_NAME CHECK (FIRST_NAME IS NOT NULL),
    CONSTRAINT CHK_GENDER CHECK (GENDER IN ('M','F','O')),
    CONSTRAINT CHK_EMAIL CHECK (REGEXP_LIKE(EMAIL, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$'))
);

-- TABLE LEAVE_TYPES - B 
CREATE TABLE LEAVE_TYPES (
    ID INT PRIMARY KEY,
    TYPE CHAR(2) NOT NULL UNIQUE, 
    DESCRIPTION VARCHAR2(50),
    MAX_DAYS INT CHECK (MAX_DAYS > 0)
);

-- TABLE LEAVE_REQUEST - C 
CREATE TABLE LEAVE_REQUEST (
    ID INT PRIMARY KEY,
    EMPLOYEE_ID INT,
    LEAVE_TYPE_ID INT,
    START_DATE DATE,
    END_DATE DATE,
    STATUS VARCHAR2(15) CHECK (STATUS IN ('APPROVED', 'REJECTED', 'PENDING')),
    APPROVED_BY INT,
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEES(ID),
    FOREIGN KEY (LEAVE_TYPE_ID) REFERENCES LEAVE_TYPES(ID)
);

-- INDEX FOR STATUS ON LEAVE_REQUEST - developed by Anbu
CREATE INDEX LEAVE_REQ_STATUS_IDX ON LEAVE_REQUEST(STATUS);

-- SEQUENCE 
-- Seq for EMPLOYEES table - developed by Anbu 
CREATE SEQUENCE EMPLOYEES_SEQ 
START WITH 5000000 
INCREMENT BY 1;

-- Seq for LEAVE_TYPES table - developed by Anbu
CREATE SEQUENCE LEAVE_TYPES_SEQ
START WITH 1000
INCREMENT BY 1;

-- Seq for LEAVE_REQUEST table - developed by Anbu
CREATE SEQUENCE LEAVE_REQ_SEQ 
START WITH 10000
INCREMENT BY 1;


-- EMPLOYEES RECORDS 
INSERT INTO EMPLOYEES VALUES (EMPLOYEES_SEQ.NEXTVAL, 'Anbu', 'Mani', 'anbu@hcltech.com', 'M', '9876543210', '01-JAN-2020', 'Software Engineer', 50000);
INSERT INTO EMPLOYEES VALUES (EMPLOYEES_SEQ.NEXTVAL, 'Raj', 'Kumar', 'raj@hcltech.com', 'M', '9876543211', '01-JAN-2020', 'Software Engineer', 50000);
INSERT INTO EMPLOYEES VALUES (EMPLOYEES_SEQ.NEXTVAL, 'Rani', 'Kumari', 'rani@hcltech.com', 'F', '9876543212', '01-JAN-2020', 'Technical Architect', 500000);

-- Below insert will fail due to email pattern mismatch
INSERT INTO EMPLOYEES VALUES (EMPLOYEES_SEQ.NEXTVAL, 'Rajesh', 'Kumar', 'rajesh', 'M', '9876543213', '01-JAN-2020', 'Software Engineer', 50000);
COMMIT;

-- LEAVE_TYPES RECORDS
INSERT INTO LEAVE_TYPES VALUES (LEAVE_TYPES_SEQ.NEXTVAL, 'AL', 'Annual LEAVE', 5);
INSERT INTO LEAVE_TYPES VALUES (LEAVE_TYPES_SEQ.NEXTVAL, 'RH', 'Restricted LEAVE', 3);
INSERT INTO LEAVE_TYPES VALUES (LEAVE_TYPES_SEQ.NEXTVAL, 'ML', 'My LEAVE', 2);
COMMIT;

-- LEAVE_REQUEST RECORDS
INSERT INTO LEAVE_REQUEST VALUES (LEAVE_REQ_SEQ.NEXTVAL, 5000000, 1000, '01-JAN-2024', '05-JAN-2024', 'APPROVED', 5000002);
INSERT INTO LEAVE_REQUEST VALUES (LEAVE_REQ_SEQ.NEXTVAL, 5000001, 1001, '01-JAN-2024', '03-JAN-2024', 'REJECTED', 5000002);
INSERT INTO LEAVE_REQUEST VALUES (LEAVE_REQ_SEQ.NEXTVAL, 5000001, 1001, '07-JAN-2024', '07-JAN-2024', 'PENDING', NULL);
COMMIT;

-- View - pending leaves 
CREATE OR REPLACE VIEW PENDING_LEAVES AS
SELECT 
    LR.ID EMP_ID,
    E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE_NAME,
    LT.TYPE AS LEAVE_TYPE,
    LR.START_DATE,
    LR.END_DATE
FROM
    LEAVE_REQUEST LR
    JOIN EMPLOYEES E ON LR.EMPLOYEE_ID = E.ID
    JOIN LEAVE_TYPES LT ON LR.LEAVE_TYPE_ID = LT.ID
WHERE
    LR.STATUS = 'PENDING';


-- PROCEDURE - to approve leave request if the leave is pending, today - start date is  greater than or equal to 5
CREATE OR REPLACE PROCEDURE AUTO_APPROVE_LEAVE_REQUEST
AS
BEGIN
    UPDATE LEAVE_REQUEST
    SET 
    STATUS = 'APPROVED',
    APPROVED_BY = 5000002
    WHERE STATUS = 'PENDING' AND TRUNC(SYSDATE) >= TRUNC(START_DATE) + 5;
    COMMIT;
END;
/

EXECUTE AUTO_APPROVE_LEAVE_REQUEST;