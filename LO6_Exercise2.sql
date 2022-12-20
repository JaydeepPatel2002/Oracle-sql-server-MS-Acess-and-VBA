SELECT * FROM Project;
SELECT * FROM Employee;
SELECT * FROM Assignment;

-- 1.	Change all Finance projects to have a max hours of 300.
UPDATE Project SET maxHours = 300 WHERE department = 'Finance';
SELECT * FROM Project;

-- 2.	Change all projects that have a max hours of 140 or more to have 25 hours less.
UPDATE Project SET maxHours = maxHours - 25 WHERE maxHours >= 140;
SELECT * FROM Project;

-- 3.	Give James Nestor a phone number of 285-1234.
UPDATE Employee SET phone = '285-1234' WHERE empNumber = 500;

-- 4.	Richard Wu has moved to the Finance department.
UPDATE Employee SET department = 'Finance' WHERE empNumber = 600;
/* Notice the above 2 update statements are using primary keys for the WHERE condition */

-- 5.	Richard Wu has worked 8.5 hours on the Q4 Portfolio Analysis project.
-- Richard Wu, empNumber 600
-- Q4 Portfolio Analysis, projectID 1500
INSERT INTO Assignment VALUES (1500, 600, 8.5);
/* The insert statement uses the default column order of the table */

-- 6.	The entry for Rosalie Jackson for the Q3 Tax Prep project 
-- should have been for the Q4 Portfolio Plan project.
-- Rosalie Jackson, empNumber 400
-- Q3 Tax Prep Project, projectID 1200
-- Q4 Portfolio Plan Project, projectID 1400
UPDATE Assignment SET projectID = 1400 WHERE empNumber = 400 AND projectID = 1200;
/* NOTICE that the where clause has 2 individual clauses joined with an AND operator */

-- 7.	The max hours for each project should be decreased by a relative 25%.
UPDATE project SET maxHours = maxHours * .75;

-- 8.	Create a new table, EmpContactMarketing, which will include the name and phone 
-- for employees in the Marketing department.
CREATE TABLE EmpContactMarketing AS 
    SELECT empName, phone FROM Employee WHERE department = 'Marketing';
SELECT * FROM EmpContactMarketing;

-- 9.	Remove all data that is related to Heather Jones.
-- Heather Jones, empNumber 300
DELETE FROM Assignment WHERE empNumber = 300;
DELETE FROM Employee WHERE empNumber = 300;

/************* PART 2 *****************/
DROP SEQUENCE ex2Sequence;
DROP SEQUENCE keySequence;
/*
1.	Create a cycling sequence called ex2Sequence that will start at 100 
and count down by 25 to a minimum of 0 and start over at 200. 
Note: You will need to include NOCACHE as an option.
*/
CREATE SEQUENCE ex2Sequence 
    START WITH 100
    INCREMENT BY -25
    CYCLE
    MINVALUE 0
    MAXVALUE 200
    NOCACHE;

-- 2.	Create a sequence that counts from 1 by 1. Call it keySequence.
CREATE SEQUENCE keySequence;

-- 3.	Create ta table ex2Table with two columns both number(3). Make one a primary key.
CREATE TABLE ex2Table (
    keyCol  NUMBER(3) PRIMARY KEY,
    countCol    NUMBER(3)
);

/*
4.	Insert into it. The keySequence should be used for the primary key 
    and the ex2Sequence for the other column.
5.	Insert 10 records or more and observe the data.  You can just re-execute
the insert statement 9 more times.
*/
INSERT INTO ex2Table VALUES (keySequence.NEXTVAL, ex2Sequence.NEXTVAL);
SELECT * FROM ex2Table;

-- 6.	Drop the table and sequences.
DROP TABLE ex2Table;
DROP SEQUENCE ex2Sequence;
DROP SEQUENCE keySequence;

-- 7.	Rollback your changes on project/employee/assignment
ROLLBACK;
