/* EXAMPLE 1: Functions
NOTE: A function can basically be like everything we've been creating in an
anonymous code block, but you now have the ability to pass in variables and you
MUST return a value.
1. Create a function that will return the title name for only one book (hard code
the book id into the function)
2. Call the function.  NOTICE: In SQL Developer, there is an area for functions.  Your
function should be displayed once the code below is executed.  You can run and edit
*/
CREATE OR REPLACE FUNCTION title_func
    RETURN VARCHAR2
IS
    title_name VARCHAR2(80);
BEGIN
    -- put into title_name the title of the book with id PC8888
    SELECT title INTO title_name
    FROM Title WHERE titleid = 'PC8888';
    
    RETURN title_name;
END;

-- to execute:
BEGIN
    dbms_output.put_line(title_func);
END;

/* EXAMPLE 2
Modify example 1, and this time let's pass in the id for the book.
*/
CREATE OR REPLACE FUNCTION title_func2
    (bookid IN CHAR)
    RETURN VARCHAR2
IS
    title_name VARCHAR2(80);
BEGIN
    -- put into title_name the title of the book for the corresponding id
    SELECT title INTO title_name
    FROM Title
    WHERE titleid = bookid;
    
    RETURN title_name;
END;

-- To execute:
BEGIN
    dbms_output.put_line(title_func2('TC3218'));
END;
/  
-- you can use a forward slash to tell Oracle you have no more PL/SQL code
select * from title;

