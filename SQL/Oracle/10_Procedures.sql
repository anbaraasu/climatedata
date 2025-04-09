/*
PL/SQL Procedure
Parameter Mode:
IN, OUT, IN OUT
    IN: Default mode, used to pass values to the procedure (ready only). The value passed cannot be changed in the procedure.
    OUT: Used to return values from the procedure. The value passed can be changed in the procedure.
    IN OUT: Used to pass and return values from the procedure. The value passed can be changed in the procedure.
*/

-- PLSQL script demo on Procedure with OUT parameter
CREATE OR REPLACE PROCEDURE APPLY_LONG_TERM_BONUS(p_emp_id INT, p_emp_sal OUT NUMBER) AS
    emp_term NUMBER;
    emp_no_bonus_long_term EXCEPTION;
BEGIN
    SELECT TRUNC((SYSDATE - hire_date)/365), salary INTO emp_term, p_emp_sal FROM hr_emp WHERE employee_id = p_emp_id;
    IF (emp_term < 10) THEN
        RAISE emp_no_bonus_long_term;
    ELSE
        p_emp_sal := p_emp_sal + 1000;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found');
    WHEN emp_no_bonus_long_term THEN
        DBMS_OUTPUT.PUT_LINE('To receive the bonus emp need to work for another ' || (10 - emp_term) || ' years');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred:' || sqlerrm || ' Error code: ' || sqlcode);
END APPLY_LONG_TERM_BONUS;
/

EXEC APPLY_LONG_TERM_BONUS(100, 200);

DECLARE 
    emp_sal NUMBER;
    emp_id NUMBER := 120;
BEGIN
    APPLY_LONG_TERM_BONUS(emp_id, emp_sal);
    DBMS_OUTPUT.PUT_LINE('Employee Salary with bonus: ' || emp_sal);
END;