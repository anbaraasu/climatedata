-- PLSQL Procedures - A procedure is a subprogram that performs a specific action. It is a named PLSQL block which is stored in the database. It accepts input in the form of parameters and returns the output in the form of parameters or it may not return any value.

-- Parameters types - IN, OUT, IN OUT

-- Syntax:
-- CREATE [OR REPLACE] PROCEDURE procedure_name
-- (parameter_name IN/OUT/IN OUT datatype, parameter_name IN/OUT/IN OUT datatype)

-- Demo for out parameter
CREATE OR REPLACE PROCEDURE GET_EMPLOYEE_DETAILS(p_emp_id IN NUMBER, p_emp_name OUT VARCHAR2, p_emp_sal OUT NUMBER) AS
BEGIN
    SELECT first_name, salary INTO p_emp_name, p_emp_sal FROM hr.employees WHERE employee_id = p_emp_id;
END GET_EMPLOYEE_DETAILS;
/

-- execute the procedure
DECLARE
    emp_name VARCHAR2(50);
    emp_sal NUMBER;
BEGIN
    GET_EMPLOYEE_DETAILS(1, emp_name, emp_sal);
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name);
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_sal);
END;


-- Demo for IN OUT parameter
CREATE OR REPLACE PROCEDURE UPDATE_EMPLOYEE_SALARY(p_emp_sal IN OUT NUMBER) AS
BEGIN
    p_emp_sal := p_emp_sal + 1000;
END UPDATE_EMPLOYEE_SALARY;
/

-- execute the procedure
DECLARE
    emp_sal NUMBER := 10000;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Employee Salary(before): ' || emp_sal);
    UPDATE_EMPLOYEE_SALARY(emp_sal);
    DBMS_OUTPUT.PUT_LINE('Employee Salary(after): ' || emp_sal);
END;