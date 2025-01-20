/***************************************************************************************
                        EMPLOYEE LEAVE MANAGEMENT
****************************************************************************************
    Squad: eLeave
    Member(s): Anbu
    NF LEVEL: BCNF
    Version: 1.0    (MAJOR Rel version . Minor Rel Version . Build Number . )
****************************************************************************************/
 
DROP TABLE EMPLOYEE
 
--Sequence
CREATE SEQUENCE EMP_SEQ 
START WITH 100 ;

-- Employe details developed by anbu
CREATE TABLE EMPLOYEE(
    id NUMBER,
    name VARCHAR2(50) NOT NULL,
    age NUMBER NOT NULL,
    gender CHAR(1) NOT NULL ,
    phone VARCHAR2(15) NOT NULL,
    email VARCHAR2(50) UNIQUE CHECK (REGEXP_LIKE(EMAIL, '^[A-Za-z._%+-]+@[A-Za-z.-]+\.[A-Z|a-z]{2,}$')),
    dept VARCHAR2(50) NOT NULL,
    mgrid NUMBER DEFAULT NULL
);
 
-- Constraints on Employee details
ALTER TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE_PK PRIMARY KEY(ID);
ALTER TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE_UQ_PHONE UNIQUE(PHONE);
ALTER TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE_CK_GENDER CHECK (GENDER in ('M','F','O'));
 
-- Employee data
INSERT INTO EMPLOYEE (NAME,ID,AGE,GENDER,PHONE,EMAIL,DEPT) VALUES('Anbu', EMP_SEQ.NEXTVAL , 25, 'M', '1234567890', 'anbu@lms.com', 'COE');
INSERT INTO EMPLOYEE VALUES(EMP_SEQ.NEXTVAL, 'Raj', 30, 'M', '1234567891', 'raj@lms.com', 'COE', 100);
INSERT INTO EMPLOYEE VALUES(EMP_SEQ.NEXTVAL, 'David Josheph Xavier Beckham 12345678901234567890123456', 30, 'M', '1234567892', 'db@lms.com', 'COE', 100);
COMMIT;
 
 
 
 