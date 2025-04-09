--PLSQL Functions - A function is a subprogram that computes a value. It is a named PLSQL block which is stored in the database. It accepts input in the form of parameters and returns the output in the form of a value. Always a function should return a value.

-- Avoid using DML statements in functions. It is not recommended to use DML statements in functions. It is recommended to use functions for computation and return the value.

-- Parameter types - IN, OUT, IN OUT

-- Demo for IN parameter to calculate the pf of an employee
-- pf is calculated as 12% of the basic salary. The basic salary is 1/20 of the total salary.
CREATE OR REPLACE FUNCTION CALCULATE_PF(p_emp_sal IN NUMBER) 
RETURN NUMBER AS
    pf NUMBER;
BEGIN
    pf := p_emp_sal / 20 * 0.12;
    RETURN pf;
END CALCULATE_PF;
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


-- sub programs - A subprogram is a program unit/module that performs a specific action. It is a named PLSQL block which is stored in the database. It can be a procedure or a function.

-- Advantages of subprograms:
--     -- Code reusability
--     -- Modularity
--     -- Maintainability
--     -- Performance

DECLARE 
    company_name VARCHAR2(50) := 'HCLTech';
    PROCEDURE PRINT_COMPANY_NAME IS
        local_company := 'TEST';
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Company Name: ' || company_name);
        company_name := 'Oracle';
    END PRINT_COMPANY_NAME;    
BEGIN
    PRINT_COMPANY_NAME;
	DBMS_OUTPUT.PUT_LINE('Company Name: ' || company_name);
END;



-- Recursion - Recursion is a technique in which a function calls itself. It is a powerful technique to solve complex problems. It is used to solve problems that can be broken down into smaller problems of the same type.

-- Demo for recursion
CREATE OR REPLACE FUNCTION FACTORIAL(n IN NUMBER) RETURN NUMBER AS
BEGIN
    IF n = 0 THEN
        RETURN 1;
    ELSE
        RETURN n * FACTORIAL(n - 1);
    END IF;
END;
/

-- execute the function
SELECT FACTORIAL(5) FROM dual;
