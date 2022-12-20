-- basic selects
SELECT * FROM PROJECT;
SELECT maxHours, prjName FROM PROJECT;
SELECT department FROM Project;
-- Distinct will remove duplicate results
SELECT DISTINCT department FROM Project;
SELECT DISTINCT department, maxhours FROM PROJECT;

-- basic where
-- display projects from the finance department
SELECT * FROM Project WHERE department = 'Finance';
SELECT * FROM Project WHERE maxHours > 100;

-- boolean operators
-- combine the last two expressions
SELECT * FROM Project WHERE (department = 'Finance') AND (maxHours > 100);

-- All employees from accounting, marketing, or finance
SELECT * FROM Employee WHERE department IN ('Marketing', 'Accounting', 'Finance');
-- vs the opposite
SELECT * FROM Employee WHERE department NOT IN ('Marketing', 'Accounting', 'Finance');

-- between
SELECT empNumber, empName, department FROM EMPLOYEE
WHERE empNumber BETWEEN 200 AND 500;
-- equivalent to:
SELECT empNumber, empName, department FROM EMPLOYEE
WHERE empNumber >= 200 AND empNumber <=500;

-- Like is used to compare against a pattern
SELECT * FROM Project WHERE prjName LIKE 'Q_ Portfolio Analysis';
SELECT * FROM Employee WHERE phone LIKE '285-____';
SELECT * FROM Employee WHERE phone LIKE '285-%';

-- Compare nulls
SELECT empName, phone FROM Employee WHERE phone IS NULL;
SELECT empName, phone FROM Employee WHERE phone IS NOT NULL;

-- expression in list
SELECT projectID, prjName, maxHours FROM Project;
SELECT projectID, prjName, maxHours * 1.1 FROM Project;
SELECT projectID, prjName, maxHours * 1.1 AS "Proposed Maximum" FROM Project;
SELECT projectID, prjName, maxHours * 1.1 AS Proposed_Maximum FROM Project;

-- Display employee names in the form of Name: Department
SELECT empName || ': ' || department AS EmployeeInfo FROM Employee;

-- Sorting
SELECT empName, department FROM Employee ORDER BY department;
SELECT empName, department FROM Employee ORDER BY department DESC;
SELECT empName, department FROM Employee ORDER BY department, empName DESC;
-- VS
SELECT empName, department FROM Employee ORDER BY empName DESC, department;

-- Single Row Functions
-- Dual is a special table that exists to run queries against as the FROM clause
-- is required.  It has one row and one column.
SELECT * FROM Dual;
SELECT CEIL(6.7) FROM Dual;
SELECT FLOOR (6.7) FROM Dual;
SELECT ROUND(6.39232) FROM Dual;
SELECT ROUND(6.39232, 3) FROM Dual;

-- string functions
SELECT empName FROM Employee;
SELECT UPPER(empName) FROM Employee;
SELECT RPAD(empName, 20) FROM Employee;
SELECT RPAD(empName, 20, '/*') FROM Employee;

-- LTRIM, RTRIM, and TRIM (combines the other 2)
SELECT LTRIM ('           test           ') FROM Dual;
SELECT TRIM ('           test           ') AS "A" FROM Dual;
SELECT LTRIM('ababtestabab', 'ab') FROM Dual;
SELECT LTRIM(RTRIM('ababtestabab', 'ab'), 'ab') AS "A" FROM Dual;

-- substr (first character is 1, not 0)
SELECT SUBSTR('abcdefghijk', 4, 4) FROM Dual;

-- Date functions
SELECT SYSDATE FROM Dual;
SELECT TO_CHAR(SYSDATE, 'hh:mi:ss') FROM Dual;
SELECT MONTHS_BETWEEN(SYSDATE, '24-OCT-27') FROM Dual;

SELECT TO_CHAR(5.5) FROM Dual;
SELECT TO_DATE('October 1 2022', 'Month dd yyyy') FROM Dual;

SELECT TO_NUMBER('40') FROM Dual;

-- NULL values examples
SELECT * FROM Title;
SELECT Title, Type FROM Title;
SELECT Title, NVL(Type, 'Missing Title') As NNType FROM Title; --Oracle only
SELECT Title, COALESCE(Type, 'Missing Title') As NNType FROM TITLE;

-- User function
SELECT USER FROM Dual;

-- Aggregates
SELECT * FROM Title;
SELECT SUM(Price) FROM Title;
-- Display an aggregate result in a certain format:
SELECT TO_CHAR(SUM(Price), '$999,999,999.99') FROM Title;

SELECT MAX(Price), MIN(Price), AVG(Price) FROM Title;
-- error out:
SELECT Title, MAX(Price), MIN(Price), AVG(Price) FROM Title;

-- Count types
SELECT COUNT(Price) FROM Title;  -- ignore nulls
SELECT COUNT(*) FROM Title; -- doesn't ignore nulls
SELECT COUNT(DISTINCT Price) FROM Title; -- count unique price values, ignore nulls
SELECT COUNT(NVL(Price, 0)) FROM Title; -- will count null values, really the same as COUNT(*)
SELECT COUNT(DISTINCT NVL(Price, 0)) FROM Title; -- will count nulls, because they are counted as 0

-- Average should usually deal with nulls if they exist in data.
-- Compare:
SELECT AVG(Price) FROM Title;
-- to:
SELECT AVG(NVL(Price,0)) FROM Title;

-- Group By and Having Clauses
SELECT Type, AVG(Price) FROM Title GROUP BY Type;
SELECT Type, AVG(Price) FROM Title GROUP BY Type ORDER BY Type;

-- Compare:
SELECT PubID FROM Title GROUP BY PubID;
-- to:
SELECT DISTINCT PubID FROM Title;
-- no grouping, same results, but aggregates are not possible:
-- SELECT DISTINCT PubID, AVG(Price) FROM Title;  <-- error out

-- Multiple group by fields
SELECT PubID, Type, MAX(Price) FROM Title GROUP BY PubID, Type;
-- same results, unique combo for group by fields
SELECT PubID, Type, MAX(Price) FROM Title GROUP BY Type, PubID;

-- Let's add some COUNT examples
-- Count all the authors in each city and state.  Display city, state, and the count
SELECT City, State, COUNT(*) 
    FROM Author 
    GROUP BY City, State 
    ORDER BY State, City;
-- Ignore cities with only one author
SELECT City, State, COUNT(*)
    FROM Author
    GROUP BY City, State
    HAVING COUNT(*) > 1;
-- Ignore cities with only one author, and NOT in CA
SELECT City, State, COUNT(*)
    FROM Author
    GROUP BY City, State
    HAVING COUNT(*) > 1 AND NOT State = 'CA'; -- instead of NOT, can use <>
-- This is an inefficient query.  
-- Should put the state = 'CA' in a WHERE Clause
SELECT City, State, COUNT(*)
    FROM Author
    WHERE State <> 'CA'
    GROUP BY City, State
    HAVING COUNT(*) > 1;
-- Here, we are reducing the size of the result set that is selected before
-- Grouping it.  Of course, for 18 records, no change is noticable.
-- BUT, for large tables, this could save minutes or hours from our query execution

-- Show information about types that have a total ytdsales > 15000.
-- This should include the average price and Type fields.  Include nulls as zeroes
-- in your average
SELECT Type, AVG(NVL(Price, 0))
    FROM Title
    GROUP BY Type
    HAVING SUM(YTDSales) > 15000;
    
SELECT Type, AVG(NVL(Price, 0)), MAX(Price), MIN(NVL(Price, 0))
    FROM Title
    GROUP BY Type
    HAVING SUM(YTDSales) > 15000;
    
-- Aggregate expression can include normal calculations
SELECT SUM(ROUND(Price, 0)) FROM Title;


SELECT DISTINCT Price FROM Title;

-- JOINs
SELECT pubID, pubName FROM Publisher;
SELECT pubID, titleID, title FROM Title;

SELECT titleId, title, Title.pubId, pubName
FROM Title JOIN Publisher ON Title.pubID = Publisher.pubID;

-- Give tables aliases, shorten syntax
SELECT titleId, title, T.pubId, pubName
FROM Title T JOIN Publisher P ON T.pubId = P.pubId;

-- Add the authors of the books lname fname
SELECT T.titleId, title, T.pubId, pubName, auFName, auLName
FROM Title T    JOIN Publisher P ON T.pubID = P.pubID
                JOIN TitleAuthor TA ON TA.titleID = T.titleID
                JOIN Author A ON TA.auId = A.auId;
-- Here, in order to access Author names, we need to link Title with TitleAuthor
-- Afterwards, we can join the author to the titleauthor table.

-- Only show books with prices over $25 and sort on the tile of the book
SELECT T.titleId, title, T.pubId, pubName, auFName, auLName
FROM Title T    JOIN Publisher P ON T.pubID = P.pubID
                JOIN TitleAuthor TA ON TA.titleID = T.titleID
                JOIN Author A ON TA.auId = A.auId
WHERE T.price > 25
ORDER BY T.title;

-- Show book title, names of editors
-- Concatenate first and last name.
SELECT title, edFName || ' ' || edLName AS Edname
FROM Title T    JOIN TitleEditor TE ON T.titleId = TE.titleId
                JOIN Editor E ON TE.edId = E.edId;
                
-- Outer JOINS
SELECT * FROM Employee;
SELECT * FROM Project;
SELECT * FROM Assignment;

-- Show project, employee, hoursworked
SELECT empName, hoursWorked, prjName
FROM Employee E     JOIN Assignment A ON E.empNumber = A.empNumber
                    JOIN Project P ON P.projectId = A.projectID;
                    
-- Use an outer join to include any "missing" projects
SELECT empName, hoursWorked, prjName
FROM Employee E     JOIN Assignment A ON E.empNumber = A.empNumber
                    RIGHT JOIN Project P ON P.projectId = A.projectID;

-- What if we changed the order of the joins?
SELECT prjName, hoursWorked, empName
FROM Project P      LEFT JOIN Assignment A ON P.projectId = a.projectid
                    LEFT JOIN Employee E ON E.empNumber = A.empNumber;
                    
-- Show authors of books, include authors with no books
SELECT title, auFName, auLName
FROM Title T        JOIN TitleAuthor TA ON T.titleId = TA.titleId
                    RIGHT JOIN Author A ON A.auId = TA.auId
ORDER BY title;

-- Full JOIN
-- Add a title without a publisher and a publisher without a title
DESC Publisher;
INSERT INTO Publisher (pubID, pubName) VALUES (1000, 'New Pub');
DESC Title;
INSERT INTO Title (title, titleID, contract) VALUES ('New Book', 'AAAAAA', 'n');

SELECT pubName, title
FROM Title T        FULL JOIN Publisher P ON P.pubId = T.pubId;

-- What if we only want to see the things that don't match (on both sides)?
SELECT pubName, title
FROM Title T        FULL JOIN Publisher P ON T.pubId = P.pubId
WHERE pubName IS NULL OR title IS NULL;

-- Self Join
-- Show Editors and their bosses
DESC Editor;
SELECT E.edId, E.edFName, E.edLName, B.edId, B.edFName AS BossFN, B.edLName AS BossLN
FROM Editor E       JOIN Editor B ON E.edBoss = B.edId;

-- Include the editors without bosses as well
SELECT E.edId, E.edfname, E.edlname, B.edId, B.edfname, B.edlname
FROM Editor E       LEFT JOIN Editor B ON E.edboss = B.edId;

-- Joining on non-key field:
SELECT aulname, aufname, pubname, P.city, A.city
FROM Author A       JOIN Publisher P ON A.city=P.city;

SELECT A.aulname, A.aufname
FROM Author A       JOIN Author A2 ON A.aulname = A2.aulname
WHERE A.aufname <> A2.aufname;

--------------------------------------
-- Set Operators (UNION, INTERSECT, MINUS)
-- All authors and editors from Oakland.
-- returns 5 records
SELECT aufname AS "First Name", aulname AS "Last Name"
FROM Author 
WHERE city = 'Oakland'
UNION
-- returns 1 record
SELECT edfname, edlname
FROM Editor
WHERE city = 'Oakland'
ORDER BY 2;
-- UNION those two results sets returns 6 records

-- More complicated UNION.  We can have multiple "scenarios" and then combine
-- them into one result set
-- EX: Reduce the price of books, depending on the price of the book.
-- If price > 25, 30% off
-- If 15 <= price >= 25, 20% off
-- If price < 15, 10% off
SELECT * FROM Title;
SELECT '30% Off' AS Discount, title, price AS OldPrice, 
    price * 0.7 AS DiscountPrice
FROM Title
WHERE Price > 25
UNION
SELECT '20% Off' AS Discount, title, price AS OldPrice, 
    price * 0.8 AS DiscountPrice
FROM Title
WHERE Price BETWEEN 15 AND 25
UNION
SELECT '10% Off' AS Discount, title, price AS OldPrice, 
    price * 0.9 AS DiscountPrice
FROM Title
WHERE Price < 15;

-- INTERSECT - common rows / duplicates
SELECT city FROM Author
INTERSECT
SELECT city FROM Publisher;

-- MINUS - all rows from one that don't appear in the others
SELECT city FROM Author
MINUS
SELECT city FROM Publisher;

---------------------
-- Subqueries
/*
*   Example 0:
*   Find all the Authors that work in the same city as Livia Karsen
*   Steps:
*/
--a)  Find the city Livia works in:
SELECT city FROM Author WHERE aulname = 'Karsen';
--b) Send the name of the city to another query to find all the people who 
-- work in 'Oakland'
SELECT * FROM Author WHERE city = 'Oakland';
--c) Put the 2 together
SELECT * FROM Author
WHERE city = (SELECT city FROM Author WHERE aulname='Karsen');

-- Example 1
-- Find all books of type 'business'
SELECT * FROM Title WHERE type = 'business';
SELECT pubID FROM Title WHERE type = 'business';
-- Find the publisher information for pubID 1389 and 0736
SELECT * FROM Publisher WHERE pubID IN ('1389', '0736');
-- Combine them:
SELECT * FROM Publisher
WHERE pubID IN (SELECT pubID FROM Title WHERE type = 'business');

/* 
•	List the books published by Binnet & Hardley that have a year to date 
sales of more than $15,000.
•	Steps:
a)	Need to find Binnet & Hardley's pubID?
b)	Now use that in the main query
c)	Put the 2 together
*/
-- a)	Need to find Binnet & Hardley's pubID?
SELECT pubID FROM Publisher WHERE pubname = 'Binnet and Hardley';
--0877
-- b)	Now use that in the main query
SELECT title, ytdsales FROM Title WHERE ytdsales > 15000 AND pubID = '0877';
-- c)   Put the 2 together:
SELECT title, ytdsales
FROM Title
WHERE ytdsales > 15000 AND
    pubID = (SELECT pubID FROM Publisher WHERE pubname = 'Binnet and Hardley');

-- Example 3
-- •	List the books that have a price greater or equal to the price of the 
-- book Straight Talk About Computers  
-- a) Find the price of the book in question (BU7832)
SELECT price FROM Title WHERE TitleID = 'BU7832';
-- b) Use that price for your main query
SELECT Title, Price FROM Title WHERE Price >= 29.99;
-- c) Combine the 2
SELECT Title, Price
FROM Title
WHERE Price >= 
    (SELECT price FROM Title WHERE TitleID = 'BU7832')
ORDER BY Price DESC;

-- Example 4 - Let's try multiple levels of subqueries
SELECT Title, Price
FROM Title
WHERE Price >= 
    (SELECT Price FROM Title
     WHERE titleID = 
        (SELECT titleID FROM Title
         WHERE title = 'Straight Talk About Computers'))
ORDER BY Price DESC;

/*
•	Example 5: 	
•	List the books that have a price less than the average price of all books.
•	Steps:
a)	Find the average book price.
b)	Find the books with a price less than the average
*/
SELECT AVG(Price) FROM Title;
SELECT title, price
FROM Title
WHERE Price < (SELECT AVG(Price) FROM Title);

/*
•	Example 6: 	
•	Give the names of the authors that live in states where more than 
one Author is listed?
•	Steps:
a)	Find how many Authors are in each state.
b)	Find which are greater than 1
c)	Get the names of the authors that live in those states
*/
--a) Find how many Authors are in each state
SELECT state, COUNT(*) FROM Author GROUP BY state;
--b) Find which are greater than 1
SELECT state, COUNT(*) FROM Author GROUP BY state HAVING COUNT(*) > 1;
--c) Get the names of the authors that live in those states.
SELECT aufname, aulname, state
FROM Author
WHERE state IN
    (SELECT state FROM Author GROUP BY state HAVING COUNT(*) > 1);

-- Correlated Subqueries
SELECT pubName
FROM Publisher p
WHERE EXISTS
    (SELECT *
    FROM Title t
    WHERE t.pubId = p.pubId
    AND type = 'business');

/*
Example 2: 	
Retrieve the name, publisher ID, and ytdSales, of any book whose 
ytdSales is above average for that book's publisher. 
*/
SELECT title, pubID, ytdsales FROM Title outerTitle;
SELECT title, pubID, ytdsales FROM Title outerTitle
WHERE ytdsales >
    (SELECT AVG(ytdsales) FROM Title innerTitle
    WHERE outerTitle.pubID = innerTitle.pubID);
    
/*
Change the query in Example 2 to display the publisher's name instead of the ID.
*/
SELECT title, P.pubID, ytdsales, pubName
FROM Title outerTitle
JOIN Publisher P ON P.pubID = outerTitle.pubID
WHERE ytdsales >
    (SELECT AVG(ytdsales) FROM Title innerTitle
    WHERE outerTitle.pubID = innerTitle.pubID);

------------------------
-- Joins vs Subqueries
-- Search for the names of publishers located in the same city as an author
SELECT DISTINCT pubName FROM Publisher P 
    JOIN Author A ON A.city=P.city;
-- vs subquery
SELECT pubName FROM Publisher
    WHERE city IN (SELECT city FROM Author);
-- What if we wanted to see both the publisher's name and author's name?
SELECT pubName, aulname, aufname, P.city
    FROM Publisher P
    JOIN Author A ON A.city=P.city;
    
-- Alternate use of IN
SELECT aulname, aufname, city
FROM Author
WHERE (city, state) IN
    (SELECT city, state
    FROM Editor
    WHERE edlname = 'DeLongue');
    
---------------------------------------
/*
Example: What publishers have published books that cost more than $35.00.
1.	What columns do you want to display? pubName
2.	Identify the tables involved. Publisher, Title
3.	Look at the join conditions and types of joins. Inner Join Title with Publisher
4.	Look at any restrictions on the rows. price > 35
5.	Is there any grouping or ordering required? Don't think so
*/
--As a join:
SELECT DISTINCT pubName 
FROM Title T
    JOIN Publisher P ON T.pubID = P.pubID
    WHERE price > 35;

-- Solve a subquery:
SELECT pubName
FROM Publisher
    WHERE pubID IN
    (SELECT pubID 
    FROM Title
    WHERE price > 35);
-- Note: Tables listed in the outer FROM clause dictate which columns are available
-- for display

/*
1. What is the name of the book with the highest price?
1.	Write inner query first
2.	Write outer  query next
*/
--1. inner query
SELECT MAX(Price) FROM Title;
--2. outer query
SELECT title FROM Title WHERE Price = (SELECT MAX(Price) FROM Title);

/*
2. Would like to know the names of the books that Eleanore Himmel edited.
1.	Identify the tables involved. Title, Editor, TitleEditor
2.	Look at the join conditions and types of joins. Inner Joins
3.	Look at any restrictions on the rows. Editor Name
4.	What columns do you want to display? Title
5.	Is there any grouping or ordering required? None
*/
-- As a join:
SELECT title
FROM Title T
    JOIN TitleEditor TE ON TE.titleID = T.titleID
    JOIN Editor E ON TE.edID = E.edID
WHERE
    edlname = 'Himmel' AND
    edfname = 'Eleanore'
    ;
-- As a subquery - start with the inner most subquery
SELECT title
FROM Title 
WHERE 
    titleID IN
    (SELECT titleID FROM TitleEditor
    WHERE 
        edID IN
        (SELECT edID
        FROM Editor
        WHERE
            edlname = 'Himmel' AND
            edfname = 'Eleanore')
    )
;

SELECT pubID, pubName
FROM Publisher P_Out
WHERE 0 =
  (SELECT count(*)
  FROM Title t_In
  WHERE type = 'business'
    AND t_In.pubid = p_Out.pubid);

/*
Find the names of all second authors who live in California and receive less 
than 30 percent of the royalties on the books they coauthor.
*/
SELECT aulname, aufname
FROM Author
WHERE
    state = 'CA' AND
    auID IN
    (SELECT auID
    FROM TitleAuthor
    WHERE
        royaltyshare < 0.3 AND
        auOrder = 2);
        



