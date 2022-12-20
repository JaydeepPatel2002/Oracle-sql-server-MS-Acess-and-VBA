/*
Example 1: Let's solve a problem where we to throw an error if we attempt
to divide a number by zero
*/
DECLARE
    stock_price NUMBER := 9.73;
    net_earnings NUMBER := 0;
    pe_ratio NUMBER;
BEGIN
    -- Calculation might cause division-by-zero error.
    pe_ratio := stock_price / net_earnings;
    dbms_output.put_line('Price/earnings ratio = ' || pe_ratio);
EXCEPTION
    -- Only one of the WHEN blocks is executed.
    WHEN ZERO_DIVIDE THEN 
        dbms_output.put_line('Company must have had zero earnings');
        pe_ratio := null;
    
    WHEN OTHERS THEN
        dbms_output.put_line('Some other kind of error occurred');
        pe_ratio := null;
END;

SET SERVEROUTPUT ON;
/* Example 2 - Using an unamed systems exception
Let's consider the publisher table and title table with SQL joins.
Here, pubid is the priary key in the publisher table and a foreign key in the 
title table.
If we try to delete a pubid from the publisher table when it has a child record
in the title table, an exception is thrown with oracle code number -2292.
We can provide a name to this exception and handle it in the exception section
1. Delcare the exception
2. Delete a record from the publisher table
    a. Attempt it with the record that has a child in the title table
        pubid=1389
    b. Attemp it with a record that doesn't have a child in the title table
        pubid=300
3. In the Exception area of the code block, look for the exception that you declared
and print to the screen "Child records are present for this pub id".

-- NOTE: Make sure you've added the SaskPoly Publisher from the past example.
*/
DECLARE
    Child_rec_exception EXCEPTION;
    -- Give the error number a name
    PRAGMA
        EXCEPTION_INIT(Child_rec_exception, -2292);
BEGIN
    DELETE FROM Publisher WHERE pubid=1389;
    -- pubid=300 for a publisher without child records
    -- pubid=1389 for a publisher with child records
EXCEPTION
    WHEN Child_rec_exception THEN
        DBMS_output.put_line('Child records are present for this publisher id');
END;

/*
Let's consider the salesdetail and title tables from sql joins to explain
user-defined exceptions.  Let's create a business rule that if the total number
of units of any particular book sold is more than 50, then it is a huge quantity
and a special discount should be provided.  We should stop processing and exit the
program if this is the case.
1. Declare our exception and any vairables, cursors, and constants that we need.
For each sale, if there has been more than 50 books sold - throw an exception
stating 'The number shipped of: <book title> is at least 50.  Special discounts
should be provided.  Skipping the remaining records'.
3. If there hasn't been more than 50 books sold, print out to the screen that
'The number of books is below the discount limit'.
*/
DECLARE
    huge_quantity EXCEPTION;  -- declare your exception
    
    CURSOR sales_quantity IS
        SELECT salesdetail.qtyshipped, title.title
        FROM salesdetail, title
        WHERE salesdetail.titleid = title.titleid  ;
        -- cursor with 2 columns
    quantity salesdetail.qtyshipped%TYPE; -- 
    up_limit CONSTANT salesdetail.qtyshipped%TYPE := 50;
    message VARCHAR2(150); -- holds our error message
BEGIN
    -- if the # of sales is greater than 50, we are going to the set the error
    -- message and raise an error because we want to stop processing (BR)
    -- FOR each of the records in our sales_quantity cursor
    FOR sales_rec in sales_quantity LOOP
        quantity := sales_rec.qtyshipped;
        IF quantity > up_limit THEN
            message := 'The number shipped of: ' || sales_rec.title ||
                ' is at least 50.  Special discounts should be provided.
                Skipping remaining records';
            RAISE huge_quantity; -- call your exception
        -- Otherwise, the number of books is below our threshold
        ELSIF quantity < up_limit THEN
            message := 'The number of books is below the discount limit.';
        END IF;
        dbms_output.put_line(message);
    END LOOP;
    EXCEPTION
        WHEN huge_quantity THEN
            dbms_output.put_line(message);
END;


/* Example 4
Modify the example 3 slightly so we can display an error message using
RAISE_APPLICATION_ERROR
*/
DECLARE
    huge_quantity EXCEPTION;  -- declare your exception
    
    CURSOR sales_quantity IS
        SELECT salesdetail.qtyshipped, title.title
        FROM salesdetail, title
        WHERE salesdetail.titleid = title.titleid  ;
        -- cursor with 2 columns
    quantity salesdetail.qtyshipped%TYPE; -- 
    up_limit CONSTANT salesdetail.qtyshipped%TYPE := 50;
    message VARCHAR2(150); -- holds our error message
BEGIN
    -- if the # of sales is greater than 50, we are going to the set the error
    -- message and raise an error because we want to stop processing (BR)
    -- FOR each of the records in our sales_quantity cursor
    FOR sales_rec in sales_quantity LOOP
        quantity := sales_rec.qtyshipped;
        IF quantity > up_limit THEN
            RAISE huge_quantity; -- call your exception
        -- Otherwise, the number of books is below our threshold
        ELSIF quantity < up_limit THEN
            message := 'The number of books is below the discount limit.';
        END IF;
        dbms_output.put_line(message);
    END LOOP;
    EXCEPTION
        WHEN huge_quantity THEN
            RAISE_APPLICATION_ERROR(-20000, 'The number of units is above the discount limit.');
END;