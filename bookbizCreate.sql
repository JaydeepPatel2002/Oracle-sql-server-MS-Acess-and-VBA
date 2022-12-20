DROP TABLE SalesDetail CASCADE CONSTRAINTS;
DROP TABLE TitleEditor CASCADE CONSTRAINTS;
DROP TABLE Editor CASCADE CONSTRAINTS;
DROP TABLE Sale CASCADE CONSTRAINTS;
DROP TABLE TitleAuthor CASCADE CONSTRAINTS;
DROP TABLE Title CASCADE CONSTRAINTS;
DROP TABLE RoySched CASCADE CONSTRAINTS;
DROP TABLE Publisher CASCADE CONSTRAINTS;
DROP TABLE Author CASCADE CONSTRAINTS;

CREATE TABLE Author
(auID         CHAR(11)       CONSTRAINT Author_auID_pk PRIMARY KEY,
 auLName      VARCHAR2(40)   CONSTRAINT Author_auLName_nn NOT NULL,
 auFName      VARCHAR2(20)   CONSTRAINT Author_auFName_nn NOT NULL,
 phone        CHAR(12),
 address      VARCHAR2(40),
 city         VARCHAR2(20),
 state        CHAR(2),
 zip          CHAR(5)
);

CREATE TABLE Publisher
(pubID        CHAR(4)       CONSTRAINT Publisher_pubID_pk PRIMARY KEY,
 pubName      VARCHAR2(40),
 address      VARCHAR2(40),
 city         VARCHAR2(20),
 state        CHAR(2)
);

CREATE TABLE Title
(titleID      CHAR(6)       CONSTRAINT pk_Title_pk PRIMARY KEY,
 title        VARCHAR2(80)  CONSTRAINT Title_title_nn NOT NULL,
 type         CHAR(12),
 pubID        CHAR(4)       CONSTRAINT Title_Publisher_pubID_fk REFERENCES Publisher(pubID),
 price        NUMBER(9,2),
 advance      NUMBER(9,2),
 ytdSales    NUMBER(38),
 contract     CHAR(1)       CONSTRAINT Title_contract_nn NOT NULL,
 notes        VARCHAR2(200),
 pubdate      DATE
);

CREATE TABLE RoySched
(titleID     CHAR(6)        CONSTRAINT RoySched_titles_nn NOT NULL
			    CONSTRAINT RoySched_titles_fk REFERENCES Title(titleID),
 loRange      NUMBER(38),
 hiRange      NUMBER(38),
 royalty      NUMBER(5,2)
);

CREATE TABLE TitleAuthor
(auID         CHAR(11)      CONSTRAINT TitleAuthor_Author_auID_fk REFERENCES Author(auID),
 titleID      CHAR(6)       CONSTRAINT TitleAuthor_Title_titleID_fk REFERENCES Title(titleID),
 auOrder      NUMBER(10)    CONSTRAINT TitleAuthor_auOrder_nn NOT NULL,
 royaltyShare NUMBER (5,2),
 CONSTRAINT TitleAuthor_auID_titleID_pk PRIMARY KEY (auID, titleID),
 CONSTRAINT Titleauthor_titleID_auOrder_uk UNIQUE (titleID, auOrder)
);

CREATE TABLE Sale
(soNum     NUMBER(38)       CONSTRAINT Sale_soNum_pk PRIMARY KEY,
 storeID      CHAR(4)       CONSTRAINT Sale_storeID_nn NOT NULL,
 poNum        VARCHAR2(20)  CONSTRAINT Sales_poNum_nn NOT NULL,
 saleDate     DATE
);

CREATE TABLE Editor
(edID         CHAR(11)      CONSTRAINT Editor_edID_pk PRIMARY KEY,
 edLName      VARCHAR2(40)  CONSTRAINT Editor_edLName_nn NOT NULL,
 edFName      VARCHAR2(20)  CONSTRAINT Editor_edFName_nn NOT NULL,
 edPos        VARCHAR2(12),
 phone        CHAR(12),
 address      VARCHAR2(40),
 city         VARCHAR2(20),
 state        CHAR(2),
 zip          CHAR(5),
 edBoss       CHAR(11)       CONSTRAINT EditorBoss_edID_fk REFERENCES Editor(edID)
);

CREATE TABLE TitleEditor
(edID        CHAR(11)       CONSTRAINT TitleEditor_Editor_edID_fk REFERENCES Editor(edID),
 titleID     CHAR(6)        CONSTRAINT TitleEditors_Titles_titleID_fk REFERENCES Title(titleID),
 edOrder     NUMBER(10),
 CONSTRAINT TitlEditor PRIMARY KEY (edID, titleID),
 CONSTRAINT TitleEditor_titleID_edOrder_uk UNIQUE (titleID, edOrder)
);

CREATE TABLE SalesDetail
(soNum        NUMBER(38)    CONSTRAINT SalesDetail_Sales_soNum_fk REFERENCES Sale(soNum),
 qtyOrdered   NUMBER(10)    CONSTRAINT SalesDetail_qtyOrderd_nn NOT NULL,
 qtyShipped   NUMBER(10),
 titleID      CHAR(6)       CONSTRAINT SalesDetail_Titles_titleID_fk REFERENCES Title(titleID),
 dateShipped  DATE,
 CONSTRAINT SalesDetail_soNum_titleID_pk PRIMARY KEY (soNum, titleId)
);

CREATE INDEX aunmind ON Author (auLName, auFName);
CREATE INDEX titleind ON Title (title);
CREATE INDEX ednmind ON Editor (edLName, edFName);
CREATE INDEX rstidind ON RoySched (titleID);

