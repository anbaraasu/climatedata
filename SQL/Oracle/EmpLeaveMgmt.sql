/*
#######################################################################################
# ORACLE PROJECT NAME: EMPLOYEE LEAVE MGMT SYSTEM
# SQUAD: ELM SQUAD
#
# MEMBERS: ANBU, BABU, CATHERINE
# NORMALIZATION LEVEL: 3NF
# This project will help the employees to raise their leaves as per their leave calender
# Manager can approve/reject/referback their reportee's leaves
#
# TABLE CREATION SCRIPT
#######################################################################################
*/

/*
Employee
	columns			constraints
	***********		************
	id 				pk
	first_name 		not null
	last_name
	age				>=18 <=58
	gender			CHAR(1) - 'M', 'F', 'O'  = 1 * 4 4,00,000 + 6,00,000 = 10,00,000 = 2,00,000
	dept
	doj 			<= today(), DEFAULT SYSDATE
	mgr_id			fk

Holidays
	id				pk SERIALLY AUTO INCREMENT
	name			not null
	holiday_date
	holiday_type	CHAR(1) - CH, RH

Leave
	id 				PK
	emp_id			FK
	leave_type_id	FK
	start_date		DEFAULT SYSDATE
	end_date		DEFAULT SYSDATE
	approver_id 	FK
	status 			pending, approved, rejected, referback
	reason


	//duration = end_date - start_date

LeaveTypes
	id
	leave_type - AL, RH, PL,  ML, CL, MY
	MAX_DAYS 	 62,  4,  10, 300, 62, 2

*/
-- drop tables
DROP TABLE LEAVE;
DROP TABLE LEAVETYPE;
DROP TABLE EMPLOYEE;
DROP TABLE HOLIDAY;

-- DROP sequencees
DROP SEQUENCE EMPLOYEE_ID_SEQ;

-- Developed by Anbu to store employee details
CREATE TABLE EMPLOYEE (
    ID NUMBER,
    FIRST_NAME VARCHAR2(50) NOT NULL,
    LAST_NAME VARCHAR2(50),
    AGE NUMBER ,
    MOBILE_NUMBER VARCHAR2(15) ,
    GENDER CHAR(1),
    DEPT_NAME VARCHAR2(50) NOT NULL,
    DOJ DATE DEFAULT SYSDATE,
    MGR_ID NUMBER,
    CONSTRAINT EMPLOYEE_ID_PK PRIMARY KEY(ID),
    CONSTRAINT EMPLOYEE_MOBILE_UQ UNIQUE(MOBILE_NUMBER),
    CONSTRAINT EMPLOYEE_AGE_CK CHECK (AGE >= 18 AND AGE <= 58),
    CONSTRAINT EMPLOYEE_MOBILE_CK CHECK (LENGTH(MOBILE_NUMBER) = 13),
    CONSTRAINT EMPLOYEE_GENDER_CK CHECK (GENDER IN ('M', 'F', 'O')),
    CONSTRAINT EMPLOYEE_MGR_FK FOREIGN KEY (MGR_ID) REFERENCES EMPLOYEE(ID)
);

CREATE SEQUENCE EMPLOYEE_ID_SEQ
START WITH 5000000
INCREMENT BY 1;


-- Data for employee
INSERT INTO EMPLOYEE (ID, FIRST_NAME, LAST_NAME, AGE, MOBILE_NUMBER, GENDER, DEPT_NAME, DOJ, MGR_ID)
VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 'Anbu', 'Kumar', 30, '+911234567890', 'M', 'IT', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEE (ID, FIRST_NAME, LAST_NAME, AGE, MOBILE_NUMBER, GENDER, DEPT_NAME, DOJ, MGR_ID)
VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 'Babu', 'Raja', 35, '+910987654321', 'M', 'HR', TO_DATE('2022-02-01', 'YYYY-MM-DD'), 5000000);

INSERT INTO EMPLOYEE (ID, FIRST_NAME, LAST_NAME, AGE, MOBILE_NUMBER, GENDER, DEPT_NAME, DOJ, MGR_ID)
VALUES (EMPLOYEE_ID_SEQ.NEXTVAL, 'Catherine', 'Smith', 28, '+911122334455', 'F', 'Finance', TO_DATE('2022-03-01', 'YYYY-MM-DD'), 5000000);

COMMIT;

-- Developed by Anbu to store holidays
CREATE TABLE HOLIDAY (
    ID NUMBER GENERATED ALWAYS as IDENTITY(START with 100000 INCREMENT by 1),
    NAME VARCHAR2(50) NOT NULL,
    HOLIDAY_DATE DATE,
    HOLIDAY_TYPE CHAR(2),
    CONSTRAINT HOLIDAY_ID_PK PRIMARY KEY(ID),
    CONSTRAINT HOLIDAY_NAME_CK CHECK (NAME IS NOT NULL),
    CONSTRAINT HOLIDAY_DATE_CK CHECK (HOLIDAY_DATE IS NOT NULL),
    CONSTRAINT HOLIDAY_TYPE_CK CHECK (HOLIDAY_TYPE IN ('CH', 'RH'))
);


-- Data for holidays
INSERT INTO HOLIDAY (NAME, HOLIDAY_DATE, HOLIDAY_TYPE)
VALUES ('New Year', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'CH'),
('Republic Day', TO_DATE('2025-01-26', 'YYYY-MM-DD'), 'CH'),
('Independence Day', TO_DATE('2025-08-15', 'YYYY-MM-DD'), 'CH'),
('Ramzan',TO_DATE('2025-03-31','YYYY-MM-DD'),'RH');

COMMIT;


-- Developed by Babu to store leave types
CREATE TABLE LEAVETYPE (
    ID NUMBER GENERATED ALWAYS as IDENTITY,
    LEAVE_TYPE VARCHAR2(50) NOT NULL,
    MAX_DAYS NUMBER NOT NULL,
    CONSTRAINT LEAVETYPE_ID_PK PRIMARY KEY (ID),
    CONSTRAINT LEAVETYPE_LEAVE_TYPE_UQ UNIQUE (LEAVE_TYPE)
);

-- Data for leave types
INSERT INTO LEAVETYPE (LEAVE_TYPE, MAX_DAYS) VALUES ('AL', 22);
INSERT INTO LEAVETYPE (LEAVE_TYPE, MAX_DAYS) VALUES ('RH', 4);
INSERT INTO LEAVETYPE (LEAVE_TYPE, MAX_DAYS) VALUES ('PL', 10);
INSERT INTO LEAVETYPE (LEAVE_TYPE, MAX_DAYS) VALUES ('ML', 300);
INSERT INTO LEAVETYPE (LEAVE_TYPE, MAX_DAYS) VALUES ('CL', 12);
INSERT INTO LEAVETYPE (LEAVE_TYPE, MAX_DAYS) VALUES ('MY', 2);

COMMIT;


-- Developed by Catherine to store leave details
CREATE TABLE LEAVE (
    ID NUMBER GENERATED ALWAYS as IDENTITY,
    EMP_ID NUMBER NOT NULL,
    LEAVE_TYPE_ID NUMBER NOT NULL,
    START_DATE DATE DEFAULT SYSDATE,
    END_DATE DATE DEFAULT SYSDATE,
    APPROVER_ID NUMBER,
    STATUS VARCHAR2(20) DEFAULT 'pending',
    REASON VARCHAR2(255),
    CONSTRAINT LEAVE_ID_PK PRIMARY KEY (ID),
    CONSTRAINT LEAVE_EMP_FK FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE (ID),
    CONSTRAINT LEAVE_TYPE_FK FOREIGN KEY (LEAVE_TYPE_ID) REFERENCES LEAVETYPE (ID),
    CONSTRAINT LEAVE_APPROVER_FK FOREIGN KEY (APPROVER_ID) REFERENCES EMPLOYEE (ID)
);

-- Data for leaves
INSERT INTO LEAVE (EMP_ID, LEAVE_TYPE_ID, START_DATE, END_DATE, APPROVER_ID, STATUS, REASON)
VALUES (5000001, 1, TO_DATE('2025-01-15', 'YYYY-MM-DD'), TO_DATE('2025-01-20', 'YYYY-MM-DD'), NULL, 'pending', 'Personal Work');

INSERT INTO LEAVE (EMP_ID, LEAVE_TYPE_ID, START_DATE, END_DATE, APPROVER_ID, STATUS, REASON)
VALUES (5000002, 1, TO_DATE('2024-02-20', 'YYYY-MM-DD'), TO_DATE('2024-02-22', 'YYYY-MM-DD'), 5000000, 'approved', 'Religious Holiday');

INSERT INTO LEAVE (EMP_ID, LEAVE_TYPE_ID, START_DATE, END_DATE, APPROVER_ID, STATUS, REASON)
VALUES (5000001, 1, TO_DATE('2025-02-15', 'YYYY-MM-DD'), TO_DATE('2025-02-17', 'YYYY-MM-DD'), NULL, 'pending', 'Personal Work');

INSERT INTO LEAVE (EMP_ID, LEAVE_TYPE_ID, START_DATE, END_DATE, APPROVER_ID, STATUS, REASON)
VALUES (5000001, 1, TO_DATE('2024-02-20', 'YYYY-MM-DD'), TO_DATE('2024-02-20', 'YYYY-MM-DD'), 5000000, 'approved', 'Religious Holiday');

COMMIT;

-- 2024: 22 - 1 = 21, carry forward only 45 days 
-- 2025: 45 - 3 = 59


-- View to show the max leaves , applied leaves, available leaves for each employee.

CREATE OR REPLACE VIEW employee_leave_summary AS
SELECT
    e.id,
    e.employee_name,
    e.dept_name,
    LEAVE_TYPE,
    e.max_days,
    COALESCE(SUM(CASE WHEN l.EMP_ID IS NOT NULL THEN l.END_DATE - l.START_DATE + 1 ELSE 0 END), 0) AS applied_leaves,
    max_days - COALESCE(SUM(CASE WHEN l.EMP_ID IS NOT NULL THEN l.END_DATE - l.START_DATE + 1 ELSE 0 END), 0) AS available_leaves
FROM
    (SELECT e.id, e.FIRST_NAME || ' ' || e.LAST_NAME AS employee_name, lt.ID AS LEAVE_TYPE_ID, lt.LEAVE_TYPE, max_days
     FROM employee e
     CROSS JOIN (SELECT * FROM LEAVETYPE lt WHERE id in (1,2, 6 ) ) lt) e
LEFT JOIN (select * from leave where status = 'approved') l ON e.LEAVE_TYPE_ID = l.LEAVE_TYPE_ID AND e.id = l.EMP_ID
GROUP BY
    e.id, e.employee_name, e.LEAVE_TYPE, e.max_days
ORDER BY e.id;

--Example query to use the view
SELECT * FROM employee_leave_summary;
--select * from MY_LEAVE_REQUEST;

-- view to show emp name, dept name, mgr name using self join
CREATE OR REPLACE VIEW emp_details AS
SELECT
    e1.id AS emp_id,
    e1.FIRST_NAME || ' ' || e1.LAST_NAME AS employee_name,
    e1.DEPT_NAME,
    e2.FIRST_NAME || ' ' || e2.LAST_NAME AS manager_name
FROM
    EMPLOYEE e1
LEFT JOIN EMPLOYEE e2 ON e1.MGR_ID = e2.ID
ORDER BY e1.id;


CREATE OR REPLACE VIEW my_leave_request AS
SELECT
    e.first_name || ' ' || e.last_name AS employee_name,
    lt.leave_type,
    l.start_date,
    l.end_date,
	COALESCE((l.END_DATE - l.START_DATE + 1), 0) AS applied_leaves,
    l.reason,
    l.status
FROM
    employee e
JOIN
    leave l ON e.id = l.emp_id
JOIN
    leavetype lt ON l.leave_type_id = lt.id;

select * from MY_LEAVE_REQUEST;

CREATE OR REPLACE PACKAGE LMS_PKG AS 
    PROCEDURE auto_action_leave ;
    PROCEDURE print_employee_leave_summary;
    FUNCTION calculate_annual_leaves(emp_id IN NUMBER) RETURN NUMBER;
END LMS_PKG;
/

-- auto action on leaves - if leave is not approved in 3 days, auto approve it if the number of day less than 3 day else auto reject and update the reason accordingly
CREATE OR REPLACE PACKAGE BODY LMS_PKG AS 
    PROCEDURE auto_action_leave IS
        CURSOR leave_cursor IS
            SELECT l.id, l.emp_id, l.leave_type_id, l.start_date, l.end_date, l.status
            FROM leave l
            WHERE l.status = 'pending' AND (SYSDATE - l.start_date) > 3;
    BEGIN
        FOR leave_record IN leave_cursor LOOP
            IF (leave_record.end_date - leave_record.start_date) < 3 THEN
                UPDATE leave
                SET status = 'approved',
                REASON  = 'Auto approved by the system'
                WHERE id = leave_record.id;
            ELSE
                UPDATE leave
                SET status = 'rejected', 
                reason = 'Auto rejected by the system'
                WHERE id = leave_record.id;
            END IF;
        END LOOP;
        COMMIT;
    END auto_action_leave;


    -- procedure to print the SELECT * FROM employee_leave_summary details with mytechTEH company header 
    -- and surrounded by table like format by printing the dashes and lines
    -- and also to print the date and time of the report generation
    -- and the name of the department, person, manager only once at the top of the report
    CREATE OR REPLACE PROCEDURE print_employee_leave_summary IS
        CURSOR emp_cursor IS SELECT * FROM emp_details order by emp_id;
        CURSOR emp_Leave_cursor(c_emp_id INT) IS SELECT * FROM employee_leave_summary  where id = c_emp_id order by employee_name;
        v_emp_name VARCHAR2(100);
        v_dept_name VARCHAR2(50);
        v_mgr_name VARCHAR2(100);
        v_report_date VARCHAR2(50);
        v_report_time VARCHAR2(50);
    BEGIN
        v_report_date := TO_CHAR(SYSDATE, 'DD-MON-YYYY');
        v_report_time := TO_CHAR(SYSDATE, 'HH24:MI:SS');
        DBMS_OUTPUT.PUT_LINE('mytech Employee Leave Summary Report');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Generated on: ' || v_report_date || ' at ' || v_report_time);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
        FOR emp_record IN emp_cursor LOOP    
            DBMS_OUTPUT.PUT_LINE('Department: ' || emp_record.dept_name);
            DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_record.employee_name);
            DBMS_OUTPUT.PUT_LINE('Manager Name: ' || emp_record.manager_name);
            DBMS_OUTPUT.PUT_LINE(CHR(13) || '--------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE(CHR(13) || 'Leave Type | Max Days | Applied Leaves | Available Leaves');
            DBMS_OUTPUT.PUT_LINE(CHR(13) || '--------------------------------------------------');

            FOR leave_record IN emp_Leave_cursor(emp_record.emp_id) LOOP
                DBMS_OUTPUT.PUT_LINE(CHR(13)  || leave_record.leave_type || '         | ' ||
                                    leave_record.max_days || '       | ' ||
                                    leave_record.applied_leaves || '          | ' ||
                                    leave_record.available_leaves);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE(CHR(13) || '--------------------------------------------------');
        END LOOP;
    END print_employee_leave_summary;

    -- function to calculate the number of annual leaves taken by an employee on previous year, if more leave only 45 days can be carried forward to the next year
    -- 2024: 22 - 1 = 21, carry forward only 45 days 
    -- 2025: 21 + 22 - 3 = 40
    CREATE OR REPLACE FUNCTION calculate_annual_leaves(emp_id IN NUMBER) RETURN NUMBER IS
        -- CURSOR TO FIND max_days AS TOTAL LEAVES AND APPROVED LEAVES
        L_LAST_YEAR INT := EXTRACT(YEAR FROM SYSDATE) - 1;     
        l_CURR_YEAR INT := EXTRACT(YEAR FROM SYSDATE);
        L_CF_DAYS INT := 45;
        L_YEAR_AVAIL_LEAVES INT := 0;
    BEGIN
        -- GET THE AVAILABLE LEAVES W.R.T AL TYPE AND L_LAST_YEAR 
        SELECT max_days - COALESCE(SUM(CASE WHEN l.EMP_ID IS NOT NULL THEN l.END_DATE - l.START_DATE + 1 ELSE 0 END), 0) INTO L_YEAR_AVAIL_LEAVES
    FROM
        (SELECT e.id, e.FIRST_NAME || ' ' || e.LAST_NAME AS employee_name, lt.ID AS LEAVE_TYPE_ID, lt.LEAVE_TYPE, max_days
        FROM employee e
        CROSS JOIN (SELECT * FROM LEAVETYPE lt WHERE id in (1 ) ) lt) e
    LEFT JOIN (select * from leave where UPPER(status) = 'APPROVED') l ON e.LEAVE_TYPE_ID = l.LEAVE_TYPE_ID AND e.id = l.EMP_ID AND EXTRACT(YEAR FROM l.start_date) = L_LAST_YEAR
    WHERE e.id = emp_id 
    GROUP BY e.max_days;

        IF L_YEAR_AVAIL_LEAVES < L_CF_DAYS THEN
            L_CF_DAYS := L_YEAR_AVAIL_LEAVES;
        END IF;
        SELECT max_days - COALESCE(SUM(CASE WHEN l.EMP_ID IS NOT NULL THEN l.END_DATE - l.START_DATE + 1 ELSE 0 END), 0) INTO L_YEAR_AVAIL_LEAVES
    FROM
        (SELECT e.id, e.FIRST_NAME || ' ' || e.LAST_NAME AS employee_name, lt.ID AS LEAVE_TYPE_ID, lt.LEAVE_TYPE, max_days
        FROM employee e
        CROSS JOIN (SELECT * FROM LEAVETYPE lt WHERE id in (1 ) ) lt) e
    LEFT JOIN (select * from leave where UPPER(status) = 'APPROVED') l ON e.LEAVE_TYPE_ID = l.LEAVE_TYPE_ID AND e.id = l.EMP_ID AND EXTRACT(YEAR FROM l.start_date) = L_CURR_YEAR
    GROUP BY e.max_days;

        RETURN L_CF_DAYS + L_YEAR_AVAIL_LEAVES;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
            RETURN NULL;
    END calculate_annual_leaves;
END LMS_PKG;
/

SELECT employee_name, 
         dept_name, 
         LEAVE_TYPE, 
         calculate_annual_leaves(id) AS annual_leaves,
         applied_leaves, 
         available_leaves
 FROM employee_leave_summary;
    
