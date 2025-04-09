/*
PL/SQL Procedure
Parameter Mode:
IN, OUT, IN OUT
    IN: Default mode, used to pass values to the procedure (ready only). The value passed cannot be changed in the procedure.
    OUT: Used to return values from the procedure. The value passed can be changed in the procedure.
    IN OUT: Used to pass and return values from the procedure. The value passed can be changed in the procedure.
*/

-- PLSQL script demo on Procedure with OUT parameter
CREATE OR REPLACE PROCEDURE APPLY_LONG_TERM_BONUS(p_emp_id INT, p_emp_sal OUT NUMBER, p_bonus IN OUT NUMBER) AS
    emp_term NUMBER;
    emp_no_bonus_long_term EXCEPTION;
BEGIN
    SELECT TRUNC((SYSDATE - hire_date)/365), salary INTO emp_term, p_emp_sal FROM hr_emp WHERE employee_id = p_emp_id;
    IF (emp_term < 10) THEN
        p_bonus := 0;
        RAISE emp_no_bonus_long_term;
    ELSE
        p_bonus := 1000;
        p_emp_sal := p_emp_sal + p_bonus;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found');
    WHEN emp_no_bonus_long_term THEN
        DBMS_OUTPUT.PUT_LINE('To receive the bonus emp need to work for another ' || (10 - emp_term) || ' year(s)');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred:' || sqlerrm || ' Error code: ' || sqlcode);
END APPLY_LONG_TERM_BONUS;
/

DECLARE 
    emp_sal NUMBER;
    emp_bonus NUMBER;
    emp_id NUMBER := 110; --100 , 110
BEGIN
    emp_bonus := 10000;
    DBMS_OUTPUT.PUT_LINE('Trying to give bonus of ' || emp_bonus);
    APPLY_LONG_TERM_BONUS(emp_id, emp_sal, emp_bonus);
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_sal);
    DBMS_OUTPUT.PUT_LINE('Received bonus of ' || emp_bonus);
END;
/