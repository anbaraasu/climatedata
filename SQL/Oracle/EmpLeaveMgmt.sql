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

DROP TABLE LEAVE_DETAILS;
DROP TABLE EMPLOYEE_DETAILS;
DROP TABLE HOLIDAY;
DROP SEQUENCE EMP_ID_SEQ ;
DROP SEQUENCE LEAVE_ID_SEQ;
DROP SEQUENCE HOLIDAY_ID_SEQ;
/*EMPLOYEE_DETAILS with constraints
	ID (PK), ENAME (NN), MGR_ID (FK - REF ID), GENDER(NN, CK), AGE (CK > 18), MOBILE (INT/VARCHAR - CK ()) , EMAILID (CK ), SALARY (CK > 0, NN)
	1   A      NULL,  
	2,  B,     1
*/
-- Developed by Anbu to store emp details.
CREATE TABLE EMPLOYEE_DETAILS (
    ID NUMBER ,
    ENAME VARCHAR2(100) NOT NULL,
    MGR_ID NUMBER,
    GENDER CHAR(1),
    AGE INT,
    MOBILE VARCHAR2(10),
    SALARY NUMBER(10,2),
    CONSTRAINT EMP_ID_PK PRIMARY KEY (ID),
    CONSTRAINT EMP_MGR_FK FOREIGN KEY (MGR_ID) REFERENCES EMPLOYEE_DETAILS(ID),
    CONSTRAINT EMP_GENDER_CK CHECK (GENDER IN ('M','F','O')),
    CONSTRAINT EMP_AGE_CK CHECK (AGE > 18 AND AGE < 58),
    CONSTRAINT EMP_MOBILE_CK CHECK (LENGTH(MOBILE) = 10),
    CONSTRAINT EMP_SALARY_CK CHECK (SALARY > 0)
);



/*LEAVE_DETAILS
	ID, EMP_ID, START_DATE, END_DATE, TYPE, REASON, 			STATUS,  APPROVED_ID
*/

-- Developed by Anbu to store leave details.
CREATE TABLE LEAVE_DETAILS(
    ID NUMBER,
    EMP_ID NUMBER,
    START_DATE DATE,
    END_DATE DATE,
    TYPE CHAR(2),
    REASON VARCHAR2(100),
    STATUS INT,
    APPROVED_ID NUMBER,
    CONSTRAINT LEAVE_ID_PK PRIMARY KEY (ID),
    CONSTRAINT LEAVE_EMP_FK FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE_DETAILS(ID),
    CONSTRAINT LEAVE_APPROVED_FK FOREIGN KEY (APPROVED_ID) REFERENCES EMPLOYEE_DETAILS(ID),
    CONSTRAINT LEAVE_END_DATE_CK CHECK (END_DATE >= START_DATE)
);

-- SELECT * FROM LEAVE_DETAILS;

-- HOLIDAY - ID, Date, Comments
CREATE TABLE HOLIDAY(
    ID NUMBER,
    HOLIDAY_DATE DATE,
    COMMENTS VARCHAR2(100),
    CONSTRAINT HOLIDAY_ID_PK PRIMARY KEY (ID)
);

CREATE SEQUENCE EMP_ID_SEQ START WITH 57000000;
CREATE SEQUENCE LEAVE_ID_SEQ START WITH 100000;
CREATE SEQUENCE HOLIDAY_ID_SEQ;

-- INDEX 
CREATE INDEX LEAVE_DETAILS_STATUS_IDX ON LEAVE_DETAILS(STATUS);
CREATE INDEX LEAVE_DETAILS_EMP_IDX ON LEAVE_DETAILS(EMP_ID);

-- Data for Emp table
INSERT INTO EMPLOYEE_DETAILS (ID, ENAME, MGR_ID, GENDER, AGE, SALARY, MOBILE) 
VALUES (EMP_ID_SEQ.NEXTVAL, 'A', NULL, 'M', 31, 10000, '9876543210');
INSERT INTO EMPLOYEE_DETAILS (ID, ENAME, MGR_ID, GENDER, AGE, SALARY, MOBILE) 
VALUES(EMP_ID_SEQ.NEXTVAL, 'B', 57000000, 'F', 26, 10000, '9876543210');
INSERT INTO EMPLOYEE_DETAILS (ID, ENAME, MGR_ID, GENDER, AGE, SALARY, MOBILE) 
VALUES(EMP_ID_SEQ.NEXTVAL, 'C', 57000000, 'M', 21, 10000, '9876543210');
INSERT INTO EMPLOYEE_DETAILS (ID, ENAME, MGR_ID, GENDER, AGE, SALARY, MOBILE) 
VALUES(EMP_ID_SEQ.NEXTVAL, 'D', 57000001, 'F', 21, 10000, '9876543210');
COMMIT; 

-- Data for Leave Table 
INSERT INTO LEAVE_DETAILS (ID, EMP_ID, START_DATE, END_DATE, TYPE, REASON, STATUS, APPROVED_ID)
VALUES (LEAVE_ID_SEQ.NEXTVAL, 57000001, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-02', 'YYYY-MM-DD'), 'PL', 'Sick Leave', 2, 57000000);
INSERT INTO LEAVE_DETAILS (ID, EMP_ID, START_DATE, END_DATE, TYPE, REASON, STATUS, APPROVED_ID)
VALUES (LEAVE_ID_SEQ.NEXTVAL, 57000003, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-01-02', 'YYYY-MM-DD'), 'PL', 'Sick Leave', 1, NULL);
COMMIT;


-- Data for holiday table
INSERT INTO HOLIDAY VALUES(HOLIDAY_ID_SEQ.NEXTVAL, TO_DATE('2025-02-17', 'YYYY-MM-DD'), 'Study Holiday');

-- SELECT * FROM HOLIDAY;

-- View to get the leave details of all employees
-- View without index: 0.01 seconds
-- View with index: 0.001 seconds
CREATE OR REPLACE VIEW EMP_LEAVE_VIEW AS
SELECT 
    E.ID AS EMP_ID,
    E.ENAME AS EMP_NAME,
    L.START_DATE,
    L.END_DATE,
    calculate_leave_days(L.END_DATE , L.START_DATE )  NO_OF_LEAVES_DAYS,
    L.TYPE,
    L.REASON,
    CASE WHEN L.STATUS = 1 THEN 'PENDING' 
        WHEN L.STATUS = 2 THEN 'APPROVED' 
        WHEN L.STATUS = 3 THEN 'REJECTED' 
        ELSE 'Not Applied' 
    END AS STATUS,
    M.ENAME AS MGR_NAME
FROM
    EMPLOYEE_DETAILS E
LEFT JOIN
    LEAVE_DETAILS L ON E.ID = L.EMP_ID
LEFT JOIN
    EMPLOYEE_DETAILS M ON L.APPROVED_ID = M.ID
ORDER BY EMP_ID;

-- SELECT * FROM EMP_LEAVE_VIEW;


-- FUNCTION To find number of days leave applied
CREATE OR REPLACE FUNCTION calculate_leave_days(p_end_date IN DATE, p_start_date IN DATE) RETURN NUMBER IS
BEGIN 
    RETURN (p_end_date - p_start_date) + 1;
END calculate_leave_days;
/


--  PROCEDURE AUTO ACTION: 
-- Approve IF no of leave days is less than or equal  3 days and  leave start date is less than 5 days from current date. 
-- Reject IF no of leave days is greater than 3 days and  leave start date is less than 5 days from current date. 
CREATE OR REPLACE PROCEDURE AUTO_ACTION_LEAVE AS
    CURSOR LEAVE_CUR IS SELECT * FROM LEAVE_DETAILS WHERE STATUS = 1 AND START_DATE <= SYSDATE + 5;
BEGIN 
    FOR leave_rec IN LEAVE_CUR LOOP
        IF (calculate_leave_days(leave_rec.END_DATE, leave_rec.START_DATE) <= 3) THEN
            UPDATE LEAVE_DETAILS SET STATUS = 2, APPROVED_ID = 57000000 WHERE ID = leave_rec.ID;
            COMMIT;
        ELSE
            UPDATE LEAVE_DETAILS SET STATUS = 3, APPROVED_ID = 57000000 WHERE ID = leave_rec.ID;
            COMMIT;
        END IF;
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('No action to be taken all the leaves are approved and within SLA' );
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
    ROLLBACK;
END AUTO_ACTION_LEAVE;
/

--SELECT * FROM LEAVE_DETAILS WHERE STATUS = 1 AND START_DATE <= SYSDATE + 5;
--EXEC AUTO_ACTION_LEAVE;
--SELECT * FROM LEAVE_DETAILS WHERE STATUS = 1 AND START_DATE <= SYSDATE + 5;




CREATE OR REPLACE PACKAGE EMP_LEAVE_PKG AS
    FUNCTION calculate_leave_days(p_end_date IN DATE, p_start_date IN DATE) RETURN NUMBER;
    PROCEDURE AUTO_ACTION_LEAVE;
    PROCEDURE APPLY_LEAVE(p_emp_id INT, p_start_date DATE, p_end_date DATE, p_reason VARCHAR2);
END EMP_LEAVE_PKG;
/

CREATE OR REPLACE PACKAGE BODY EMP_LEAVE_PKG AS 
    FUNCTION calculate_leave_days(p_end_date IN DATE, p_start_date IN DATE) RETURN NUMBER IS
    BEGIN 
        RETURN (p_end_date - p_start_date) + 1;
    END calculate_leave_days;
    
    
    --  PROCEDURE AUTO ACTION: 
    -- Approve IF no of leave days is less than or equal  3 days and  leave start date is less than 5 days from current date. 
    -- Reject IF no of leave days is greater than 3 days and  leave start date is less than 5 days from current date. 
    PROCEDURE AUTO_ACTION_LEAVE AS
        CURSOR LEAVE_CUR IS SELECT * FROM LEAVE_DETAILS WHERE STATUS = 1 AND START_DATE <= SYSDATE + 5;
    BEGIN 
        FOR leave_rec IN LEAVE_CUR LOOP
            IF (calculate_leave_days(leave_rec.END_DATE, leave_rec.START_DATE) <= 3) THEN
                UPDATE LEAVE_DETAILS SET STATUS = 2, APPROVED_ID = 57000000 WHERE ID = leave_rec.ID;
                COMMIT;
            ELSE
                UPDATE LEAVE_DETAILS SET STATUS = 3, APPROVED_ID = 57000000 WHERE ID = leave_rec.ID;
                COMMIT;
            END IF;
        END LOOP;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            INSERT INTO ERROR_LOG VALUES(ERROR_LOG_SEQ.NEXTVAL, 'No action to be taken all the leaves are approved and within SLA', SYSDATE, 'AUTO_ACTION_LEAVE');
            DBMS_OUTPUT.PUT_LINE('No action to be taken all the leaves are approved and within SLA' );
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        ROLLBACK;
    END AUTO_ACTION_LEAVE;
    
    PROCEDURE APPLY_LEAVE(p_emp_id INT, p_start_date DATE, p_end_date DATE, p_reason VARCHAR2) AS
    BEGIN
        INSERT INTO LEAVE_DETAILS (ID, EMP_ID, START_DATE, END_DATE, TYPE, REASON, STATUS, APPROVED_ID)
        VALUES (LEAVE_ID_SEQ.NEXTVAL, p_emp_id, p_start_date, p_end_date, 'AL', p_reason, 1, NULL);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            INSERT INTO ERROR_LOG VALUES(ERROR_LOG_SEQ.NEXTVAL, SQLERRM, SYSDATE, 'APPLY_LEAVE');
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
            ROLLBACK;
    END APPLY_LEAVE;
END EMP_LEAVE_PKG;
/

-- trigger to check before insert whether start date and end date are in holiday list
CREATE OR REPLACE TRIGGER leave_holiday_check_trg 
BEFORE INSERT ON LEAVE_DETAILS
FOR EACH ROW
DECLARE
    l_holiday_count INT := 0;
BEGIN 
    SELECT COUNT(*) INTO l_holiday_count 
    FROM HOLIDAY 
    WHERE TRUNC(HOLIDAY_DATE) BETWEEN TRUNC(:NEW.START_DATE) AND TRUNC(:NEW.END_DATE);
    
    IF (l_holiday_count > 0) THEN
        INSERT INTO ERROR_LOG VALUES(ERROR_LOG_SEQ.NEXTVAL, 'Leave dates are in holiday list', SYSDATE, 'leave_holiday_check_trg');
        RAISE_APPLICATION_ERROR(-20001, 'Leave dates are in holiday list');
    END IF;
END leave_holiday_check_trg;
/

-- all apply leave proc
EXEC EMP_LEAVE_PKG.APPLY_LEAVE(57000000,SYSDATE, SYSDATE, 'Sick');

-- insert leave for 57000000 for today'date 
--INSERT INTO LEAVE_DETAILS (ID, EMP_ID, START_DATE, END_DATE, TYPE, REASON, STATUS, APPROVED_ID)
--VALUES (LEAVE_ID_SEQ.NEXTVAL, 57000000, SYSDATE, SYSDATE, 'AL', 'Sick Leave', 1, NULL);



DECLARE 
    l_menu_options INT := &menu_options;
BEGIN
    DBMS_OUTPUT.PUT_LINE('##############################################################');
    DBMS_OUTPUT.PUT_LINE(CHR(9) || CHR(9) || 'WECOME TO EMP LEAVE PORTAL');
    DBMS_OUTPUT.PUT_LINE('##############################################################');
    DBMS_OUTPUT.PUT_LINE(CHR(9) || CHR(9) || '*****GET WELL SOON********');
    DBMS_OUTPUT.PUT_LINE('##############################################################');
    CASE 
        WHEN l_menu_options = 1 THEN
            DBMS_OUTPUT.PUT_LINE('You have selected menu option: List all the applied leaves');
            DBMS_OUTPUT.PUT_LINE('##############################################################');
            DBMS_OUTPUT.PUT_LINE('Emp Name' || CHR(9) || 'Status' || CHR(9)|| CHR(9) || 'MGR Name');
            FOR leave_view IN (SELECT * FROM EMP_LEAVE_VIEW WHERE STATUS IS NOT NULL) LOOP
                DBMS_OUTPUT.PUT_LINE(leave_view.EMP_NAME || CHR(9) || CHR(9) || leave_view.STATUS || CHR(9) || leave_view.MGR_NAME);
            END LOOP;
        WHEN l_menu_options = 2 THEN
            DBMS_OUTPUT.PUT_LINE('You have selected menu option: List all the emp and leaves details');
            DBMS_OUTPUT.PUT_LINE('##############################################################');
            DBMS_OUTPUT.PUT_LINE('Emp Name' || CHR(9) || 'Status' || CHR(9) || CHR(9)|| 'MGR Name');
            FOR leave_view IN (SELECT * FROM EMP_LEAVE_VIEW ) LOOP
                DBMS_OUTPUT.PUT_LINE(leave_view.EMP_NAME || CHR(9) || CHR(9) || leave_view.STATUS || CHR(9) || leave_view.MGR_NAME);
            END LOOP;
        WHEN l_menu_options = 3 THEN
            DBMS_OUTPUT.PUT_LINE('You have selected menu option: Apply Leave');
            DBMS_OUTPUT.PUT_LINE('##############################################################');
            EMP_LEAVE_PKG.APPLY_LEAVE(57000000,SYSDATE, SYSDATE, 'Sick');
    END CASE;
    DBMS_OUTPUT.PUT_LINE('##############################################################');
END;


-- Seq for error log pk
DROP SEQUENCE ERROR_LOG_SEQ;
CREATE SEQUENCE ERROR_LOG_SEQ;
-- ERROR LOG table
DROP TABLE ERROR_LOG;
CREATE TABLE ERROR_LOG(
    ID NUMBER PRIMARY KEY,
    ERROR_MESSAGE VARCHAR2(4000),
    ERROR_DATE DATE,
    PRG_NAME VARCHAR2(50)
);

