-- PLSQL - multiple statement
-- variables and constant
    -- varname = value;
-- data types
    -- number, varchar, varchar2, char, date, timestamp, decimal
    
    name varchar(20) := 'John';
    company_name char(7) := 'HCL';
    salary number(15,2) := 10000.00;

-- operators
    -- arithmetic operators - +, -, *, /, %, **
    -- relational operators - =, !=, <>, >, <, >=, <=
    -- logical operators - AND, OR, NOT
    -- string operators = ||

-- condn. statements
    -- if-else
    if (num > 0) then
        if num % 2 == 0 then
            print('Even');
        else        
            print('Odd');
        end if;
    else
        print('Negative');
    end if;

    -- case
    case day_num
        when 1 then print('Monday');
        when 2 then print('Tuesday');
        when 3 then print('Wednesday');
        when 4 then print('Thursday');
        when 5 then print('Friday');
        when 6 then print('Saturday');
        when 7 then print('Sunday');
        else print('Invalid day');
    end case;

    # use if on above example 
    if day_num == 1 then
        print('Monday');
    else if day_num == 2 then
        print('Tuesday');
    else if day_num == 3 then
        print('Wednesday');
    else if day_num == 4 then
        print('Thursday');
    else if day_num == 5 then
        print('Friday');
    else if day_num == 6 then
        print('Saturday');
    else if day_num == 7 then
        print('Sunday');
    else
        print('Invalid day');
    end if;
    
-- loop statements - repeat a block of code multiple times
    -- for loop
    for i in 1..10 loop
        print(i);
    end loop;

    -- 1-10 print even number 
    for i in 1..10 loop
        if i % 2 == 0 then
            print(i);
        end if;
    end loop;

    -- without loop
    num int := 1;
    if num % 2 == 0 then
        print(num);
    end if;
    num := num + 1;
    if num % 2 == 0 then
        print(num);
    end if;
    num := num + 1;

    -- while loop - entry controlled loop
    i := 1;
    while i < 10 loop -- true then logic will repeat
        print(i);
        i := i - 1;
    end loop;

    -- loop - you decide the exit condition
    loop
        print(i);
        i := i + 1;
        exit when i > 10; -- true then loop will exit. false then loop will continue.
    end loop;

-- control statements
    -- break - exit the loop
    -- continue - skip the current iteration and continue with next iteration
    -- return - return from a function or procedure

-- PLSQL Block or Anonymous PLSQL Block
DECLARE --optional 
	-- variables, constant
BEGIN -- required
	-- logic / code 
EXCEPTION --optional 
	-- handle the error
END; -- required

CREATE PROCEDURE myproc AS/IS -- named proc
    -- variables, constants
BEGIN -- required
	-- logic / code 
EXCEPTION --optional 
	-- handle the error
END myproc; -- required

-- SET SERVEROUTPUT ON - this is required during SQL Developer or SQLPLUS for every session. 
-- livesql does not reuqire this statment
DECLARE
	l_name VARCHAR2(10) := 'Anbu'; --initialization
	l_age INT ; -- declare
    l_gender CHAR(1);
BEGIN
    l_gender := :Gender;
    l_age := 0; -- assignment
	IF (l_age > 0 ) THEN
        IF (l_age < 13) THEN
            DBMS_OUTPUT.PUT_LINE('My Name:' || l_name || ' you are a kid');
    	ELSE IF (l_age >= 13 AND l_age <= 18) THEN
            DBMS_OUTPUT.PUT_LINE('My Name:' || l_name || ' you are a teenager');
    	ELSE
            DBMS_OUTPUT.PUT_LINE('My Name:' || l_name || ' you are an Adult');
    	END IF;
	ELSE
        DBMS_OUTPUT.PUT_LINE('You age value is invalid');
    END IF;

    -- CASE example
    CASE l_gender
        WHEN 'M' THEN
            DBMS_OUTPUT.PUT_LINE('Your tax is calculated after 3 lacs');
        WHEN 'F' THEN
            DBMS_OUTPUT.PUT_LINE('Your tax is calculated after 3.5 lacs');
        ELSE
            DBMS_OUTPUT.PUT_LINE('');
    END CASE;

END;


-- PLSQL CONTROL STATEMENTS - CONTINUE, EXIT, GOTO, RETURN

-- I -> 1,2,3,4,5,6,7,8,9,10
-- J -> 1,2,3,4,5,6,7,8,9,10

IF J = 3 THEN
    CONTINUE;
END IF;
IF J = 5 THEN
    RETURN;
END IF;

--output : 1, 2, 4, 

