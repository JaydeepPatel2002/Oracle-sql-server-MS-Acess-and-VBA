/*
Example 1:
The below PL/SQL Block, the price of books in the "Title" table are updated.
If none of the prices are updated, we get a message 'None of the prices were 
updated'.  
Else, we get a message like 'Prices for 1000 books are updated' if there are 1000
rows in the Title table.
*/
DECLARE
    var_rows NUMBER(5);
BEGIN
    -- Run SQL statement to update the price of books.
    UPDATE Title
        SET price = price + 100;
        --WHERE price > 1000;
    
    -- Check to see if any prices were updated (ie: use FOUND or NOTFOUND)
    IF SQL%NOTFOUND THEN
        dbms_output.put_line('None of the books were updated');
    ELSE
        -- Found out how many rows were returned
        var_rows := SQL%ROWCOUNT;
        dbms_output.put_line('Prices for ' || var_rows || ' books are updated');
    END IF;
END;


/*
Explicit Example 1:
In the below example, first we are creating a record 'title_rec' of the same
structure as the table 'title' in line no2.  We can also create a record with a
cursor by replacing the table name with the cursor name.
Second, we are declaring a cursor 'title_cur' from a select query in lines 3-6.
Third, we are opening the cursor in the execution section in line no 8.
Fourth, we are fetch the cursor to the record in line no 9.
Fifth, we are displaying the title and price of the book in the record title_rec
in line no 10.
Sixth, we are closing the cursor in line no 11.
*/
DECLARE
    -- make a record and assign it to be a copy of the title table
    title_rec title%ROWTYPE;
    -- create a cursor to hold all the records from title where the prices is 
    -- greater than 30.
    CURSOR title_cur IS
        SELECT *
        FROM TITLE
        WHERE Price > 30;
BEGIN
    -- open the cursor, load it with records
    OPEN title_cur;
    -- NOTE: Don't use a cursor if you know you will only ever get one row back.
    LOOP
        -- exit when there are no more records in the cursor
        EXIT WHEN title_cur%NOTFOUND;
        -- point to the next row and put it into our record
        FETCH title_cur INTO title_rec;
        dbms_output.put_line('ID: ' || title_cur%ROWCOUNT || ' TITLE: ' || title_rec.title || ' PRICE: ' 
            || title_rec.price);            
    END LOOP;
    -- close the cursor
    CLOSE title_cur;
END;


/*
Modify the previous example to use a while loop
*/
DECLARE
    CURSOR title_cur IS
        SELECT title, price FROM TITLE;
    title_rec title_cur%ROWTYPE;
BEGIN
    OPEN title_cur;
    FETCH title_cur INTO title_rec;
    WHILE title_cur%FOUND
    LOOP
        dbms_output.put_line(title_rec.title || ' ' || title_rec.price);
        FETCH title_cur INTO title_rec;
    END LOOP;
    CLOSE title_cur;
END;

/*
We are using %FOUND attribute to evaluate if the fetch statement returned a row.
If it did, it continues to loop
If it did not, the loop is terminated.
NOTICE: we have 2 fetch statements.  One bound within the loop, the other is 
to load our initial data
*/

/* Example 3:
In the above example, when the FOR loop is processed a record 'title_rec' structure
'title_cur' gets created, the cursor is opened, the rows are fetched to the record
'title_rec' and the cursor is closed after the last row is processed.
By using FOR loop in our program, we can reduce the number of lines in the program
*/
DECLARE
    CURSOR title_cur IS
        SELECT title, price FROM Title;
    title_rec title_cur%ROWTYPE;
BEGIN
    -- for all records in the cursor, print the title and price
    FOR title_rec IN title_cur
    LOOP
        dbms_output.put_line(title_rec.title || ' ' || title_rec.price);
    END LOOP;
END;

