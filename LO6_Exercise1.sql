DROP TABLE Repair CASCADE CONSTRAINTS;
DROP TABLE Item CASCADE CONSTRAINTS;
DROP TABLE ItemRepair CASCADE CONSTRAINTS;

/* PART 1 and 2*/
CREATE TABLE Repair (
    itemNumber          NUMBER(4),
    type                VARCHAR2(20),
    acquisitionCost     NUMBER(8,2), /*8 total digits, 2 reserved for RHS of decimal */
    repairNumber        NUMBER(4),
    repairDate          DATE,
    repairAmount        NUMBER(7,2) /*7 total digits, 2 reserved for RHS */
);

SELECT * FROM Repair;

/* Keep in in mind the default format for DATE is DD-MMM-YY */
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
    VALUES (100, 'Drill Press', 3500, 2000, '5-may-04', 375);
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
    VALUES (200, 'Lathe', 4750, 2100, '7-may-04', 255);
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
	VALUES (100, 'Drill Press', 3500, 2200, '19-may-04', 178);
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
	VALUES (300, 'Mill', 27300, 2300, '19-may-04', 1785);
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
	VALUES (100, 'Drill Press', 3500, 2400, '11-may-04', 0);
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
	VALUES (100, 'Drill Press', 3500, 2600, '1-jun-04', 275);    

COMMIT;

/* Part 3.  The creation of the two new tables */
CREATE TABLE Item (
    itemNumber NUMBER(4) CONSTRAINT Item_itemNumber_PK PRIMARY KEY,
    type VARCHAR2(20),
    acquisitionCost NUMBER(8,2)
);

CREATE TABLE ItemRepair(
    repairNumber NUMBER(4) CONSTRAINT ItemRepair_repairNumber_PK PRIMARY KEY,
    repairDate DATE,
    repairAmount NUMBER(8,2),
    itemNumber NUMBER(4)
        CONSTRAINT ItemRepair_itemNumber_FK REFERENCES Item(itemNumber)
);

SELECT * FROM Repair;
DROP TABLE Repair CASCADE CONSTRAINTS;
DROP TABLE Item CASCADE CONSTRAINTS;
DROP TABLE ItemRepair CASCADE CONSTRAINTS;

/* PART 1 and 2*/
CREATE TABLE Repair (
    itemNumber          NUMBER(4),
    type                VARCHAR2(20),
    acquisitionCost     NUMBER(8,2), /*8 total digits, 2 reserved for RHS of decimal */
    repairNumber        NUMBER(4),
    repairDate          DATE,
    repairAmount        NUMBER(7,2) /*7 total digits, 2 reserved for RHS */
);

SELECT * FROM Repair;

/* Keep in in mind the default format for DATE is DD-MMM-YY */
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
    VALUES (100, 'Drill Press', 3500, 2000, '5-may-04', 375);
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
    VALUES (200, 'Lathe', 4750, 2100, '7-may-04', 255);
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
	VALUES (100, 'Drill Press', 3500, 2200, '19-may-04', 178);
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
	VALUES (300, 'Mill', 27300, 2300, '19-may-04', 1785);
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
	VALUES (100, 'Drill Press', 3500, 2400, '11-may-04', 0);
INSERT INTO Repair (itemNumber, type, acquisitionCost, repairNumber, repairDate, repairAmount)
	VALUES (100, 'Drill Press', 3500, 2600, '1-jun-04', 275);    

COMMIT;

/* Part 3.  The creation of the two new tables */
CREATE TABLE Item (
    itemNumber NUMBER(4) CONSTRAINT Item_itemNumber_PK PRIMARY KEY,
    type VARCHAR2(20),
    acquisitionCost NUMBER(8,2)
);

CREATE TABLE ItemRepair(
    repairNumber NUMBER(4) CONSTRAINT ItemRepair_repairNumber_PK PRIMARY KEY,
    repairDate DATE,
    repairAmount NUMBER(8,2),
    itemNumber NUMBER(4)
        CONSTRAINT ItemRepair_itemNumber_FK REFERENCES Item(itemNumber)
);

/* Part 4.  Populate the new tables from the old table */
INSERT INTO Item (itemNumber, type, acquisitionCost)
    SELECT DISTINCT itemNumber, type, acquisitionCost FROM REPAIR;

INSERT INTO ItemRepair (itemNumber, repairNumber, repairDate, repairAmount)
    SELECT itemNumber, repairNumber, repairDate, repairAmount
    FROM Repair;
    
COMMIT;

UPDATE Item
    SET type='Industrial Lathe'
    WHERE itemNumber=200;

SELECT * from Item;

COMMIT; /* ROLLBACK; */

SELECT * from Item;

UPDATE ItemRepair
    SET repairAmount = repairAmount + 0.50
    WHERE itemNumber = 100;

SELECT * from Item;
SELECT * from ItemRepair;

COMMIT;

/* Results in an error, as there's a FK constraint to that record */
DELETE FROM Item
WHERE itemNumber=300;

/* Let's DELETE the children first */
DELETE FROM ItemRepair
WHERE itemNumber=300;

/* The child record is deleted, so we can go ahead and delete the parent record */
DELETE FROM Item
WHERE itemNumber=300;

COMMIT;






