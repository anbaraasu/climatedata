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

-- all drop 

DROP TABLE LEAVE;
DROP TABLE COMP_HOLIDAYS;
DROP TABLE LEAVE_BALANCE;
DROP TABLE EMPLOYEES;
DROP SEQUENCE EMP_ID_SEQ;
DROP VIEW PENDING_LEAVES;
DROP VIEW EMPLOYEE_LEAVE_DETAILS;

-- TABLES -> EMPLOYEES, LEAVE, COMP_HOLIDAYS, LEAVE_BALANCE
-- TABLE EMPLOYEES - contains employee details - developed by Anbu. EMP_ID PK, EMP_NAME, MGR_ID, EMAIL, PHONE, SAL, DOJ

CREATE TABLE EMPLOYEES(EMP_ID INT,
    EMP_NAME VARCHAR(50) NOT NULL,
    MGR_ID INT,
    EMAIL VARCHAR(50),
    GENDER CHAR(1),
    PHONE NUMBER(10), 
	SAL NUMBER(10,2), 
    DOJ DATE DEFAULT SYSDATE,
    CONSTRAINT FK_EMP_MGR_ID FOREIGN KEY (MGR_ID) REFERENCES EMPLOYEES(EMP_ID),
    CONSTRAINT UQ_EMP_EMAIL UNIQUE(EMAIL),CONSTRAINT UQ_EMP_PHONE UNIQUE(PHONE),
    CONSTRAINT PK_EMP_EMP_ID PRIMARY KEY(EMP_ID),
	CONSTRAINT CK_EMP_SAL CHECK(SAL > 0),
	CONSTRAINT CK_EMP_PHONE CHECK(LENGTH(PHONE) = 10),
	CONSTRAINT CK_EMP_EMAIL CHECK(EMAIL LIKE '%@%.%'));

-- TABLE LEAVE - contains leave details - developed by Anbu. LEAVE_ID, EMP_ID, LEAVE_TYPE,  LEAVE_START_DATE, LEAVE_END_DATE, STATUS, APPROVER_ID
CREATE TABLE LEAVE
(
LEAVE_ID INT,
EMP_ID INT,
LEAVE_TYPE CHAR(2),
LEAVE_APPLIED_DATE DATE,
LEAVE_START_DATE DATE,
LEAVE_END_DATE DATE,
STATUS VARCHAR2(15),
APPROVER_ID INT,
CONSTRAINT FK_LEAVE_EMP_ID FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEES(EMP_ID),
CONSTRAINT FK_LEAVE_APPROVER_ID FOREIGN KEY (APPROVER_ID) REFERENCES EMPLOYEES(EMP_ID),
CONSTRAINT PK_LEAVE_LEAVE_ID PRIMARY KEY(LEAVE_ID),
CONSTRAINT CK_LEAVE_LEAVE_TYPE CHECK(LEAVE_TYPE IN ('AL', 'RH', 'ML', 'PL','MY'))
);

-- TABLE HOLIDAYS - contains holiday details - developed by Anbu. HOLIDAY_ID, HOLIDAY_DATE, HOLIDAY_DESC
CREATE TABLE COMP_HOLIDAYS
(
HOLIDAY_ID INT,
HOLIDAY_DATE DATE,
HOLIDAY_DESC VARCHAR(50),
CONSTRAINT PK_HOLIDAY_HOLIDAY_ID PRIMARY KEY(HOLIDAY_ID)
);

-- TABLE LEAVE_BALANCE - contains leave balance details - developed by Anbu. EMP_ID, LEAVE_TYPE, LEAVE_BALANCE
CREATE TABLE LEAVE_BALANCE
(
EMP_ID INT,
LEAVE_TYPE CHAR(2),
LEAVE_BALANCE INT,
CONSTRAINT FK_LB_EMP_ID FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEES(EMP_ID),
CONSTRAINT PK_LB_EMP_ID_LEAVE_TYPE PRIMARY KEY(EMP_ID, LEAVE_TYPE),
CONSTRAINT CK_LB_LEAVE_BALANCE CHECK(LEAVE_BALANCE >= 0)
);

-- SEQ FOR EMP_ID IN EMPLOYEE TABLE
CREATE SEQUENCE EMP_ID_SEQ
START WITH 5600000
INCREMENT BY 1
CACHE 10
NOCYCLE;

-- REFERENCE VARIABLES in SEQUENCE - CURRVAL, NEXTVAL



-- DATA FOR EMPLOYEE TABLE
INSERT INTO EMPLOYEES VALUES(EMP_ID_SEQ.NEXTVAL, 'Anbu', NULL, 'anbu@hcltech.com', 'M', 9999999999, 10000.00, '01-JAN-2020');
INSERT INTO EMPLOYEES VALUES(EMP_ID_SEQ.NEXTVAL, 'Raj', 5600000, 'raj@hcltech.com', 'M', 8888888888, 20000.00, '01-JAN-2020');
INSERT INTO EMPLOYEES VALUES(EMP_ID_SEQ.NEXTVAL, 'Ravi', 5600000, 'ravi@hcltech.com', 'M', 7777777777, 30000.00, '01-JAN-2020');
COMMIT;

-- DATA FOR LEAVE TABLE
INSERT INTO LEAVE VALUES(1, 5600001, 'AL', SYSDATE-6, '03-JAN-2024', '03-JAN-2024', 'PENDING', NULL);
INSERT INTO LEAVE VALUES(2, 5600002, 'RH', SYSDATE-6, '03-JAN-2024', '03-JAN-2024', 'APPROVED', 5600000);
INSERT INTO LEAVE VALUES(3, 5600002, 'AL', SYSDATE-6, '10-JAN-2024', '12-JAN-2024', 'PENDING', NULL);
COMMIT;

-- DATA FOR HOLIDAYS TABLE
INSERT INTO COMP_HOLIDAYS VALUES(1, '01-JAN-2024', 'New Year');
INSERT INTO COMP_HOLIDAYS VALUES(2, '26-JAN-2024', 'Republic Day');
INSERT INTO COMP_HOLIDAYS VALUES(3, '15-AUG-2024', 'Independence Day');
INSERT INTO COMP_HOLIDAYS VALUES(4, '02-OCT-2024', 'Gandhi Jayanthi');
COMMIT;

-- DATA FOR LEAVE_BALANCE TABLE
INSERT INTO LEAVE_BALANCE VALUES(5600000, 'AL', 10);
INSERT INTO LEAVE_BALANCE VALUES(5600000, 'RH', 5);
INSERT INTO LEAVE_BALANCE VALUES(5600001, 'AL', 9);
INSERT INTO LEAVE_BALANCE VALUES(5600001, 'RH', 5);
INSERT INTO LEAVE_BALANCE VALUES(5600002, 'AL', 7);
INSERT INTO LEAVE_BALANCE VALUES(5600002, 'RH', 4);
COMMIT;

-- LEAVE BALANCE DASHBOARD
-- MY LEAVE REQUESTS, 

-- VIEW FOR PENDING_LEAVES for APPROVAL
CREATE OR REPLACE VIEW PENDING_LEAVES AS
SELECT L.LEAVE_ID, E.EMP_NAME, L.LEAVE_TYPE, L.LEAVE_APPLIED_DATE, L.LEAVE_START_DATE, L.LEAVE_END_DATE, L.STATUS
FROM LEAVE L, EMPLOYEES E
WHERE L.EMP_ID = E.EMP_ID AND L.STATUS = 'PENDING';


--SELECT * FROM PENDING_LEAVES;


-- VIEW FOR ALL EMPLOYEES and its LEAVE details
CREATE OR REPLACE VIEW EMPLOYEE_LEAVE_DETAILS AS
SELECT E.EMP_ID, E.EMP_NAME EMP_NAME, L.LEAVE_TYPE, L.LEAVE_START_DATE, L.LEAVE_END_DATE, L.STATUS, M.EMP_NAME MGR_NAME
FROM LEAVE L
RIGHT JOIN EMPLOYEES E
ON L.EMP_ID = E.EMP_ID
RIGHT JOIN EMPLOYEES M
ON L.APPROVER_ID = M.EMP_ID;

--SELECT * FROM EMPLOYEE_LEAVE_DETAILS;

-- ERD --> All the tables - COLUMNS with constraints (PK, FK, UQ, NN, CHECK). Cardinality - 1:M, M:M, 1:1, M:1


-- USER_INDEXES
-- SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME, COLUMN_POSITION, COLUMN_LENGTH, DESCEND FROM USER_INDEXES WHERE TABLE_NAME = 'EMPLOYEES';

-- INDEX FOR LEAVE_STATUS in LEAVE Table
CREATE INDEX IDX_LEAVE_STATUS ON LEAVE(STATUS);

-- Developed by Anbu
-- Procedure for Auto approval of pending if the leave applied date is 5 days earlier to sysdate
CREATE OR REPLACE PROCEDURE AUTO_APPROVE_LEAVE AS
    -- Nested Table to store the auto approved/rejected status
    TYPE auto_leave_status_type IS TABLE OF LEAVE.STATUS%TYPE;
    auto_leave_status_rec auto_leave_status_type := auto_leave_status_type('AUTO APPROVED','AUTO REJECTED');
    CURSOR PENDING_LEAVES_CUR IS 
        SELECT * FROM PENDING_LEAVES;
    pending_leaves_rec PENDING_LEAVES%ROWTYPE;
BEGIN
    OPEN PENDING_LEAVES_CUR;
    LOOP 
        FETCH PENDING_LEAVES_CUR INTO pending_leaves_rec;
        EXIT WHEN PENDING_LEAVES_CUR%NOTFOUND;
        IF pending_leaves_rec.LEAVE_APPLIED_DATE <= SYSDATE - 5 THEN
            --UPDATE LEAVE SET STATUS = auto_leave_status_rec(1) WHERE LEAVE_ID = --pending_leaves_rec.LEAVE_ID;
            --COMMIT;       
            DBMS_OUTPUT.PUT_LINE('Leave ID: ' || pending_leaves_rec.LEAVE_ID || ' is AUTO APPROVED');
        END IF;
    END LOOP;
	CLOSE PENDING_LEAVES_CUR;
END;
/

--EXEC AUTO_APPROVE_LEAVE;
--SELECT * PENDING_LEAVES;


-- My Leaves stored procedure
-- Developed by Anbu
CREATE OR REPLACE PROCEDURE MY_LEAVES(p_emp_id IN INT) AS
    CURSOR MY_LEAVES_CUR IS 
        SELECT * FROM EMPLOYEE_LEAVE_DETAILS WHERE EMP_ID = p_emp_id;
BEGIN 
    FOR my_leaves_rec IN MY_LEAVES_CUR
    LOOP
        DBMS_OUTPUT.PUT_LINE('Leave Type: ' || my_leaves_rec.LEAVE_TYPE);
        DBMS_OUTPUT.PUT_LINE('Leave Start Date: ' || my_leaves_rec.LEAVE_START_DATE);
        DBMS_OUTPUT.PUT_LINE('Leave End Date: ' || my_leaves_rec.LEAVE_END_DATE);
        DBMS_OUTPUT.PUT_LINE('Status: ' || my_leaves_rec.STATUS);
        DBMS_OUTPUT.PUT_LINE('Approver Name: ' || NULLIF(my_leaves_rec.MGR_NAME, 'System Admin'));
    END LOOP;
END;
/

