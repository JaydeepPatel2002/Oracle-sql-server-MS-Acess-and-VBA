/* deleting any tables that may already exist */
DROP TABLE Project CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Assignment CASCADE CONSTRAINTS;

/* Creating the tables */

CREATE TABLE Project (
  projectID   NUMBER(4)         CONSTRAINT Project_PK 		PRIMARY KEY,
  prjName     VARCHAR2(25)      CONSTRAINT Project_name_NN	NOT NULL
								CONSTRAINT Project_name_UK	UNIQUE,
  department  VARCHAR2(30),
  maxHours    NUMBER(6,1)      	DEFAULT 100
);
  
CREATE TABLE Employee (
  empNumber  NUMBER(3)			CONSTRAINT Employee_PK 		PRIMARY KEY,
  empName    VARCHAR2(25)		CONSTRAINT Employee_name_NN	NOT NULL,
  phone      CHAR(8),
  department VARCHAR2(30)
);

CREATE TABLE Assignment (
  projectID     NUMBER(4)		CONSTRAINT Assignment_projectID_FK references Project (projectID),
  empNumber		NUMBER(3)  		CONSTRAINT Assignment_employeeNumber_FK references Employee (empNumber),
  hoursWorked	NUMBER(5,2)		DEFAULT 10,
  CONSTRAINT Assignment_PK PRIMARY KEY (projectID, empNumber)
);


/* Populating the Project table */

INSERT INTO Project
   VALUES (1000,'Q3 Portfolio Analysis', 'Finance', 75.0);

INSERT INTO Project
   VALUES (1500,'Q4 Portfolio Analysis', 'Finance', 110.0);

INSERT INTO Project
   VALUES (1200,'Q3 Tax Prep', 'Accounting', 145.0);

INSERT INTO Project
   VALUES (1400,'Q4 Portfolio Plan', 'Marketing', 138.0);

/* Populating the Employee table */

INSERT INTO Employee
   VALUES (100, 'Mary Jacobs', '285-8879', 'Accounting');

INSERT INTO Employee
   VALUES (200, 'Keji Numoto', '287-0098', 'Marketing');

INSERT INTO Employee
   VALUES (300, 'Heather Jones', '287-9981', 'Finance');

INSERT INTO Employee
   VALUES (400, 'Rosalie Jackson', '285-1273', 'Accounting');

INSERT INTO Employee
   VALUES (500, 'James Nestor', '', 'Info Systems');

INSERT INTO Employee
   VALUES (600, 'Richard Wu', '287-0123', 'Info Systems');

INSERT INTO Employee
   VALUES (700, 'Kim Sung', '287-3222', 'Marketing');

/* Populating the Assignment table */

INSERT INTO Assignment
   VALUES (1000, 100, 17.50);

INSERT INTO Assignment
   VALUES (1000, 300, 12.50);

INSERT INTO Assignment
   VALUES (1000, 400, 8.00);

INSERT INTO Assignment
   VALUES (1000, 500, 20.25);

INSERT INTO Assignment
   VALUES (1200, 100, 45.75);

INSERT INTO Assignment
   VALUES (1200, 400, 70.50);

INSERT INTO Assignment
   VALUES (1200, 600, 40.50);

INSERT INTO Assignment
   VALUES (1400, 200, 75.00);

INSERT INTO Assignment
   VALUES (1400, 700, 20.25);

INSERT INTO Assignment
   VALUES (1400, 500, 25.25);

COMMIT;