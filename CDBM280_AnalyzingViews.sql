SELECT * FROM Oaklanders;
DELETE FROM Oaklanders
WHERE titleID = 'BU1032';

select count(*)
FROM TitleAuthor;

ROLLBACK;

INSERT INTO Oaklanders
VALUES ('Tanya', 'G', 'PC1233', 'DB is Fun');


CREATE OR REPLACE VIEW Oaklanders
AS
SELECT auFName AS First, auLName AS Last, ta.titleID, title
FROM Author a JOIN TitleAuthor ta ON a.auID = ta.auID
	JOIN Title t ON ta.titleID = t.titleID
WHERE city = 'Oakland'
	AND state = 'CA';
    
SELECT * FROM Oaklanders;

UPDATE Oaklanders
SET TitleID = 'BU7832'
WHERE TitleID = 'BU1032';

ROLLBACK;

INSERT INTO Title (titleID, title, contract) values ('TL1111', 'DB is the best', 1);

UPDATE Oaklanders
SET titleID = 'TL1111'
WHERE titleID = 'BU7832';

SELECT * FROM TitleAuthor
WHERE titleID in ('BU7832', 'TL1111');

ROLLBACK;

DELETE FROM Oaklanders
WHERE titleID = 'BU1032';

SELECT * FROM TitleAuthor
WHERE titleID = 'BU1032';

SELECT * FROM Oaklanders;
ROLLBACK;

CREATE OR REPLACE VIEW Oaklanders
AS
SELECT ta.auID, auFName AS First, auLName AS Last, ta.titleID, title, ta.auOrder
FROM Author a JOIN TitleAuthor ta ON a.auID = ta.auID
	JOIN Title t ON ta.titleID = t.titleID
WHERE city = 'Oakland'
	AND state = 'CA';

INSERT INTO Oaklanders (auID, titleID, auOrder)
VALUES ('213-46-8915', 'BU1111', 3);

SELECT * FROM Oaklanders;
SELECT * FROM TitleAuthor order by TitleID;
ROLLBACK;
UPDATE Oaklanders
SET titleID = 'BU7832'
WHERE titleID = 'TL1111';
SELECT * FROM Oaklanders;

DELETE FROM Oaklanders
WHERE titleID = 'BU1032';

SELECT * FROM Oaklanders;
SELECT * FROM TitleAuthor WHERE TitleID = 'BU1032';

ROLLBACK;
