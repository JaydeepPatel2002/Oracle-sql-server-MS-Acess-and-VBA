/* PL SQL Exercise 3, Question 1 - Report
*/
DECLARE
    -- Declared the publisher cursor and the record variable
    CURSOR c_publisher IS
        SELECT * FROM Publisher ORDER BY pubname;
    rec_publisher Publisher%ROWTYPE;
    
    -- Declared the title cursor and the record variable, notice the input variable
    CURSOR c_title (param_publisher Publisher.pubid%TYPE) IS
        SELECT * FROM Title WHERE pubid = param_publisher;    
    rec_title Title%ROWTYPE;
    
    v_price Title.Price%TYPE;
BEGIN
    OPEN c_publisher;
    LOOP
        FETCH c_publisher INTO rec_publisher;
            EXIT WHEN c_publisher%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('--------------------------------------');
            DBMS_OUTPUT.PUT_LINE('Publisher: ' || rec_publisher.pubname);
            DBMS_OUTPUT.PUT_LINE('--------------------------------------');
            OPEN c_title(rec_publisher.pubid);
            LOOP
                FETCH c_title INTO rec_title;
                    EXIT WHEN c_title%NOTFOUND;
                    DBMS_OUTPUT.PUT_LINE('BOOK: ' || rec_title.titleid || ' ' || rec_title.title);
            END LOOP;
            CLOSE c_title;
            -- We still have the publisher record, let's use it to compute the price sum
            SELECT SUM(Price) INTO v_price FROM Title
            WHERE pubid = rec_publisher.pubid;
            
            DBMS_OUTPUT.PUT_LINE('TOTAL PRICE FOR ALL BOOKS: ' || v_price);            
    END LOOP;
    CLOSE c_publisher;
END;
/
/*
2. Create a procedure
a. pass in a first name and a last name of an editor
b. If the editor already exists print the editor’s id
c. Otherwise insert the editor into the database.
*/

CREATE OR REPLACE PROCEDURE PrintEditor (fname_in IN VARCHAR2, lname_in IN VARCHAR2)
IS
    enumber NUMBER;
    CURSOR c1 IS
        SELECT edId FROM Editor
        WHERE edlname = lname_in AND edfname = fname_in;
    
    rec_1 Editor.edid%TYPE;
BEGIN
    OPEN c1;
        FETCH c1 into rec_1;
        IF c1%FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Editor ID: ' || rec_1);
        ELSE
            enumber := 9999;
            INSERT INTO Editor (edid, edlname, edfname)
            VALUES(enumber, lname_in, fname_in);
        END IF;
    CLOSE c1;
END;
/
BEGIN
    PrintEditor('Joseph', 'Herbert');    
END;
/
SELECT * FROM EDITOR;
/
/*
3. Create a function
a. You should pass to the function the first and last names of an editor
b. If the editor is found, return the editor’s id, otherwise return a value of 8888
*/
CREATE OR REPLACE FUNCTION FindEditor
    (fname_in IN VARCHAR2, lname_in IN VARCHAR2)
    RETURN NUMBER
IS
    enumber NUMBER;
    CURSOR C1 IS
        SELECT edid FROM Editor
        WHERE edlname = lname_in AND edfname = fname_in;
BEGIN
    OPEN C1;
        FETCH C1 INTO enumber;
        
        IF C1%NOTFOUND THEN
            enumber := 8888;
        END IF;
    CLOSE C1;
    
    RETURN enumber;
    
    EXCEPTION
        WHEN OTHERS THEN
            raise_application_error(-20001, 'An error was encountered - ' 
                || SQLCODE || ' -ERROR- ' || SQLERRM);
END;
/

DECLARE
    enum NUMBER;
BEGIN
    enum := FindEditor('asdfasdf', 'fdasfdas');
    DBMS_OUTPUT.PUT_LINE('id number: ' || enum);
END;
/
DECLARE
    enum NUMBER;
BEGIN
    enum := FindEditor('Joe', 'Herbert');
    DBMS_OUTPUT.PUT_LINE('id number: ' || enum);
END;
/
/
/*
Create a trigger that fires on the title table
It should fire when:
- There is an insert
- The price is updated
- The title is updated
- A row is deleted
* Print to screen what has happened
*/
CREATE OR REPLACE TRIGGER TitleTrig
    BEFORE
        INSERT OR
        UPDATE OF price, title OR
        DELETE
    ON Title
    BEGIN
        CASE
            WHEN INSERTING THEN
                DBMS_OUTPUT.PUT_LINE('Inserting');
            WHEN UPDATING('price') THEN
                DBMS_OUTPUT.PUT_LINE('Updating Price');
            WHEN UPDATING('title') THEN
                DBMS_OUTPUT.PUT_LINE('Updating Title');
            WHEN DELETING THEN
                DBMS_OUTPUT.PUT_LINE('Deleting');
        END CASE;
    END;
/
INSERT INTO Title
VALUES('TX9999', 'My Book', 'science', '0736', 300, 40000, 30000, 1, 'some notes', sysdate);

UPDATE Title SET PRICE=250 WHERE TitleID='TX9999';
UPDATE Title SET title='My second book' WHERE TItleID='TX9999';

DELETE FROM Title WHERE TitleID='TX9999';