-- PLSQL Exception Handling - Exception is an error handling mechanism in PLSQL, it is used to handle the runtime errors that occur during the execution of a PLSQL program. 

-- types of exceptions: 
--     -- Predefined Exceptions
--     -- User-defined Exceptions

-- Predefined Exceptions:
--     -- NO_DATA_FOUND - error code: 100
--     -- TOO_MANY_ROWS - error code: 1422
--     -- INVALID_CURSOR - error code: 1001
--     -- ZERO_DIVIDE - error code: 1476
--     -- DUP_VAL_ON_INDEX - error code: 1
--     -- LOGIN_DENIED - error code: 1017

-- Demo on Predefined Exceptions

CREATE OR REPLACE PROCEDURE GET_EMP_SAL (p_dept_id INT) AS
    emp_sal NUMBER;
BEGIN
    SELECT salary INTO emp_sal FROM emp WHERE department_id = p_dept_id;
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_sal);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found for Dept ID:' || p_dept_id);
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than one employee found');    
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error Occured:' || SQLCODE || ' msg:' || SQLERRM);
END;
/

EXEC GET_EMP_SAL(4);


-- User-defined Exceptions: User-defined exceptions are defined by the user and raised explicitly in the PLSQL block.
-- EXCEPTION, RAISE or RAISE_APPLICATION_ERROR, PRAGMA EXCEPTION_INIT

CREATE OR REPLACE PROCEDURE APPLY_LONG_TERM_BONUS(emp_id INT)
    emp_term NUMBER;
    emp_sal NUMBER;
    emp_no_bonus_long_term EXCEPTION;
BEGIN
    SELECT INT((SYSDATE - hire_date)/365), salary INTO emp_term, emp_sal FROM emp WHERE employee_id = emp_id;
    IF (emp_term < 10) THEN
        RAISE emp_no_bonus_long_term;
    ELSE
        emp_sal := emp_sal + 10000;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Employee Salary with bonus: ' || emp_sal);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than one employee found');
    WHEN emp_no_bonus_long_term THEN
        DBMS_OUTPUT.PUT_LINE('Employee is not a long term employee');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred:' || sqlerrm || ' Error code: ' || sqlcode);
END APPLY_LONG_TERM_BONUS;
/

EXEC APPLY_LONG_TERM_BONUS(120);

DECLARE
    emp_sal NUMBER;
    emp_id NUMBER := 120; 
    emp_low_sal EXCEPTION;
BEGIN
    SELECT salary INTO emp_sal FROM hr.employees WHERE employee_id = emp_id;
    IF emp_sal < 10000 THEN
        RAISE emp_low_sal;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_sal);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found');
    WHEN emp_low_sal THEN
        DBMS_OUTPUT.PUT_LINE('Employee salary is less than 10000');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred:' || sqlerrm || ' Error code: ' || sqlcode);
END;

-- PRAGMA EXCEPTION_INIT: It is used to associate an exception with an error number. Err number ranges from -20000 to -20999.

DECLARE
    emp_sal NUMBER;
    emp_id NUMBER := 120; 
    emp_low_sal EXCEPTION;
    PRAGMA EXCEPTION_INIT(emp_low_sal, -20001);
BEGIN
    SELECT salary INTO emp_sal FROM hr.employees WHERE employee_id = emp_id;
    IF emp_sal < 10000 THEN
        RAISE emp_low_sal;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_sal);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than one employee found');
    WHEN emp_low_sal THEN
        DBMS_OUTPUT.PUT_LINE('Error Code:' || sqlcode || '. Employee salary is less than 10000. '); 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred:' || sqlerrm || ' Error code: ' || sqlcode);
END;


-- Raise application error: It is used to raise a user-defined error message and error number.

DECLARE
    emp_sal NUMBER;
    emp_id NUMBER := 1; 
BEGIN
    SELECT salary INTO emp_sal FROM hr.employees WHERE employee_id = emp_id;
    IF emp_sal < 10000 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Employee salary is less than 10000');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_sal);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than one employee found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred:' || sqlerrm || ' Error code: ' || sqlcode);
END;
