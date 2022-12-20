SET SERVEROUTPUT ON

-- Example 1
-- Ask a user for input
-- Test the number if it's large or small
DECLARE
    vNumber BINARY_INTEGER;
BEGIN
    -- get a number from the user
    vNumber := TO_NUMBER('&Enter_a_number');
    IF vNumber < 5 THEN
        --small number
        DBMS_OUTPUT.PUT_LINE('Number is small');
    ELSE
        -- large number
        DBMS_OUTPUT.PUT_LINE('Number is large');
    END IF;
END;

-- Example 2 if a number is even, odd small, or odd large
DECLARE 
    vNumber BINARY_INTEGER;
BEGIN
    -- get a number
    vNumber := TO_NUMBER('&Enter_a_number');
    -- check if it's even
    IF MOD(vNumber, 2) = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Number is even');
    ELSIF vNumber < 5 THEN
        DBMS_OUTPUT.PUT_LINE('Number is small and odd');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Number is large and odd');
    END IF;
END;


-- Example 3
-- Create 2 variables, read in values for them.
-- if variable a is 100 and b is 200, output a message
-- if variable a is 100 and b is not 200, output a message
-- use a nested if
-- try outputting variable values

DECLARE
    varA BINARY_INTEGER;
    varB BINARY_INTEGER;
BEGIN
    varA := TO_NUMBER('&enter_a');
    varB := TO_NUMBER('&enter_b');
    IF (varA = 100) THEN
        IF (varB = 200) THEN
            DBMS_OUTPUT.PUT_LINE('Value of a is 100, b is 200');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Value of a is 100, b is not 200');
        END IF;
    END IF;
    -- no special message if a is not 100
    -- show their values
    DBMS_OUTPUT.PUT_LINE('Value of a is ' || varA || ' and b is ' || varB);
END;
    
	
-- Example 4
-- Get a grade, output message based on input
DECLARE
    grade VARCHAR2(1) := UPPER('&grade');
BEGIN
    CASE grade
        WHEN 'A' THEN DBMS_OUTPUT.PUT_LINE('Excellent');
        WHEN 'B' THEN DBMS_OUTPUT.PUT_LINE('Very Good');
        WHEN 'C' THEN DBMS_OUTPUT.PUT_LINE('Good');
        WHEN 'D' THEN DBMS_OUTPUT.PUT_LINE('Fair');
        WHEN 'F' THEN DBMS_OUTPUT.PUT_LINE('Poor');
        ELSE DBMS_OUTPUT.PUT_LINE('Invalid Grade entered');
    END CASE;
END;

-- Looping 
-- Example 5
-- Set a value to 10, output the value and add 10, keep going until > 50
DECLARE
    x NUMBER := 10;
BEGIN
    -- loop until greater than 50
    LOOP
        DBMS_OUTPUT.PUT_LINE(x);
        x := x + 10; -- increment
        EXIT WHEN x > 50;
    END LOOP;
END;

-- Example 6
-- Same as Ex5, but use WHILE
DECLARE
    x NUMBER := 10;
BEGIN
    -- loop until greater than 50
    WHILE x <= 50 LOOP
        DBMS_OUTPUT.PUT_LINE(x);
        x := x + 10; -- increment
    END LOOP;
    --after exit, display the final value
    DBMS_OUTPUT.PUT_LINE('After Loop: ' || x);
END;

-- Example 7
-- Same same, using FOR
DECLARE
    x NUMBER := 10;
BEGIN
    -- loop until greater than 50
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(x || ' in iteration ' || i);
        x := x + 10; --increment
    END LOOP;
    -- after exit, display final value
    DBMS_OUTPUT.PUT_LINE('After loop: ' || x);
END;

-- Example 8: Nested blocks and nested loops
-- NOTE: a nested loop doesn't have to be in another block
-- two variables, x and counter, will loop 4 times in the outer block
-- inner block has a variable named x, do some more loops
DECLARE
    x NUMBER := 0;
    counter NUMBER := 0;
BEGIN
    FOR i IN 1..4 LOOP
        x := x + 1000;
        counter := counter + 1;
        DBMS_OUTPUT.PUT_LINE('x = ' || x || ' counter = ' || counter || ' in outer block');
        DECLARE
            x NUMBER := 0;
        BEGIN
            FOR i IN 1..4 LOOP
                x := x + 1;
                counter := counter + 1;
                DBMS_OUTPUT.PUT_LINE('x = ' || x || ' counter = ' || counter || ' in inner block');
            END LOOP;
        END;    
    END LOOP;
END;