-- PLSQL Collections
--     -- Collection is a group of elements of same type

--     -- 1. Record
--     -- 2. Associative Array
--     -- 3. Nested Table
--     -- 4. VARRAY
--     -- 5. Cursors

-- PLSQL script demo on RECORD
--     -- Record is a collection type in PLSQL
--     -- It is a collection of elements of different type

DECLARE
    TYPE emp_record IS RECORD (
        emp_id INT,
        emp_name VARCHAR2(50),
        emp_sal NUMBER(15,2)
    );
    emp_rec emp_record;
BEGIN
    emp_rec.emp_id := 100;
    emp_rec.emp_name := 'Anbu';
    emp_rec.emp_sal := 1000;
    
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_rec.emp_id);
    DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_rec.emp_name);
    DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_rec.emp_sal);
END;

-- PLSQL script demo on Associative Array
--     -- Associative Array is a collection type in PLSQL
--     -- It is a collection of key-value pairs
--     -- It is also called as index-by table

DECLARE
    TYPE emp_salary IS TABLE OF NUMBER INDEX BY VARCHAR2(50);
    emp_sal emp_salary;
BEGIN
    emp_sal('Anbu') := 1000;
    emp_sal('Raj') := 2000;
    emp_sal('Kumar') := 3000;
    
    DBMS_OUTPUT.PUT_LINE('Anbu Salary: ' || emp_sal('Anbu'));
    DBMS_OUTPUT.PUT_LINE('Raj Salary: ' || emp_sal('Raj'));
    DBMS_OUTPUT.PUT_LINE('Kumar Salary: ' || emp_sal('Kumar'));
END;

-- PLSQL script demo on Nested Table
--     -- Nested Table is a collection type in PLSQL
--     -- It is a collection of elements of same type

DECLARE
    TYPE emp_names IS TABLE OF VARCHAR2(50);
    emp_name emp_names := emp_names('Anbu', 'Raj', 'Kumar');
BEGIN
    FOR i IN 1..emp_name.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name(i));
    END LOOP;
END;

-- PLSQL script demo on VARRAY
--     -- VARRAY is a collection type in PLSQL
--     -- It is a collection of elements of same type
--     -- It is a fixed size collection, we need to specify the size but we can add less than the specified size, then we can extend.

DECLARE
    TYPE emp_names IS VARRAY(3) OF VARCHAR2(50);
    emp_name emp_names := emp_names('Anbu', 'Raj', 'Kumar');
BEGIN
    FOR i IN 1..emp_name.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name(i));
    END LOOP;
END;

DECLARE
    TYPE emp_names IS VARRAY(3) OF VARCHAR2(50);
    emp_name emp_names := emp_names('Anbu', 'Raj');
BEGIN
    FOR i IN 1..emp_name.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name(i));
    END LOOP;
    -- extend the varray
    emp_name.EXTEND;
    emp_name(3) := 'Ravi';
    FOR i IN 1..emp_name.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name(i));
    END LOOP;
END;



-- PLSQL script demo on Cursors
--     -- Cursor is a collection type in PLSQL
--     -- It is a pointer to the result set of a query
--     -- types of cursor - Implicit Cursor, Explicit Cursor
--     -- Implicit Cursor - Automatically created by Oracle
--     -- Explicit Cursor - User defined cursor
--     -- Cursor Attributes - %FOUND, %NOTFOUND, %ROWCOUNT, %ISOPEN
--     -- Weak Ref Cursor - Ref Cursor with no return type
--     -- Strong Ref Cursor - Ref Cursor with return type

DECLARE
    CURSOR emp_cur IS
        SELECT * FROM employees;
    emp_rec employees%ROWTYPE;
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO emp_rec;
        EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_rec.employee_id);
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_rec.first_name);
        DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_rec.salary);
    END LOOP;
    CLOSE emp_cur;
END;

-- PLSQL script demo on Strong Ref Cursor

DECLARE
    TYPE emp_cur IS REF CURSOR RETURN hr.employees%ROWTYPE;
    emp_rec emp_cur;
    emp_rec1 employees%ROWTYPE;
BEGIN
    OPEN emp_rec FOR
        SELECT employee_id, first_name, salary FROM hr.employees;
    LOOP
        FETCH emp_rec INTO emp_rec1;
        EXIT WHEN emp_rec%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_rec1.employee_id);
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_rec1.first_name);
        DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_rec1.salary);
    END LOOP;
    CLOSE emp_rec;
END;


-- LIST the customer and unique product bought by name

-- CURSOR FOR LOOP 

CREATE OR REPLACE PROCEDURE DISPLAY_CUST_DETAILS(p_gender CHAR) AS
    CURSOR cust_cur(c_gender CHAR) IS SELECT cust_first_name, customer_id FROM OE.CUSTOMERS WHERE GENDER = c_gender; 
	CURSOR prod_cur(c_customerid INTEGER) IS 
        SELECT distinct P.PRODUCT_NAME FROM OE.PRODUCT_INFORMATION P JOIN OE.ORDER_ITEMS OI
        ON P.PRODUCT_ID = OI.PRODUCT_ID JOIN OE.ORDERS O
        ON O.ORDER_ID = OI.ORDER_ID WHERE CUSTOMER_ID = c_customerid;
BEGIN
    FOR cust_rec IN cust_cur(p_gender) LOOP
        DBMS_OUTPUT.PUT_LINE('Customer Name: ' || cust_rec.cust_first_name);
		FOR prd_rec IN prod_cur(cust_rec.customer_id) LOOP
        	DBMS_OUTPUT.PUT_LINE(CHR(9) || 'Product Name: ' || prd_rec.PRODUCT_NAME);
    	END LOOP;
    END LOOP;
END;
/

EXEC DISPLAY_CUST_DETAILS('M');
EXEC DISPLAY_CUST_DETAILS('F');

 
 -- Procedure with Weak Type Cursor demo, flag parameter in proc will decide which table either hr.employees or hr.department to display the data
 CREATE OR REPLACE PROCEDURE weak_type_cursor_demo(flag boolean) AS
    TYPE emp_cur IS REF CURSOR;
    cur_rec emp_cur;
    emp_rec1 emp%ROWTYPE;
    dept_rec1 dept%ROWTYPE;
BEGIN
    if (flag) then
        OPEN cur_rec FOR
            SELECT * FROM emp;
        LOOP
            FETCH cur_rec INTO emp_rec1;
            EXIT WHEN cur_rec%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_rec1.id);
            DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_rec1.full_name);
            DBMS_OUTPUT.PUT_LINE('Employee Salary: ' || emp_rec1.salary);
        END LOOP;
    ELSE
        OPEN cur_rec FOR
            SELECT * FROM dept;
        LOOP
            FETCH cur_rec INTO dept_rec1;
            EXIT WHEN cur_rec%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Dept ID: ' || dept_rec1.id);
            DBMS_OUTPUT.PUT_LINE('Dept Name: ' || dept_rec1.name);
        END LOOP;
    END IF;
        CLOSE cur_rec;
END;
/