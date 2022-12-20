DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE Customers CASCADE CONSTRAINTS;
DROP TABLE Salespeople CASCADE CONSTRAINTS;

CREATE TABLE Salespeople
(snum   INTEGER   NOT NULL  PRIMARY KEY,
 sname  CHAR(15)  NOT NULL,
 city   CHAR(15),
 comm   NUMBER);

INSERT INTO Salespeople (snum, sname, city, comm)
VALUES (1001, 'Peel', 'London', .12);

INSERT INTO Salespeople (snum, sname, city, comm)
VALUES (1002, 'Serres', 'San Jose', .13);

INSERT INTO Salespeople (snum, sname, city, comm)
VALUES (1004, 'Motika', 'London', .11);

INSERT INTO Salespeople (snum, sname, city, comm)
VALUES (1007, 'Rifkin', 'Barcelona', .15);

INSERT INTO Salespeople (snum, sname, city, comm)
VALUES (1003, 'Axelrod', 'New York', .10);

COMMIT;


CREATE TABLE Customers
(cnum   INTEGER   NOT NULL  PRIMARY KEY,
 cname  CHAR(15)  NOT NULL,
 city   CHAR(15),
 rating INTEGER,
 snum   INTEGER   REFERENCES Salespeople(snum));

INSERT INTO Customers (cnum, cname, city, rating, snum)
VALUES (2001, 'Hoffman', 'London', 100, 1001);

INSERT INTO Customers (cnum, cname, city, rating, snum)
VALUES (2002, 'Giovanni', 'Rome', 200, 1003);

INSERT INTO Customers (cnum, cname, city, rating, snum)
VALUES (2003, 'Liu', 'San Jose', 200, 1002);

INSERT INTO Customers (cnum, cname, city, rating, snum)
VALUES (2004, 'Grass', 'Berlin', 300, 1002);

INSERT INTO Customers (cnum, cname, city, rating, snum)
VALUES (2006, 'Clemens', 'London', NULL, 1001);

INSERT INTO Customers (cnum, cname, city, rating, snum)
VALUES (2008, 'Cisneros', 'San Jose', 300, 1007);

INSERT INTO Customers (cnum, cname, city, rating, snum)
VALUES (2007, 'Pereira', 'Rome', 100, 1004);

COMMIT;


CREATE TABLE Orders
(onum   INTEGER   NOT NULL  PRIMARY KEY,
 amt    NUMBER,
 odate  DATE      NOT NULL,
 cnum   INTEGER   NOT NULL  REFERENCES Customers(cnum),
 snum   INTEGER   NOT NULL  REFERENCES Salespeople(snum));

INSERT INTO Orders (onum, amt, odate, cnum, snum)
VALUES(3001, 18.69, TO_DATE('10/03/2000', 'MM/DD/YYYY'), 2008, 1007);

INSERT INTO Orders (onum, amt, odate, cnum, snum)
VALUES(3003, 767.19, TO_DATE('10/03/2000', 'MM/DD/YYYY'), 2001, 1001);

INSERT INTO Orders (onum, amt, odate, cnum, snum)
VALUES(3002, 1900.10, TO_DATE('10/03/2000', 'MM/DD/YYYY'), 2007, 1004);

INSERT INTO Orders (onum, amt, odate, cnum, snum)
VALUES(3005, 5160.45, TO_DATE('10/03/2000', 'MM/DD/YYYY'), 2003, 1002);

INSERT INTO Orders (onum, amt, odate, cnum, snum)
VALUES(3006, 1098.16, TO_DATE('10/03/2000', 'MM/DD/YYYY'), 2008, 1007);

INSERT INTO Orders (onum, amt, odate, cnum, snum)
VALUES(3009, 1713.23, TO_DATE('10/04/2000', 'MM/DD/YYYY'), 2002, 1003);

INSERT INTO Orders (onum, amt, odate, cnum, snum)
VALUES(3007, 75.75, TO_DATE('10/04/2000', 'MM/DD/YYYY'), 2004, 1002);

INSERT INTO Orders (onum, amt, odate, cnum, snum)
VALUES(3008, 4723.00, TO_DATE('10/05/2000', 'MM/DD/YYYY'), 2006, 1001);

INSERT INTO Orders (onum, amt, odate, cnum, snum)
VALUES(3010, 1309.95, TO_DATE('10/06/2000', 'MM/DD/YYYY'), 2004, 1002);

INSERT INTO Orders (onum, amt, odate, cnum, snum)
VALUES(3011, 9891.88, TO_DATE('10/06/2000', 'MM/DD/YYYY'), 2006, 1001);

COMMIT;
