--Oracle modifications to INSERTs
--& is variable substitution sign for Oracle. Turn it off with
set scan off;
--turn it back on with set scan on
--set date format for Oracle with alter session:
alter session set nls_date_format = 'MM/DD/YYYY';

INSERT INTO Author
VALUES('409-56-7008', 'Bennet', 'Abraham',
'415 658-9932', '6223 Bateman St.', 'Berkeley', 'CA', '94705')
;
INSERT INTO Author
VALUES('213-46-8915', 'Green', 'Marjorie',
'415 986-7020', '309 63rd St. #411', 'Oakland', 'CA', '94618')
;
INSERT INTO Author
VALUES('238-95-7766', 'Carson', 'Cheryl',
'415 548-7723', '589 Darwin Ln.', 'Berkeley', 'CA', '94705')
;
INSERT INTO Author
VALUES('998-72-3567', 'Ringer', 'Albert',
'801 826-0752', '67 Seventh Av.', 'Salt Lake City', 'UT', '84152')
;
INSERT INTO Author
VALUES('899-46-2035', 'Ringer', 'Anne',
'801 826-0752', '67 Seventh Av.', 'Salt Lake City', 'UT', '84152')
;
INSERT INTO Author
VALUES('722-51-5454', 'DeFrance', 'Michel',
'219 547-9982', '3 Balding Pl.', 'Gary', 'IN', '46403')
;
INSERT INTO Author
VALUES('807-91-6654', 'Panteley', 'Sylvia',
'301 946-8853', '1956 Arlington Pl.', 'Rockville', 'MD', '20853')
;
INSERT INTO Author
VALUES('893-72-1158', 'McBadden', 'Heather',
'707 448-4982', '301 Putnam', 'Vacaville', 'CA', '95688')
;
INSERT INTO Author
VALUES('724-08-9931', 'Stringer', 'Dirk',
'415 843-2991', '5420 Telegraph Av.', 'Oakland', 'CA', '94609')
;
INSERT INTO Author
VALUES('274-80-9391', 'Straight', 'Nathan',
'415 834-2919', '5420 College Av.', 'Oakland', 'CA', '94609')
;
INSERT INTO Author
VALUES('756-30-7391', 'Karsen', 'Livia',
'415 534-9219', '5720 McAuley St.', 'Oakland', 'CA', '94609')
;
INSERT INTO Author
VALUES('724-80-9391', 'MacFeather', 'Stearns',
'415 354-7128', '44 Upland Hts.', 'Oakland', 'CA', '94612')
;
INSERT INTO Author
VALUES('427-17-2319', 'Dull', 'Annabelle',
'415 836-7128', '3410 Cairns St.', 'Palo Alto', 'CA', '94301')
;
INSERT INTO Author
VALUES('672-71-3249', 'Yokomoto', 'Akiko',
'415 935-4228', '3 Silver Ct.', 'Walnut Creek', 'CA', '94595')
;
INSERT INTO Author
VALUES('267-41-2394', 'O''Leary', 'Michael',
'408 286-2428', '22 Cleveland Av. #14', 'San Jose', 'CA', '95128')
;
INSERT INTO Author
VALUES('472-27-2349', 'Gringlesby', 'Burt',
'707 938-6445', 'PO Box 792', 'Covelo', 'CA', '95428')
;
INSERT INTO Author
VALUES('527-72-3246', 'Greene', 'Morningstar',
'615 297-2723', '22 Graybar Rd.', 'Nashville', 'TN', '37215')
;
INSERT INTO Author
VALUES('172-32-1176', 'White', 'David',
'408 496-7223', '10932 Blues Rd.', 'Menlo Park', 'CA', '94025')
;
INSERT INTO Author
VALUES('712-45-1867', 'del Castillo', 'Innes',
'615 996-8275', '2286 Cram Pl. #86', 'Ann Arbor', 'MI', '48105')
;
INSERT INTO Author
VALUES('846-92-7186', 'Hunter', 'Sheryl',
'415 836-7128', '3410 Cairns St.', 'Palo Alto', 'CA', '94301')
;
INSERT INTO Author
VALUES('486-29-1786', 'Locksley', 'Christie',
'415 585-4620', '18 Broadway Av.', 'San Francisco', 'CA', '94130')
;
INSERT INTO Author
VALUES('648-92-1872', 'Blotchet-Halls', 'Reginald',
'503 745-6402', '55 Hillsdale Bl.', 'Corvallis', 'OR', '97330')
;
INSERT INTO Author
VALUES('341-22-1782', 'Smith', 'Meander',
'913 843-0462', '10 Misisipi Dr.', 'Lawrence', 'KS', '66044')
;
INSERT INTO Publisher
VALUES('0736', 'New Age Books', '1 1st St','Boston', 'MA')
;
INSERT INTO Publisher
VALUES('0877', 'Binnet and Hardley','2 2nd Ave.', 'Washington', 'DC')
;
INSERT INTO Publisher
VALUES('1389', 'Algodata Infosystems', '3 3rd Dr.','Berkeley', 'CA')
;
INSERT INTO Title
VALUES('PC8888', 'Secrets of Silicon Valley',
'popular_comp', '1389', 40.00, 8000.00, 4095,1,
'Muckraking reporting on the world''s largest computer hardware and software manufacturers.',
'06/12/1998')
;
INSERT INTO Title
VALUES('BU1032', 'The Busy Executive''s Database Guide',
'business', '1389', 29.99, 5000.00, 4095, 1,
'An overview of available database systems with emphasis on common business applications.  Illustrated.',
'06/12/1998')
;
INSERT INTO Title
VALUES('PS7777', 'Emotional Security: A New Algorithm',
'psychology', '0736', 17.99, 4000.00, 3336, 1,
'Protecting yourself and your loved ones from undue emotional stress in the modern world.  Use of computer and nutritional aids emphasized.',
'06/12/1998')
;
INSERT INTO Title
VALUES('PS3333', 'Prolonged Data Deprivation: Four Case Studies',
'psychology', '0736', 29.99, 2000.00, 4072,1,
'What happens when the data runs dry?  Searching evaluations of information-shortage effects.',
'06/12/1998')
;
INSERT INTO Title
VALUES('BU1111', 'Cooking with Computers: Surreptitious Balance Sheets',
'business', '1389', 21.95, 5000.00, 3876, 1,
'Helpful hints on how to use your electronic resources to the best advantage.', 
'06/09/1998')
;
INSERT INTO Title
VALUES('MC2222', 'Silicon Valley Gastronomic Treats',
'mod_cook', '0877', 29.99, 0.00, 2032, 1,
 'Favorite recipes for quick, easy, and elegant meals tried and tested by people who never have time to eat, let alone cook.',
'06/09/1998')
;
INSERT INTO Title
VALUES('TC7777', 'Sushi, Anyone?',
'trad_cook', '0877', 29.99, 8000.00, 4095, 1,
'Detailed instructions on improving your position in life by learning how to make authentic Japanese sushi in your spare time. 5-10% increase in number of friends per recipe reported from beta test. ',
'06/12/1998')
;
INSERT INTO Title
VALUES('TC4203', 'Fifty Years in Buckingham Palace Kitchens',
'trad_cook', '0877', 21.95, 4000.00, 15096, 1,
'More anecdotes from the Queen''s favorite cook describing life among English royalty.  Recipes, techniques, tender vignettes.',
'06/12/1998')
;
INSERT INTO Title
VALUES('PC1035', 'But Is It User Friendly?',
'popular_comp', '1389', 42.95, 7000.00, 8780, 1,
'A survey of software for the naive user, focusing on the ''friendliness'' of each.',
'06/30/1998')
;
INSERT INTO Title
VALUES('BU2075', 'You Can Combat Computer Stress!',
'business', '0736', 12.99, 10125.00, 18722, 1,
'The latest medical and psychological techniques for living with the electronic office.  Easy-to-understand explanations.',
'06/30/1998')
;
INSERT INTO Title
VALUES('PS2091', 'Is Anger the Enemy?',
'psychology', '0736', 21.95, 2275.00, 2045, 1,
'Carefully researched study of the effects of strong emotions on the body. Metabolic charts included.',
'06/15/1998')
;
INSERT INTO Title
VALUES('PS2106', 'Life Without Fear',
'psychology', '0736', 17.00, 6000.00, 111, 1,
'New exercise, meditation, and nutritional techniques that can reduce the shock of daily interactions. Popular audience.  Sample menus included, exercise video available separately.',
'10/05/1998')
;
INSERT INTO Title
VALUES('MC3021', 'The Gourmet Microwave',
'mod_cook', '0877', 12.99, 15000.00, 22246, 1,
'Traditional French gourmet recipes adapted for modern microwave cooking.',
'06/18/1998')
;
INSERT INTO Title
VALUES('TC3218',
'Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean',
'trad_cook', '0877', 40.95, 7000.00, 375, 1,
'Profusely illustrated in color, this makes a wonderful gift book for a cuisine-oriented friend.',
'10/21/1998')
;
INSERT INTO Title (titleID, title, pubID, contract)
VALUES('MC3026', 'The Psychology of Computer Cooking', '0877', 0)
;
INSERT INTO Title
VALUES('BU7832', 'Straight Talk About Computers',
'business', '1389', 29.99, 5000.00, 4095, 1,
'Annotated analysis of what computers can do for you: a no-hype guide for the critical user.',
'06/22/1998')
;
INSERT INTO Title
VALUES('PS1372',
'Computer Phobic and Non-Phobic Individuals: Behavior Variations',
'psychology', '0736', 41.59, 7000.00, 375, 1,
'A must for the specialist, this book examines the difference between those who hate and fear computers and those who think they are swell.',
'10/21/1998')
;
INSERT INTO Title (titleID, title, type, pubID, contract, notes)
VALUES('PC9999', 'Net Etiquette', 'popular_comp', '1389', 0,
'A must-read for computer conferencing debutantes!.')
;
INSERT INTO Roysched
VALUES('BU1032', 0, 5000, .10)
;
INSERT INTO Roysched
VALUES('BU1032', 5001, 50000, .12)
;
INSERT INTO Roysched
VALUES('PC1035', 0, 2000, .10)
;
INSERT INTO Roysched
VALUES('PC1035', 2001, 4000, .12)
;
INSERT INTO Roysched
VALUES('PC1035', 4001, 50000, .16)
;
INSERT INTO Roysched
VALUES('BU2075', 0, 1000, .10)
;
INSERT INTO Roysched
VALUES('BU2075', 1001, 5000, .12)
;
INSERT INTO Roysched
VALUES('BU2075', 5001, 7000, .16)
;
INSERT INTO Roysched
VALUES('BU2075', 7001, 50000, .18)
;
INSERT INTO Roysched
VALUES('PS2091', 0, 1000, .10)
;
INSERT INTO Roysched
VALUES('PS2091', 1001, 5000, .12)
;
INSERT INTO Roysched
VALUES('PS2091', 5001, 50000, .14)
;
INSERT INTO Roysched
VALUES('PS2106', 0, 2000, .10)
;
INSERT INTO Roysched
VALUES('PS2106', 2001, 5000, .12)
;
INSERT INTO Roysched
VALUES('PS2106', 5001, 50000, .14)
;
INSERT INTO Roysched
VALUES('MC3021', 0, 1000, .10)
;
INSERT INTO Roysched
VALUES('MC3021', 1001, 2000, .12)
;
INSERT INTO Roysched
VALUES('MC3021', 2001, 6000, .14)
;
INSERT INTO Roysched
VALUES('MC3021', 6001, 8000, .18)
;
INSERT INTO Roysched
VALUES('MC3021', 8001, 50000, .20)
;
INSERT INTO Roysched
VALUES('TC3218', 0, 2000, .10)
;
INSERT INTO Roysched
VALUES('TC3218', 2001, 6000, .12)
;
INSERT INTO Roysched
VALUES('TC3218', 6001, 8000, .16)
;
INSERT INTO Roysched
VALUES('TC3218', 8001, 50000, .16)
;
INSERT INTO Roysched
VALUES('PC8888', 0, 5000, .10)
;
INSERT INTO Roysched
VALUES('PC8888', 5001, 50000, .12)
;
INSERT INTO Roysched
VALUES('PS7777', 0, 5000, .10)
;
INSERT INTO Roysched
VALUES('PS7777', 5001, 50000, .12)
;
INSERT INTO Roysched
VALUES('PS3333', 0, 5000, .10)
;
INSERT INTO Roysched
VALUES('PS3333', 5001, 50000, .12)
;
INSERT INTO Roysched
VALUES('MC3026', 0, 1000, .10)
;
INSERT INTO Roysched
VALUES('MC3026',1001, 2000, .12)
;
INSERT INTO Roysched
VALUES('MC3026', 2001, 6000, .14)
;
INSERT INTO Roysched
VALUES('MC3026', 6001, 8000, .18)
;
INSERT INTO Roysched
VALUES('MC3026', 8001, 50000, .20)
;
INSERT INTO Roysched
VALUES('BU1111', 0, 4000, .10)
;
INSERT INTO Roysched
VALUES('BU1111', 4001, 8000, .12)
;
INSERT INTO Roysched
VALUES('BU1111', 8001, 50000, .14)
;
INSERT INTO Roysched
VALUES('MC2222', 0, 2000, .10)
;
INSERT INTO Roysched
VALUES('MC2222', 2001, 4000, .12)
;
INSERT INTO Roysched
VALUES('MC2222', 4001, 8000, .14)
;
INSERT INTO Roysched
VALUES('MC2222', 8001, 12000, .16)
;
INSERT INTO Roysched
VALUES('TC7777', 0, 5000, .10)
;
INSERT INTO Roysched
VALUES('TC7777', 5001, 15000, .12)
;
INSERT INTO Roysched
VALUES('TC4203', 0, 2000, .10)
;
INSERT INTO Roysched
VALUES('TC4203', 2001, 8000, .12)
;
INSERT INTO Roysched
VALUES('TC4203', 8001, 16000, .14)
;
INSERT INTO Roysched
VALUES('BU7832', 0, 5000, .10)
;
INSERT INTO Roysched
VALUES('BU7832', 5001, 50000, .12)
;
INSERT INTO Roysched
VALUES('PS1372', 0, 50000, .10)
;
INSERT INTO TitleAuthor
VALUES('409-56-7008', 'BU1032', 1, .60)
;
INSERT INTO TitleAuthor
VALUES('486-29-1786', 'PS7777', 1, 1.00)
;
INSERT INTO TitleAuthor
VALUES('486-29-1786', 'PC9999', 1, 1.00)
;
INSERT INTO TitleAuthor
VALUES('712-45-1867', 'MC2222', 1, 1.00)
;
INSERT INTO TitleAuthor
VALUES('172-32-1176', 'PS3333', 1, 1.00)
;
INSERT INTO TitleAuthor
VALUES('213-46-8915', 'BU1032', 2, .40)
;
INSERT INTO TitleAuthor
VALUES('238-95-7766', 'PC1035', 1, 1.00)
;
INSERT INTO TitleAuthor
VALUES('213-46-8915', 'BU2075', 1, 1.00)
;
INSERT INTO TitleAuthor
VALUES('998-72-3567', 'PS2091', 1, .50)
;
INSERT INTO TitleAuthor
VALUES('899-46-2035', 'PS2091', 2, .50)
;
INSERT INTO TitleAuthor
VALUES('998-72-3567', 'PS2106', 1, 1.00)
;
INSERT INTO TitleAuthor
VALUES('722-51-5454', 'MC3021', 1, .75)
;
INSERT INTO TitleAuthor
VALUES('899-46-2035', 'MC3021', 2, .25)
;
INSERT INTO TitleAuthor
VALUES('807-91-6654', 'TC3218', 1, 1.00)
;
INSERT INTO TitleAuthor
VALUES('274-80-9391', 'BU7832', 1, 1.00)
;
INSERT INTO TitleAuthor
VALUES('427-17-2319', 'PC8888', 1, .50)
;
INSERT INTO TitleAuthor
VALUES('846-92-7186', 'PC8888', 2, .50)
;
INSERT INTO TitleAuthor
VALUES('756-30-7391', 'PS1372', 1, .75)
;
INSERT INTO TitleAuthor
VALUES('724-80-9391', 'PS1372', 2, .25)
;
INSERT INTO TitleAuthor
VALUES('724-80-9391', 'BU1111', 1, .60)
;
INSERT INTO TitleAuthor
VALUES('267-41-2394', 'BU1111', 2, .40)
;
INSERT INTO TitleAuthor
VALUES('672-71-3249', 'TC7777', 1, .40)
;
INSERT INTO TitleAuthor
VALUES('267-41-2394', 'TC7777', 2, .30)
;
INSERT INTO TitleAuthor
VALUES('472-27-2349', 'TC7777', 3, .30)
;
INSERT INTO TitleAuthor
VALUES('648-92-1872', 'TC4203', 1, 1.00)
;
INSERT INTO Editor
VALUES('993-86-0420', 'McCann', 'Dennis', 'acquisition',
'301 468-3909', '32 Rockbill Pike', 'Rockbill', 'MD', '20852', null )
;
INSERT INTO Editor
VALUES('943-88-7920', 'Kaspchek', 'Christof', 'acquisition',
'415 549-3909', '18 Severe Rd.', 'Berkeley', 'CA', '94710', null)
;
INSERT INTO Editor
VALUES( '321-55-8906', 'DeLongue', 'Martinella', 'project',
'415 843-2222', '3000 6th St.', 'Berkeley', 'CA', '94710', '993-86-0420' )
;
INSERT INTO Editor
VALUES('826-11-9034', 'Himmel', 'Eleanore', 'project',
'617 423-0552', '97 Bleaker', 'Boston', 'MA', '02210', '993-86-0420' )
;
INSERT INTO Editor
VALUES( '527-72-3246', 'Greene', 'Morningstar', 'copy',          
'615 297-2723', '22 Graybar House Rd.', 'Nashville', 'TN','37215', '826-11-9034' )
;
INSERT INTO Editor
VALUES( '712-45-1867', 'del Castillo', 'Innes', 'copy',
'615 996-8275', '2286 Cram Pl. #86', 'Ann Arbor', 'MI', '48105', '826-11-9034' )
;
INSERT INTO Editor
VALUES('777-02-9831', 'Samuelson', 'Bernard', 'project',
'415 843-6990', '27 Yosemite', 'Oakland', 'CA', '94609', '993-86-0420' )
;
INSERT INTO Editor
VALUES('777-66-9902', 'Almond', 'Alfred', 'copy',
'312 699-4177', '1010 E. Devon', 'Chicago', 'IL', '60018', '826-11-9034' )
;
INSERT INTO Editor
VALUES('885-23-9140', 'Rutherford-Hayes', 'Hannah', 'project',
'301 468-3909', '32 Rockbill Pike', 'Rockbill', 'MD', '20852', '993-86-0420' )
;
INSERT INTO TitleEditor VALUES
('826-11-9034', 'BU2075', 2)
;
INSERT INTO TitleEditor VALUES
('826-11-9034', 'PS2091', 2)
;
INSERT INTO TitleEditor VALUES
('826-11-9034', 'PS2106', 2)
;
INSERT INTO TitleEditor VALUES
('826-11-9034', 'PS3333', 2)
;
INSERT INTO TitleEditor VALUES
('826-11-9034', 'PS7777', 2)
;
INSERT INTO TitleEditor VALUES
('826-11-9034', 'PS1372', 2)
;
INSERT INTO TitleEditor VALUES
('885-23-9140', 'MC2222', 2)
;
INSERT INTO TitleEditor VALUES
('885-23-9140', 'MC3021', 2)
;
INSERT INTO TitleEditor VALUES
('885-23-9140', 'TC3218', 2)
;
INSERT INTO TitleEditor VALUES
('885-23-9140', 'TC4203', 2)
;
INSERT INTO TitleEditor VALUES
('885-23-9140', 'TC7777', 2)
;
INSERT INTO TitleEditor VALUES
('321-55-8906', 'BU1032', 2)
;
INSERT INTO TitleEditor VALUES
('321-55-8906', 'BU1111', 2)
;
INSERT INTO TitleEditor VALUES
('321-55-8906', 'BU7832', 2)
;
INSERT INTO TitleEditor VALUES
('321-55-8906', 'PC1035', 2)
;
INSERT INTO TitleEditor VALUES
('321-55-8906', 'PC8888', 2)
;
INSERT INTO TitleEditor VALUES
('321-55-8906', 'BU2075', 3)
;
INSERT INTO TitleEditor VALUES
('777-02-9831', 'PC1035', 3)
;
INSERT INTO TitleEditor VALUES
('777-02-9831', 'PC8888', 3)
;
INSERT INTO TitleEditor VALUES
('943-88-7920', 'BU1032', 1)
;
INSERT INTO TitleEditor VALUES
('943-88-7920', 'BU1111', 1)
;
INSERT INTO TitleEditor VALUES
('943-88-7920', 'BU2075', 1)
;
INSERT INTO TitleEditor VALUES
('943-88-7920', 'BU7832', 1)
;
INSERT INTO TitleEditor VALUES
('943-88-7920', 'PC1035', 1)
;
INSERT INTO TitleEditor VALUES
('943-88-7920', 'PC8888', 1)
;
INSERT INTO TitleEditor VALUES
('993-86-0420', 'PS1372', 1)
;
INSERT INTO TitleEditor VALUES
('993-86-0420', 'PS2091', 1)
;
INSERT INTO TitleEditor VALUES
('993-86-0420', 'PS2106', 1)
;
INSERT INTO TitleEditor VALUES
('993-86-0420', 'PS3333', 1)
;
INSERT INTO TitleEditor VALUES
('993-86-0420', 'PS7777', 1)
;
INSERT INTO TitleEditor VALUES
('993-86-0420', 'MC2222', 1)
;
INSERT INTO TitleEditor VALUES
('993-86-0420', 'MC3021', 1)
;
INSERT INTO TitleEditor VALUES
('993-86-0420', 'TC3218', 1)
;
INSERT INTO TitleEditor VALUES
('993-86-0420', 'TC4203', 1)
;
INSERT INTO TitleEditor VALUES
('993-86-0420', 'TC7777', 1)
;
INSERT INTO Sale
VALUES(1,'7066', 'QA7442.3', '09/13/1998')
;
INSERT INTO Sale
VALUES(2,'7067', 'D4482', '09/14/1998')
;
INSERT INTO Sale
VALUES(3,'7131', 'N914008', '09/14/1998')
;
INSERT INTO Sale
VALUES(4,'7131', 'N914014', '09/14/1998')
;
INSERT INTO Sale
VALUES(5,'8042', '423LL922', '09/14/1998')
;
INSERT INTO Sale
VALUES(6,'8042', '423LL930', '09/14/1998')
;
INSERT INTO Sale
VALUES(7, '6380', '722a', '09/13/1998')
;
INSERT INTO Sale
VALUES(8,'6380', '6871', '09/14/1998')
;
INSERT INTO Sale
VALUES(9,'8042','P723', '03/11/2001')
;
INSERT INTO Sale
VALUES(19,'7896','X999', '02/21/2001')
;
INSERT INTO Sale
VALUES(10,'7896','QQ2299', '10/28/2000')
;
INSERT INTO Sale
VALUES(11,'7896','TQ456', '12/12/2000')
;
INSERT INTO Sale
VALUES(12,'8042','QA879.1', '5/22/2000')
;
INSERT INTO Sale
VALUES(13,'7066','A2976', '5/24/2000')
;
INSERT INTO Sale
VALUES(14,'7131','P3087a', '5/29/2000')
;
INSERT INTO Sale
VALUES(15,'7067','P2121', '6/15/2000')
;
INSERT INTO SalesDetail
VALUES(1, 75, 75,'PS2091', '9/15/1998')
;
INSERT INTO SalesDetail
VALUES(2, 10, 10,'PS2091', '9/15/1998')
;
INSERT INTO SalesDetail
VALUES(3, 20, 720,'PS2091', '9/18/1998')
;
INSERT INTO SalesDetail
VALUES(4, 25, 20,'MC3021', '9/18/1998')
;
INSERT INTO SalesDetail
VALUES(5, 15, 15,'MC3021', '9/14/1998')
;
INSERT INTO SalesDetail
VALUES(6, 10, 3,'BU1032', '9/22/1998')
;
INSERT INTO SalesDetail
VALUES(7, 3, 3,'PS2091', '9/20/1998')
;
INSERT INTO SalesDetail
VALUES(8, 5, 5,'BU1032', '9/14/1998')
;
INSERT INTO SalesDetail
VALUES(9, 25, 5,'BU1111', '03/28/2001')
;
INSERT INTO SalesDetail
VALUES(19, 35, 35,'BU2075', '03/15/2001')
;
INSERT INTO SalesDetail
VALUES(10, 15, 15,'BU7832', '10/29/2000')
;
INSERT INTO SalesDetail
VALUES(11, 10, 10,'MC2222', '1/12/2001')
;
INSERT INTO SalesDetail
VALUES(12, 30, 30,'PC1035', '5/24/2000')
;
INSERT INTO SalesDetail
VALUES(13, 50, 50,'PC8888', '5/24/2000')
;
INSERT INTO SalesDetail
VALUES(14, 20, 20,'PS1372', '5/29/2000')
;
INSERT INTO SalesDetail
VALUES(14, 25, 25,'PS2106', '4/29/2000')
;
INSERT INTO SalesDetail
VALUES(14, 15, 10,'PS3333', '5/29/2000')
;
INSERT INTO SalesDetail
VALUES(14, 25, 25,'PS7777', '6/13/2000')
;
INSERT INTO SalesDetail
VALUES(15, 40, 40,'TC3218', '6/15/2000')
;
INSERT INTO SalesDetail
VALUES(15, 20, 20,'TC4203', '5/30/2000')
;
INSERT INTO SalesDetail
VALUES(15, 20, 10,'TC7777', '6/17/2000')
;
COMMIT;

--Turn on variable substitution sign for Oracle.
set scan on;
--set date format for Oracle with alter session:
alter session set nls_date_format = 'DD-MON-YY';

