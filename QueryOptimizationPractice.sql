-- 1
/*
1.	Big Joins vs Nested Subqueries
Using BookBiz, create two separate queries, one using several joins and the other 
using multiple nested subqueries that will find the name of the author(s) who 
wrote the book “Secrets of Silicon Valley”.  Create a plan for each of these 
queries and compare them.
*/
SELECT * FROM PLAN_TABLE;

EXPLAIN PLAN SET STATEMENT_ID = 'BigJoin' FOR
SELECT aufname, aulname 
FROM Author a
JOIN TitleAuthor ta on a.auid = ta.auid
JOIN Title t on ta.titleid = t.titleid
WHERE t.title = 'Secrets of Silicon Valley';

EXPLAIN PLAN SET STATEMENT_ID = 'Nested' FOR
SELECT aufname, aulname 
FROM Author 
WHERE auid IN
    (SELECT auid FROM TitleAuthor
    WHERE titleid IN
        (SELECT titleid FROM Title
        WHERE title='Secrets of Silicon Valley'));
        
-- Join (Cost of 3) seems more efficient than the subquery solution (Cost of 4)

-- 2
/*
2.	Subqueries vs direct table access
Find authors who have books. Do you think it would be faster to find distinct auid values 
in the TitleAuthor table or a different query that uses one of the approaches from class 
(for example joining author to titleauthor and distinct, or exists in a correlated subquery). 
Try several approaches and compare the execution plans.
*/
EXPLAIN PLAN SET STATEMENT_ID = 'titleauth' FOR
SELECT DISTINCT auid FROM TitleAuthor;
-- vs other approaches.
-- This query should be faster as only one table is selected from.
-- One caveat to this would be that if you needed something besides auid 
-- for example, author name, we would need to join another table.

-- 3
/*
3.	Create a query using INTERSECT to find publishers in the same city as authors 
and a query that gets the same information but uses a join on city. See which plan 
offers better results. If the two have the same cost, which do you think might have 
the edge based on the plan listed?
a.	Create an index on author city, then create two new plans for the above queries. What has changed?
b.	Create a second index on publisher city, then create two new plans. What has changed?
c.	What can be inferred from this regarding indexes and set operators like intersect?
*/
EXPLAIN PLAN SET STATEMENT_ID = 'intersect' FOR
SELECT City FROM Author
INTERSECT
SELECT City FROM Publisher;

EXPLAIN PLAN SET STATEMENT_ID = 'joincity' FOR
SELECT DISTINCT A.City FROM Author A
    JOIN Publisher P ON A.city = P.city;

CREATE INDEX author_city_ind ON Author(city);
-- Rerun plans, change names of the STATEMENT_ID

EXPLAIN PLAN SET STATEMENT_ID = 'intersect_authorind' FOR
SELECT City FROM Author
INTERSECT
SELECT City FROM Publisher;

EXPLAIN PLAN SET STATEMENT_ID = 'joincity_authorind' FOR
SELECT DISTINCT A.City FROM Author A
    JOIN Publisher P ON A.city = P.city;
-- Cost is reduced on the JOIN query, as Oracle needs to map the two tables together
-- on the city.  The INTERSECT query is uneffected.  


CREATE INDEX pub_city_ind ON Publisher(city);

EXPLAIN PLAN SET STATEMENT_ID = 'intersect_bothind' FOR
SELECT City FROM Author
INTERSECT
SELECT City FROM Publisher;

EXPLAIN PLAN SET STATEMENT_ID = 'joincity_bothind' FOR
SELECT DISTINCT A.City FROM Author A
    JOIN Publisher P ON A.city = P.city;

-- Cost is further reduced on the JOIN query, as Oracle needs to map the two tables together
-- on the city.  The INTERSECT query is uneffected. 

-- 4
/*
4.	What is the implication on cost for sorting on multiple columns?
a.	Create a plan for a query that shows all titles, sorted by Title.
b.	Create a plan for a similar query, this time sort on type, then title
c.	Create yet another query that sorts on price, then type, then title
d.	Review the plans for each.
e.	Create a query that finds Title publishers (show Title and Publisher name) using a join. 
Create plans for each of the following, do the costs differ?
i.	Sort by Title
ii.	Sort by Publisher Name
iii.	Sort by Title then publisher
iv.	Sort by Publisher, then Title
*/

-- Note that there is an index that is created for Title field on Title table
EXPLAIN PLAN SET STATEMENT_ID = 'titlesort' FOR
SELECT Title, type, price 
FROM Title
ORDER BY TItle;

EXPLAIN PLAN SET STATEMENT_ID = 'typetitlesort' FOR
SELECT Title, type, price 
FROM Title
ORDER BY Type, Title;

EXPLAIN PLAN SET STATEMENT_ID = 'pricetypetitlesort' FOR
SELECT Title, type, price 
FROM Title
ORDER BY Price, type, Title;
-- seems no difference between the last 2 queries, but the first query is significantly more efficient

-- Let's just explore what happens when we create an index for the other fields
CREATE INDEX title_type_ind ON Title(type);
EXPLAIN PLAN SET STATEMENT_ID = 'typetitlesort_typeind' FOR
SELECT Title, type, price 
FROM Title
ORDER BY Type, Title;

EXPLAIN PLAN SET STATEMENT_ID = 'pricetypetitlesort_typeind' FOR
SELECT Title, type, price 
FROM Title
ORDER BY Price, type, Title;
-- no difference

CREATE INDEX title_price_ind ON Title(price);

EXPLAIN PLAN SET STATEMENT_ID = 'typetitlesort_priceind' FOR
SELECT Title, type, price 
FROM Title
ORDER BY Type, Title;

EXPLAIN PLAN SET STATEMENT_ID = 'pricetypetitlesort_priceind' FOR
SELECT Title, type, price 
FROM Title
ORDER BY Price, type, Title;

-- Again, no difference.  This makes sense, as we are first sorting by price, and Oracle
-- doesn't use an index to perform sorting, especially nested sorts

-- 4e
EXPLAIN PLAN SET STATEMENT_ID = 'pubtitlesort' FOR
SELECT Title, Pubname FROM Title T JOIN Publisher P ON T.pubid = P.pubid
ORDER BY Title;

EXPLAIN PLAN SET STATEMENT_ID = 'pubtitlesort2' FOR
SELECT Title, Pubname FROM Title T JOIN Publisher P ON T.pubid = P.pubid
ORDER BY pubname;

EXPLAIN PLAN SET STATEMENT_ID = 'pubtitlesort3' FOR
SELECT Title, Pubname FROM Title T JOIN Publisher P ON T.pubid = P.pubid
ORDER BY Title, pubname;

EXPLAIN PLAN SET STATEMENT_ID = 'pubtitlesort4' FOR
SELECT Title, Pubname FROM Title T JOIN Publisher P ON T.pubid = P.pubid
ORDER BY pubname, Title;

-- Costs are the same - it is sorting on a non-indexed field so that are all slow (Cost 7)
CREATE INDEX title_pubid_ind ON Title(pubid);

EXPLAIN PLAN SET STATEMENT_ID = 'pubtitlesort5' FOR
SELECT Title, Pubname FROM Title T JOIN Publisher P ON T.pubid = P.pubid
ORDER BY Title;
-- That new index on the FK in Title saved a little bit of time.
-- In general, any computer-related activity could be brought to its knees with any kind of sort.

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY(format => 'ALL'));