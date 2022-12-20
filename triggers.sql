/*We can create a trigger to update the 'title_price_history' table when the price
of the product is updated in the 'title' table.

1) Create the 'title_price_history' table
*/
CREATE TABLE title_price_history
(title_id char(6),
title_name varchar2(80),
publisher_id char(4),
price number(9,2)
);
/
--2) Create the price_history_tigger and execute it.
CREATE OR REPLACE TRIGGER price_history_trigger
    -- before the price of a title is updated, run the trigger
    BEFORE UPDATE OF price
    ON Title
    -- run the trigger for each row that is updated
    FOR EACH ROW
    BEGIN
        -- insert into the history table the old values for each column
        INSERT INTO title_price_history
        VALUES
        (:old.titleid, 
        :old.title,
        :old.pubid,
        :old.price);
    END;
/
select * from title;
--PS7777	Emotional Security: A New Algorithm	psychology  	0736	17.99
UPDATE title SET price = 28 WHERE titleid='PS7777';
-- here we can see a new record have been entered.
select * from Title_price_history;

/* Once the above update query is executed, the trigger fires and updates the 
'title_price_history' table.  

4) If we ROLLBACK the transaction before committing to the database, the data inserted
is ALSO rolled back.
For example, let's create a table 'trigger_messages' which we can use to store messages
when triggers are fired.
*/
CREATE TABLE trigger_messages
(Message varchar2(50),
Current_Date date);

/* Let's create a BEFORE and AFTER statement and row-level triggers for the title table
1) BEFORE UPDATE, Statement Level:  This trigger will insert a record into the table
'trigger_messages' before the sql update statement is executed, at the statement level.
*/
CREATE OR REPLACE TRIGGER Before_Update_State_title
    BEFORE
    UPDATE ON Title
BEGIN
    -- sysdate is the current system date.
    INSERT INTO trigger_messages
    VALUES ('Before update, statement level', sysdate);
END;
/

/*
2) BEFORE UPDATE, Row-level: This trigger will insert a record into the table
'trigger_messages' before EACH ROW is updated
*/
CREATE OR REPLACE TRIGGER Before_Update_Row_title
    BEFORE
    UPDATE ON Title
    FOR EACH ROW
    BEGIN
        INSERT INTO trigger_messages
        VALUES('Before update, row level', sysdate);
    END;
/
/* 
3) AFTER UPDATE, Statement Level:  This trigger will insert a record into the table
'trigger_messages' after a SQL UPDATE statement is executed, at the statement level
*/
-- Since it's statement level, it will run one time -> After the title table is updated
CREATE OR REPLACE TRIGGER After_Update_Stat_Title
    AFTER
    UPDATE ON Title
    BEGIN
        INSERT INTO trigger_messages
        VALUES('After update, statement level', sysdate);
    END;
/
/*
4) AFTER UPDATE, Row Level:  This trigger will insert a record into the table
'trigger_messages' after EACH ROW is updated.
*/
-- Since its row-level, this trigger will fire for each record that is updated, but AFTER
--the update
CREATE OR REPLACE TRIGGER After_Update_Row_Title
    AFTER
    UPDATE ON Title
    FOR EACH ROW
    BEGIN
        INSERT INTO trigger_messages
        VALUES('After update, Row level', sysdate);
    END;
/
SELECT * FROM trigger_messages;

UPDATE Title SET price = 80
WHERE TitleID IN ('PS3333', 'BU1111');

SELECT * FROM trigger_messages;

/*
You should have 6 records in your trigger_messages table.
The results show 'before update' and 'after update' row-level event occurred twice,
since two records in total were updated.  The 'before update' and 'after update'
statement level events are fired only once per SQL statment.
The above rules apply in a similar manner to INSERT and DELETE statements
*/

/*
Create a trigger that fires on the title table:
It should fire:
1.a There is an insert
1.b The price is updated
*/
/*
Run the trigger at the statement level because the assumption is that the user will
only enter one statement at a time.  Run it when there is an insert or update
*/
CREATE OR REPLACE TRIGGER title_trig
    BEFORE 
        INSERT OR
        UPDATE OF Price
    ON Title
    BEGIN
        -- you can tell what type of sql statement (insert, update, delete) by
        -- using a CASE statement with keywords INSERTING, UPDATING, DELETING
        CASE
            WHEN INSERTING THEN
                DBMS_OUTPUT.PUT_LINE('Inserting');
            WHEN UPDATING('price') THEN
                DBMS_OUTPUT.PUT_LINE('Updating price');
        END CASE;
    END;
/
INSERT INTO Title
VALUES('TL9999', 'My Book', 'science', '0736', 300, 40000, 30000, 1, 'Some notes', sysdate);

UPDATE Title SET PRICE=250 WHERE TitleID='TL9999';
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
