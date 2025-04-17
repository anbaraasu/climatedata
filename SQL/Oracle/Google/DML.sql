DROP TABLE HR_EMP;
 
-- What are the copied from select table to create table
-- All columns and data are copied.
-- PK, UK, NN, DEFAULT, FK, CK - NN will be copied.
CREATE TABLE HR_EMP
    AS
        SELECT
            *
        FROM
            HR.EMPLOYEES;
 
ALTER TABLE HR_EMP ADD CONSTRAINT HR_EMP_ID_PK PRIMARY KEY ( EMPLOYEE_ID );
 
SELECT
    FIRST_NAME
FROM
    HR.EMPLOYEES;
 
SELECT
    *
FROM
    HR_EMP;
 
-- 1 01
 
SELECT
    COUNT(DEPARTMENT_ID)
FROM
    HR_EMP;
 
--
DESC HR.EMPLOYEES;
 
-- INSERT
-- single row
-- selected columns
INSERT INTO HR_EMP (
    EMAIL,
    JOB_ID,
    HIRE_DATE,
    LAST_NAME,
    EMPLOYEE_ID
) VALUES ( 'A@a.com',
           'VP',
           SYSDATE,
           'A',
           1 );
 
-- multi rows
INSERT INTO HR_EMP (
    EMAIL,
    JOB_ID,
    HIRE_DATE,
    LAST_NAME,
    EMPLOYEE_ID
) VALUES ( 'A@a.com',
           'VP',
           SYSDATE,
           'A',
           2 ), ( 'A@a.com',
                  'VP',
                  SYSDATE,
                  'A',
                  3 ), ( 'A@a.com',
                         'VP',
                         SYSDATE,
                         'A',
                         4 );
 
TRUNCATE TABLE HR_EMP;
 
-- multi rows
INSERT INTO HR_EMP
    SELECT
        *
    FROM
        HR.EMPLOYEES;
 
CREATE TABLE GOOGLE_SEARCH (
    ID          INT,
    SEARCH_TEXT VARCHAR2(100),
    CONSTRAINT GOOGLE_SEARCH_ID_PK PRIMARY KEY ( ID ),
    CONSTRAINT GOOGLE_SEARCH_TEXT_UQ UNIQUE ( SEARCH_TEXT )
);
 
INSERT INTO GOOGLE_SEARCH
    SELECT
        EMPLOYEE_ID,
        FIRST_NAME
        || ' '
        || LAST_NAME
    FROM
        HR.EMPLOYEES;
 
-- UPDATE statements & DELETE
-- WHERE condn.
-- SELECT beore update/delete
 
 
 
SELECT
    *
FROM
    HR_EMP
WHERE
    EMPLOYEE_ID = 3;
 
UPDATE HR_EMP
SET
    FIRST_NAME = 'B'
WHERE
    EMPLOYEE_ID = 3;
 
-- increment the salary with rs. 100 for the employee who are getting less than 5000 as salary
SELECT
    *
FROM
    HR_EMP
WHERE
    SALARY < 5000;
 
UPDATE HR_EMP
SET
    SALARY = SALARY + 100
WHERE
    SALARY < 5000;
 
-- sql OPERATORS
-- ARTHMETICS - +, - , * , /
-- RELATIONAL OPERATOR >, <, >= ,  <=, != OR <>
-- LOGICAL OPERATORS - AND OR NOT
-- || - CONCAT OPERATOR
-- IN, IS NULL, EXISTS,
 
-- SQL FUNCTIONS
--- NUMBERS - CEIL, FLOOR, ROUND, TRUNC (5.3809830984309843), MOD
--- TEXT - INSTR, SUBSTR, TO_CHAR,
--- DATE -- TO_DATE, EXTRACT
--- NULL - IFNULL NVL, COLESCE,
--- PATTERN _, %
 
 
SELECT
    SALARY/1000 "Salary IN K",
    CEIL(SALARY / 1000) * 1000  AS CEIL_SALARY,
    FLOOR(SALARY / 1000) * 1000 AS FLOOR_SALARY,
    ROUND(SALARY / 1000) * 1000 AS ROUNDED_SALARY,
    TRUNC(SALARY / 1000) * 1000 AS TRUNC_SALARY
FROM
    HR.EMPLOYEES;
 
 
-- POLYMORPHISM - MANY FORMS
 
SELECT FLOOR(4.9999), TRUNC(4.999999, 2) FROM DUAL;
 
 
-- 12. Single Row Functions - SUBSTR - Polymorphism
SELECT first_name, SUBSTR(first_name, 1, 3) FROM hr.employees;
SELECT first_name, SUBSTR(first_name, 3) FROM hr.employees;
 
-- 13. Single Row Functions - INSTR - Polymorphism
-- find the first occurrence of e
SELECT INSTR('mytech Technologies','e') FROM DUAL;
-- find the occurrence of e starting from 7 position
SELECT INSTR('mytech Technologies','e',7) FROM DUAL;
-- find the second occurence from 1st position onwards
SELECT INSTR('mytech Technologies','e',1,2) FROM DUAL;
-- find the last occurence
SELECT INSTR('mytech Technologies','e',-1) FROM DUAL;
 
SELECT TO_CHAR(123456,'9,999,999.00') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'MONTH'), SYSDATE FROM DUAL;
 
SELECT EXTRACT(MONTH FROM SYSDATE), SYSDATE FROM DUAL;
 