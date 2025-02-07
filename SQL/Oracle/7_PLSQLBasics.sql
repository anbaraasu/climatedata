-- PLSQL - multiple statement
-- variables and constant
    -- varname = value;
-- data types
    -- number, int, decimal, varchar, varchar2, char, date, timestamp
    
-- scope 
    -- local, global/public
    l_name varchar(20) := 'John';
    g_company_name CONSTANT varchar2(7) := 'HCLTech';
    l_salary number(15,2) := 9999999999999.99;

-- operators
    -- arithmetic operators - +, -, *, /, %, ** (BEDMAS)
    -- relational operators - =, !=, <>, >, <, >=, <=
    -- logical operators - AND, OR, NOT
    -- string operators = ||
    -- assignment operator - := 

-- condn. statements
    -- if-else - if-elsif-else, if-elsif-elsif-else, if-if-else-else(nested if)
    if (num > 0) then
        if MOD(num,2) = 0 then
            DBMS_OUTPUT.PUT_LINE('Even');
        else        
            DBMS_OUTPUT.PUT_LINE('Odd');
        end if;
    else
        DBMS_OUTPUT.PUT_LINE('Only non zero values are accepted.');
    end if;

    -- case
    case day_num
        when 1 then DBMS_OUTPUT.PUT_LINE('Monday');
        when 2 then DBMS_OUTPUT.PUT_LINE('Tuesday');
        when 3 then DBMS_OUTPUT.PUT_LINE('Wednesday');
        when 4 then DBMS_OUTPUT.PUT_LINE('Thursday');
        when 5 then DBMS_OUTPUT.PUT_LINE('Friday');
        when 6 then DBMS_OUTPUT.PUT_LINE('Saturday');
        when 7 then DBMS_OUTPUT.PUT_LINE('Sunday');
        else DBMS_OUTPUT.PUT_LINE('Invalid day');
    end case;

    # use if on above example 
    if day_num == 1 then
        DBMS_OUTPUT.PUT_LINE('Monday');
    elsif day_num == 2 then
        DBMS_OUTPUT.PUT_LINE('Tuesday');
    elsif day_num == 3 then
        DBMS_OUTPUT.PUT_LINE('Wednesday');
    elsif day_num == 4 then
        DBMS_OUTPUT.PUT_LINE('Thursday');
    elsif day_num == 5 then
        DBMS_OUTPUT.PUT_LINE('Friday');
    elsif day_num == 6 then
        DBMS_OUTPUT.PUT_LINE('Saturday');
    elsif day_num == 7 then
        DBMS_OUTPUT.PUT_LINE('Sunday');
    else
        DBMS_OUTPUT.PUT_LINE('Invalid day');
    end if;
    
-- loop statements - repeat a block of code multiple times
    -- for loop - finite number of times
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
    
    -- for loop print in reverse 10 to 1
    FOR i IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
    --without loop
    DBMS_OUTPUT.PUT_LINE(1);
    DBMS_OUTPUT.PUT_LINE(2);
    DBMS_OUTPUT.PUT_LINE(3);
    DBMS_OUTPUT.PUT_LINE(4);
    DBMS_OUTPUT.PUT_LINE(5);


    -- 1-10 DBMS_OUTPUT.PUT_LINE even number 
    for i in 1..10 loop
        if i % 2 == 0 then
            DBMS_OUTPUT.PUT_LINE(i);
        end if;
    end loop;

    -- without loop
    num int := 1;
    if num % 2 == 0 then
        DBMS_OUTPUT.PUT_LINE(num);
    end if;
    num := num + 1;
    if num % 2 == 0 then
        DBMS_OUTPUT.PUT_LINE(num);
    end if;
    num := num + 1;

    -- while loop - entry controlled loop
    i := 1;
    while i < 10 loop -- true then logic will repeat
        DBMS_OUTPUT.PUT_LINE(i);
        i := i - 1;
    end loop;

    -- loop - you can decide the exit condition
    loop
        DBMS_OUTPUT.PUT_LINE(i);
        i := i + 1;
        exit when i > 10; -- true then loop will exit. false then loop will continue.
    end loop;

-- control statements
    -- break - exit the loop
    -- continue - skip the current iteration and continue with next iteration
    -- return - return from a function or procedure
    -- goto - jump to a label
    -- exit - exit from a loop/program

-- Demo with all control statements
DECLARE 
    i INT := 1;
BEGIN
    WHILE i <= 10 LOOP -- continue from this line        
    	IF i = 3 THEN
            i := i + 1;
            CONTINUE;
        END IF;
        IF (i = 4) THEN
            GOTO skipfour;
        END IF;
        DBMS_OUTPUT.PUT_LINE(i);
        <<skipfour>>
        i := i + 1;
        EXIT WHEN (i = 9);
        IF (i = 6) THEN
            RETURN; -- GOTO END line. 1, 2, 5 
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Exit');
END;


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
-- livesql does not require this statment
DECLARE
	l_name VARCHAR2(10) := 'Anbu'; --initialization
	l_age INT ; -- declare
    l_gender CHAR(1);
BEGIN
    l_gender := :Gender;
    l_age := 0; -- assignment
	IF (l_age > 0) THEN
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



DECLARE
    day_num INT := 1;
BEGIN
        case day_num
        when 1 then DBMS_OUTPUT.PUT_LINE('Monday');
        when 2 then DBMS_OUTPUT.PUT_LINE('Tuesday');
        when 3 then DBMS_OUTPUT.PUT_LINE('Wednesday');
        when 4 then DBMS_OUTPUT.PUT_LINE('Thursday');
        when 5 then DBMS_OUTPUT.PUT_LINE('Friday');
        when 6 then DBMS_OUTPUT.PUT_LINE('Saturday');
        when 7 then DBMS_OUTPUT.PUT_LINE('Sunday');
        else DBMS_OUTPUT.PUT_LINE('Invalid day');
    end case;

    # use if on above example 
    if day_num == 1 then
        DBMS_OUTPUT.PUT_LINE('Monday');
    elsif day_num == 2 then
        DBMS_OUTPUT.PUT_LINE('Tuesday');
    elsif day_num == 3 then
        DBMS_OUTPUT.PUT_LINE('Wednesday');
    elsif day_num == 4 then
        DBMS_OUTPUT.PUT_LINE('Thursday');
    elsif day_num == 5 then
        DBMS_OUTPUT.PUT_LINE('Friday');
    elsif day_num == 6 then
        DBMS_OUTPUT.PUT_LINE('Saturday');
    elsif day_num == 7 then
        DBMS_OUTPUT.PUT_LINE('Sunday');
    else
        DBMS_OUTPUT.PUT_LINE('Invalid day');
    end if;
END;

-- CONTROL STATEMENTS - CONTINUE, EXIT, GOTO, RETURN

-- DEMO FOR CONTINUE
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 10 LOOP
        IF i = 3 THEN
            i := i + 1;
            CONTINUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE(i);
        i := i + 1;
    END LOOP;
END;
--output : 1, 2, 4, 5, 6, 7, 8, 9, 10

-- DEMO FOR GO
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 10 LOOP
        IF i = 3 THEN
            i := i + 1;
            GOTO myloop;
        END IF;
        DBMS_OUTPUT.PUT_LINE(i);
        <<myloop>>
        i := i + 1;
    END LOOP;
END;
/

-- DEMO FOR RETURN
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 10 LOOP
        IF i = 3 THEN
            i := i + 1;
            RETURN;
        END IF;
        DBMS_OUTPUT.PUT_LINE(i);
        i := i + 1;
    END LOOP;
END;
-- output: 1, 2

-- CONTROL STATEMENTS - CONTINUE, EXIT, GOTO, RETURN
-- DEMO FOR CONTINUE, EXIT, GOTO, RETURN
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= 10 LOOP -- continue from this line        
    	IF i = 3 THEN
            i := i + 1;
            CONTINUE;
        END IF;
		IF (i = 4) THEN
            GOTO skipfour;
        END IF;
        DBMS_OUTPUT.PUT_LINE(i);
		<<skipfour>>
        i := i + 1;
		EXIT WHEN (i = 9);
		IF (i = 6) THEN
            RETURN; -- GOTO END line. 1, 2, 5 
		END IF;
    END LOOP;
	DBMS_OUTPUT.PUT_LINE('Exit');
END;
/

