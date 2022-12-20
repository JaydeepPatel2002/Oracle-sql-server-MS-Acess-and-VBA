/* 
a)	Create the view.
b)	For each view that you create, indicate whether the view is updatable or not, and explain.
c)	If the view is updatable, your explanation should indicate which of inserts, 
updates, and/or deletes would be allowed, and what columns could be updated.
*/

/*
1.	Create a view called A3Commission that shows all of the salespeople with the 
orders they were responsible for. Display the snum, name, onum and the amount of 
commission they will receive for the order. (comm. * amt).
*/
CREATE VIEW A3Commission
AS
SELECT S.SalesPersonNum, SalesPName AS Name, OrderNum, Commission * OrderAmount AS CommissionAmount
FROM SalesPeople S
    JOIN Orders O ON S.SalesPersonNum = O.SalesPersonNum;

SELECT * FROM A3Commission;
-- Is view updatable?  
-- Yes, for Update and Delete.
-- Inserts are not possible since all the required fields are not included
-- (date, customernum, and salespersonnum (orders)).
-- Updates are possible on the fields from Orders, which is OrderNum.
-- Deletes from Orders can be done as well.

/*
2.	Create a view called A3SalespeopleCustomers that shows each salesperson 
(snum, sname) and the customers (cnum, cname) to which they are assigned.
*/
CREATE OR REPLACE VIEW A3SalespeopleCustomers
AS
SELECT C.SalesPersonNum, S.SalesPName, C.CustomerNum, C.CusName
FROM SalesPeople S 
    JOIN Customers C ON S.SalesPersonNum = C.SalesPersonNum;
    
SELECT * FROM A3SalespeopleCustomers;
-- Updateable?
/*
Yes, this view is updateable for I/U/D on Customers only.  Customers is the key-preserved
table, therefore, SalesPersonNum cannot be updated (as it's drawn from the SalesPeople Table).
If SalesPersonNum was retrieved (queried) from Customers, then it could be updated.
*/

INSERT INTO A3SalespeopleCustomers (SalesPersonNum, CustomerNum, CusName)
VALUES ('9999', '2020', 'Herbert');

SELECT * FROM a3salespeoplecustomers;

/*
3.	Create a view A3HighOct3Orders that uses the Orders table (all columns) 
to only show rows with the amount of $1000 or more. Include the restriction 
on the view to enforce the WHERE clause for updates.
*/
CREATE VIEW A3HighOct3Orders
AS
SELECT OrderNum, OrderAmount, OrderDate, SalesPersonNum, CustomerNum
FROM Orders
WHERE OrderAmount >= 1000 AND OrderDate = '03-OCT-00'
WITH CHECK OPTION;

SELECT * FROM A3HighOct3Orders;

INSERT INTO A3HighOct3Orders
VALUES (4000, 1500, '03-OCT-00', 1004, 2007);
