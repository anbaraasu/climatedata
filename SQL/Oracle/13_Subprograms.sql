-- Sub program - Procedure or Function

DECLARE
    --global
    COMPANY_NAME VARCHAR2(7) := 'HCLTECH';
BEGIN
    DECLARE
        --local
        l_name VARCHAR2(10) := 'A';
        l_age INT := 21;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(COMPANY_NAME);
        DBMS_OUTPUT.PUT_LINE(CHR(13) || ' Name:' || CHR(13) || l_name);
        DBMS_OUTPUT.PUT_LINE(CHR(13) || ' Age:' || CHR(13) || l_age);
    END;
END;



-- PROCEDURE - NESTED PROCEDURE


DECLARE
    -- Variable to hold the sum of two numbers
    v_sum NUMBER;
    
    -- Variable to check if a number is even
    v_is_even BOOLEAN;
    
    -- Function to add two numbers
    FUNCTION add_numbers(p_num1 IN NUMBER, p_num2 IN NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN p_num1 + p_num2;
    END add_numbers;
    
    -- Function to check if a number is even
    FUNCTION is_even(p_num IN NUMBER) RETURN BOOLEAN IS
    BEGIN
        RETURN MOD(p_num, 2) = 0;
    END is_even;
 
    -- Procedure to display the sum of two numbers
    PROCEDURE show_addition_result(p_num1 IN NUMBER, p_num2 IN NUMBER) IS
    BEGIN
        v_sum := add_numbers(p_num1, p_num2);
        DBMS_OUTPUT.PUT_LINE('The sum of ' || p_num1 || ' and ' || p_num2 || ' is ' || v_sum);
    END show_addition_result;
    
    -- Procedure to display if a number is even or odd
    PROCEDURE check_even_or_odd(p_num IN NUMBER) IS
    BEGIN
        v_is_even := is_even(p_num);
        IF v_is_even THEN
            DBMS_OUTPUT.PUT_LINE(p_num || ' is even.');
        ELSE
            DBMS_OUTPUT.PUT_LINE(p_num || ' is odd.');
        END IF;
    END check_even_or_odd;
 
BEGIN
    -- Call the procedure to display the sum of two numbers
    show_addition_result(10, 20);
    
    -- Call the procedure to check if a number is even or odd
    check_even_or_odd(15);
    check_even_or_odd(8);
    
END;