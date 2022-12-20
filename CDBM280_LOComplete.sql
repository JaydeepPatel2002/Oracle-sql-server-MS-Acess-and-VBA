-- Write a query to display the names of authors (auFName, auLName)
-- who live in Oakland CA and their books (titleid, title)
SELECT auFName, auLName, t.titleID, title
FROM Author A
    JOIN TitleAuthor TA ON TA.auid = a.auid
    JOIN Title T ON T.titleID = TA.titleID
WHERE city = 'Oakland' AND state = 'CA';

-- Make a view out of it:
CREATE OR REPLACE VIEW Oaklander (fname, lname, tid, title) AS
SELECT auFName, auLName, t.titleID, title
FROM Author A
    JOIN TitleAuthor TA ON TA.auid = a.auid
    JOIN Title T ON T.titleID = TA.titleID
WHERE city = 'Oakland' AND state = 'CA';

-- using the view:
SELECT * FROM Oaklander;
SELECT * FROM Oaklander ORDER BY title;

-- Use the view to show the author's last name for authors with more than 1 book.
SELECT lname, COUNT(*)
FROM Oaklander
GROUP BY lname HAVING COUNT(*) > 1;

-- Changing data through a view
CREATE OR REPLACE VIEW HighPrice AS
    SELECT * FROM title WHERE price > 15 AND advance > 5000;

-- Take a look at PC8888 and note the price
SELECT * FROM HighPrice;
-- We'll call UPDATE on the view and provide a key
UPDATE HighPrice SET Price = 10 WHERE titleID='PC8888';
-- That title no longer satifies the query condition on the view
SELECT * FROM HighPrice;
-- We can see that the actual price has been changed in the Title table
SELECT * FROM Title;

-- the WITH CHECK OPTION prevents updates from "hiding" rows from the view
CREATE OR REPLACE VIEW HighPrice AS
    SELECT * FROM title WHERE price > 15 AND advance > 5000
WITH CHECK OPTION;

SELECT * FROM HighPrice;
UPDATE HighPrice SET price = 10 WHERE TitleID = 'TC7777';

DROP VIEW Oaklander;
DROP VIEW HighPrice;

-- Determining the updateability of views
CREATE OR REPLACE VIEW RoyaltyAmt AS
SELECT a.auid, aulname, aufname, royaltyshare, t.titleid, title, price, royalty, 
    price * royalty * royaltyshare AS amount
FROM Author A 
    JOIN TitleAuthor TA ON A.auid = TA.auid
    JOIN TItle T ON T.titleid = TA.titleid
    JOIN RoySched R ON T.titleid = R.titleid;

SELECT * FROM RoyaltyAmt;
-- Can we make changes?
DELETE FROM RoyaltyAmt;
-- NO - there isn't just one key preserved table.

-- Another example
CREATE VIEW CurrentInfo AS
    SELECT p.pubid, pubname, SUM(ytdsales) AS revenue, AVG(ytdsales) AS avgsales
    FROM Publisher P 
        JOIN Title T ON P.pubid = T.pubid
        GROUP BY p.pubid, pubname;

SELECT * FROM CurrentInfo;
-- See if we can make changes:
DELETE FROM CurrentInfo;
UPDATE CurrentInfo SET pubname = 'AAA';
-- Both changes above do not work.  Aggregates and grouping prevent updates to the view.

CREATE OR REPLACE VIEW Oaklanders
AS
SELECT auFName AS First, auLName AS Last, t.titleID, title
FROM Author a JOIN TitleAuthor ta ON a.auID = ta.auID
	JOIN Title t ON ta.titleID = t.titleID
WHERE city = 'Oakland'
	AND state = 'CA';

CREATE TABLE AuthorTest AS
    SELECT AUID, AULNAME, AUFNAME, PHONE, ADDRESS, CITY, STATE, ZIP
    FROM Author;

DELETE FROM AuthorTest
WHERE AUFNAME like 'A%';

SELECT * 
FROM AUTHORTEST;

-- View on a single table
CREATE OR REPLACE VIEW V1 AS
    SELECT aulname, aufname, phone
    FROM Author WHERE zip LIKE '94%';
    
SELECT * FROM V1;
-- Key-preserved table is Author (only table in view, no grouping, aggregates, etc)
-- INSERT, UPDATE, DELETE?
UPDATE V1 SET aufname = 'Abe' WHERE aufname = 'Abraham';
SELECT * FROM AUTHOR;
-- Updates are allowed on the columns visible by the view.  But this won't work:
UPDATE V1 SET city = 'Regina' WHERE aufname = 'Abe';
-- Deletes:
DELETE FROM V1;
-- Deletes do work, but referential integrity is still enforced, can't delete parent
-- records with children
-- INSERTS:
INSERT INTO V1 VALUES ('Herbert', 'Joe', '94444');
-- Not all of the NOT NULL / PK Columns are in the view, we can't insert using it.

-- CREATe a view based on another view
CREATE OR REPLACE VIEW V2 AS
    SELECT aulname, phone FROM V1 WHERE aulname > 'M';
    
SELECT * FROM V1;
SELECT * FROM V2;
DELETE FROM V2;
-- Works, again the referential integrity still in place.
-- Inserts still don't work, missing PK.
-- Updates can be done on the two columns.

-- Another Layer:
CREATE OR REPLACE VIEW V3 AS
    SELECT aulname, phone, 'Another View' As Expression FROM V2
        WHERE aulname = 'MacFeather';

SELECT * FROM V3;
UPDATE V3 SET PHONE = '1234';
SELECT * FROM Author WHERE aulname = 'MacFeather';
-- Updated just fine
-- Try another update:

UPDATE V3 SET Expression = 'Hello';
-- Can't change the calculated field.


