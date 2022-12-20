/*Example 1 - Stored Procs
NOTE: A stored proc can basically be like everything we've been creating in an anonyous
block.
1. Create a procedure for priting out all the book titles in the titles table.
2. Run the procedure.  
NOTICE:  In the connections panel in SQL Developer, there is an area for procedures.
Once you run the code below, a new procedure will be created and will be accessible
under the Procedure area to run as often as you like.  You can do this by right-clicking
on the procedure name and choosing "Run"
*You can also edit in this way as well
*/
CREATE OR REPLACE PROCEDURE title_details_proc
IS
    -- create a cursor for the title and price from the title table
    CURSOR title_cur IS
        SELECT title, price FROM title;
BEGIN
    FOR title_rec IN title_cur LOOP
        dbms_output.put_line(title_rec.title || ' ' || title_rec.price);
    END LOOP;
END;
