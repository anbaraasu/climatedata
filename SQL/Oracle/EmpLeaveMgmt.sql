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
	leave_type - SL, RH, PL,  ML, CL, MY
	MAX_DAYS 	 62,  4,  10, 300, 62, 2

*/
-- drop tables
DROP TABLE LEAVE;
DROP TABLE LEAVETYPE;
DROP TABLE EMPLOYEE;
DROP TABLE HOLIDAY;

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
VALUES (1, 'Anbu', 'Kumar', 30, '+911234567890', 'M', 'IT', TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL);

INSERT INTO EMPLOYEE (ID, FIRST_NAME, LAST_NAME, AGE, MOBILE_NUMBER, GENDER, DEPT_NAME, DOJ, MGR_ID)
VALUES (2, 'Babu', 'Raja', 35, '+910987654321', 'M', 'HR', TO_DATE('2022-02-01', 'YYYY-MM-DD'), 1);

INSERT INTO EMPLOYEE (ID, FIRST_NAME, LAST_NAME, AGE, MOBILE_NUMBER, GENDER, DEPT_NAME, DOJ, MGR_ID)
VALUES (3, 'Catherine', 'Smith', 28, '+911122334455', 'F', 'Finance', TO_DATE('2022-03-01', 'YYYY-MM-DD'), 1);

COMMIT;

-- Developed by Anbu to store holidays
CREATE TABLE HOLIDAY (
    ID NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
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
INSERT INTO LEAVETYPE (LEAVE_TYPE, MAX_DAYS) VALUES ('SL', 62);
INSERT INTO LEAVETYPE (LEAVE_TYPE, MAX_DAYS) VALUES ('RH', 4);
INSERT INTO LEAVETYPE (LEAVE_TYPE, MAX_DAYS) VALUES ('PL', 10);
INSERT INTO LEAVETYPE (LEAVE_TYPE, MAX_DAYS) VALUES ('ML', 300);
INSERT INTO LEAVETYPE (LEAVE_TYPE, MAX_DAYS) VALUES ('CL', 62);
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
VALUES (2, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-01-20', 'YYYY-MM-DD'), NULL, 'pending', 'Personal Work');

INSERT INTO LEAVE (EMP_ID, LEAVE_TYPE_ID, START_DATE, END_DATE, APPROVER_ID, STATUS, REASON)
VALUES (3, 2, TO_DATE('2024-02-20', 'YYYY-MM-DD'), TO_DATE('2024-02-22', 'YYYY-MM-DD'), 1, 'approved', 'Religious Holiday');

COMMIT;



-- View to show the max leaves , applied leaves, available leaves for each employee.

CREATE OR REPLACE VIEW employee_leave_summary AS
SELECT
    e.id,
    e.employee_name,
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


