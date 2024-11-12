-- PLSQL Exception Handling - Exception is an error handling mechanism in PLSQL, it is used to handle the runtime errors that occur during the execution of a PLSQL program. 

-- types of exceptions: 
--     -- Predefined Exceptions
--     -- User-defined Exceptions

-- Predefined Exceptions:
--     -- NO_DATA_FOUND
--     -- TOO_MANY_ROWS
--     -- INVALID_CURSOR
--     -- ZERO_DIVIDE
--     -- DUP_VAL_ON_INDEX
--     -- LOGIN_DENIED

-- Demo on Predefined Exceptions

DECLARE
    emp_sal NUMBER;
BEGIN
    SELECT salary INTO emp_sal FROM hr.employees WHERE employee_id = 1;
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_sal);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found for ID:1');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than one employee found');
END;

-- User-defined Exceptions: User-defined exceptions are defined by the user and raised explicitly in the PLSQL block.
-- EXCEPTION, RAISE or RAISE_APPLICATION_ERROR, PRAGMA EXCEPTION_INIT

DECLARE
    emp_sal NUMBER;
    emp_id NUMBER := 1; 
    emp_not_found EXCEPTION;
BEGIN
    SELECT salary INTO emp_sal FROM hr.employees WHERE employee_id = emp_id;
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_sal);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE emp_not_found;
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than one employee found');
    WHEN emp_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred:' || sqlerrm || ' Error code: ' || sqlcode);
END;

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
    emp_low_sal EXCEPTION;
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
