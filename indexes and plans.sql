SELECT
  id ||
  DECODE(id, 0, '', LPAD(' ', 2*(level - 1))) || ' ' ||
  operation || ' ' ||
  options || ' ' ||
  object_name || ' ' ||
  object_type || ' ' ||
  DECODE(cost, NULL, '', 'Cost = ' || position)
AS execution_plan
FROM plan_table
CONNECT BY PRIOR id = parent_id
AND statement_id = '&v_statement_id'
START WITH id = 0
AND statement_id = '&v_statement_id';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(format => 'ALL'));

SELECT * FROM PLAN_TABLE;
DELETE FROM PLAN_TABLE;
-- indexes
-- Cost = 4
EXPLAIN PLAN SET STATEMENT_ID = 'index1' FOR
SELECT * FROM Customers ORDER BY CName;

-- Add an index on cname
CREATE INDEX cust_name_index ON Customers(CName);

-- Cost = 2
EXPLAIN PLAN SET STATEMENT_ID = 'index2' FOR
SELECT * FROM Customers ORDER BY CName;

-- Cost = 2
EXPLAIN PLAN SET STATEMENT_ID = 'index3' FOR
SELECT * FROM Customers ORDER BY CName DESC;

-- Cost = 2
-- We created an index for Cname
-- Index Cname
-- AAA
-- AAAB
-- AAC
--....
-- GAA
-- GBA

EXPLAIN PLAN SET STATEMENT_ID = 'index4' FOR
SELECT * FROM Customers WHERE Cname LIKE 'G%' ORDER BY Cname;

EXPLAIN PLAN SET STATEMENT_ID = 'index5' FOR
SELECT * FROM Customers WHERE Cname LIKE 'G%';

-- Cost = 3, which is more than when using Cname
-- City is not indexed
EXPLAIN PLAN SET STATEMENT_ID = 'index6' FOR
SELECT * FROM Customers WHERE City LIKE 'S%';

DELETE FROM PLAN_TABLE
WHERE STATEMENT_ID = 'index6';

-- indexes on foreign keys
-- Cost = 6
EXPLAIN PLAN SET STATEMENT_ID = 'index7' FOR
SELECT onum, cname FROM Customers c JOIN Orders o ON c.cnum = o.cnum;

-- add an index on the FK
-- Cost = 6
CREATE INDEX cust_order_fk_index ON Orders(cnum);
EXPLAIN PLAN SET STATEMENT_ID = 'index8' FOR
SELECT onum, cname FROM Customers c JOIN Orders o ON c.cnum = o.cnum;

-- where vs having
/*
0 SELECT STATEMENT    Cost = 4
1   FILTER    
2     HASH GROUP BY   Cost = 1
3       TABLE ACCESS FULL ORDERS TABLE Cost = 1
*/
EXPLAIN PLAN SET STATEMENT_ID = 'having1' FOR
SELECT odate, avg(amt) FROM Orders GROUP BY odate HAVING odate IN ('03-OCT-00', '04-OCT-00');

/*
0 SELECT STATEMENT    Cost = 4
1   HASH GROUP BY   Cost = 1
2     TABLE ACCESS FULL ORDERS TABLE Cost = 1
*/
EXPLAIN PLAN SET STATEMENT_ID = 'having2' FOR
SELECT odate, avg(amt) FROM Orders WHERE odate IN ('03-OCT-00', '04-OCT-00') GROUP BY odate;

DELETE FROM PLAN_TABLE;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(format => 'ALL'));

-- Exists vs IN
-- Cost = 3
EXPLAIN PLAN SET STATEMENT_ID='exists1' FOR
SELECT cnum, cname FROM Customers c_outer WHERE EXISTS (SELECT * FROM Orders o WHERE o.cnum = c_outer.cnum);

-- Cost = 3
EXPLAIN PLAN SET STATEMENT_ID='exists2' FOR
SELECT cnum, cname FROM Customers c_outer WHERE cnum IN (SELECT cnum FROM Orders o WHERE o.cnum = c_outer.cnum);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(format => 'ALL'));
-- vs Using Distinct and a join
-- Cost = 4
EXPLAIN PLAN SET STATEMENT_ID = 'exists4' FOR
SELECT DISTINCT c.cnum, c.cname FROM Customers c JOIN Orders o ON c.cnum = o.cnum;

DROP INDEX cust_order_fk_index;
-- After dropping the Orders FK index on cnum, we almost double the cost!
-- Cost = 7
