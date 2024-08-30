--PLSQL Functions - A function is a subprogram that computes a value. It is a named PLSQL block which is stored in the database. It accepts input in the form of parameters and returns the output in the form of a value. Always a function should return a value.

-- Avoid using DML statements in functions. It is not recommended to use DML statements in functions. It is recommended to use functions for computation and return the value.

-- Parameter types - IN, OUT, IN OUT

-- Demo for IN parameter to calculate the pf of an employee
CREATE OR REPLACE FUNCTION CALCULATE_PF(p_emp_sal IN NUMBER) RETURN NUMBER AS
    pf NUMBER;
BEGIN
    pf := p_emp_sal * 0.12;
    RETURN pf;
END;
/

-- execute the function
SELECT first_name, salary, CALCULATE_PF(salary) AS PF FROM hr.employees WHERE employee_id = 100;

-- Demo for OUT parameter
CREATE OR REPLACE FUNCTION GET_EMPLOYEE_SALARY(p_emp_id IN NUMBER, p_emp_name OUT VARCHAR2) RETURN NUMBER AS
    emp_sal NUMBER;
BEGIN
    SELECT salary, first_name INTO emp_sal, p_emp_name FROM hr.employees WHERE employee_id = p_emp_id;
    RETURN emp_sal;
END;
/
-- execute the function
DECLARE
    emp_name VARCHAR2(50);
    emp_sal NUMBER;
BEGIN
    emp_sal := GET_EMPLOYEE_SALARY(1, emp_name);
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name);
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_sal);
END;
