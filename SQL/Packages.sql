--PLSQL Packages - A package is a collection of related procedures, functions, variables, and other package constructs. It is a schema object that groups logically related PLSQL types, variables, and subprograms. It provides modularity, maintainability, and reusability.

--Syntax:
--CREATE [OR REPLACE] PACKAGE package_name AS
--    -- Declaration section
--    -- Constants, types, variables, exceptions, cursors, subprograms
--END package_name;
--/

-- Amazon - Customer Registration Package, Customer Login Package, Order Package, Product Package, Payment Package, Shipping Package, Notification Package, Feedback Package, Review Package, Rating Package, Cart Package, Wishlist Package, Search Package, Recommendation Package, Promotion Package, Discount Package, Invoice Package.

-- SYNTAX : 
CREATE OR REPLACE PACKAGE package_name AS
    -- Declaration section
    -- Constants, types, variables, exceptions, cursors, subprograms
END package_name;

CREATE OR REPLACE PACKAGE BODY package_name AS
    -- Implementation section
    -- Subprograms
END package_name;
/

-- SPECIFICATION AND BODY - A package has two parts: specification and body. The specification is the interface to the package. It contains the declaration of types, variables, constants, exceptions, cursors, and subprograms. The body contains the implementation of the subprograms.

- Specification - mandatory. We require specification without body to access the variables, constants, types, exceptions.
- Body - optional

-- Demo for persistence of variables in a package (local, public, global)

CREATE OR REPLACE PACKAGE emp_package AS
    PRAGMA serially_reusable;
	g_counter NUMBER := 3; -- global variable
    PROCEDURE INCREMENT_COUNTER;
END emp_package;
/

CREATE OR REPLACE PACKAGE BODY emp_package AS
    PRAGMA serially_reusable;
    p_counter NUMBER := 2; -- public variable
    PROCEDURE INCREMENT_COUNTER IS
    l_counter NUMBER := 1; -- local variable
    BEGIN
        g_counter := g_counter + 3;
        p_counter := p_counter + 2;
        l_counter := l_counter + 1;
        DBMS_OUTPUT.PUT_LINE('Counter: ' || g_counter);
        DBMS_OUTPUT.PUT_LINE('Counter: ' || p_counter);
        DBMS_OUTPUT.PUT_LINE('Counter: ' || l_counter);
    END INCREMENT_COUNTER;
END emp_package;
/

-- execute the package
EXEC emp_package.INCREMENT_COUNTER;
EXEC emp_package.INCREMENT_COUNTER;
EXEC emp_package.INCREMENT_COUNTER;


-- Overloading - Overloading is a feature in PLSQL that allows you to define multiple subprograms with the same name but different parameters. It is a technique to define multiple subprograms with the same name but different parameters.

-- Demo for overloading
CREATE OR REPLACE PACKAGE emp_package AS
    -- Overloaded two procedures, one with number as parameter, varchar2 as parameter
    PROCEDURE GET_EMPLOYEE_DETAILS(p_emp_id IN NUMBER);
    PROCEDURE GET_EMPLOYEE_DETAILS(p_emp_name IN VARCHAR2);
END emp_package;

CREATE OR REPLACE PACKAGE BODY emp_package AS
    l_emp_name VARCHAR2(500);
    PROCEDURE GET_EMPLOYEE_DETAILS(p_emp_id IN NUMBER) IS    
    BEGIN
        SELECT first_name || ' ' || last_name INTO l_emp_name FROM hr.employees WHERE employee_id = p_emp_id;
        DBMS_OUTPUT.PUT_LINE('Employee full Name: ' || l_emp_name);
    END GET_EMPLOYEE_DETAILS;
    
    PROCEDURE GET_EMPLOYEE_DETAILS(p_emp_name IN VARCHAR2) IS
    BEGIN
        SELECT first_name || ' ' || last_name INTO l_emp_name FROM hr.employees 
        WHERE first_name = p_emp_name;
        DBMS_OUTPUT.PUT_LINE('Employee full Name: ' || l_emp_name);
    END GET_EMPLOYEE_DETAILS;
END emp_package;
/

-- Demo for public and private package 
CREATE OR REPLACE PACKAGE emp_package AS
    PROCEDURE GET_EMPLOYEE_DETAILS(p_emp_id IN NUMBER);
END emp_package;

CREATE OR REPLACE PACKAGE BODY emp_package AS
    PROCEDURE GET_EMPLOYEE_DETAILS(p_emp_name IN VARCHAR2) IS
    BEGIN
        SELECT first_name || ' ' || last_name INTO l_emp_name FROM hr.employees 
        WHERE first_name = p_emp_name;
        DBMS_OUTPUT.PUT_LINE('Employee full Name: ' || l_emp_name);
    END GET_EMPLOYEE_DETAILS;

    PROCEDURE GET_EMPLOYEE_DETAILS(p_emp_id IN NUMBER) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || p_emp_id);
    END GET_EMPLOYEE_DETAILS;
END emp_package;
/
