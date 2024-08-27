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
--     -- It is a fixed size collection

DECLARE
    TYPE emp_names IS VARRAY(3) OF VARCHAR2(50);
    emp_name emp_names := emp_names('Anbu', 'Raj', 'Kumar');
BEGIN
    FOR i IN 1..emp_name.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || emp_name(i));
    END LOOP;
END;
