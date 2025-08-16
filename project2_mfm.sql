-- include the full path. This will create and output and start logging to the specified file.
spool 'C:\Users\saadi\OneDrive\Desktop\faizanmirza\project2_mfm.txt'

-- This will ensure that all input and output is logged to the file
set echo on 

-- Mohammad Faizan Mirza
-- INSY 3304-001
-- Project 2

-- DROP ALL TABLES (in the opposite order they are created)
DROP TABLE ORDERDETAIL_mfm ;
DROP TABLE ORDER_mfm ; 
DROP TABLE CUSTOMER_mfm ;
DROP TABLE SALESREP_mfm ;
DROP TABLE PRODUCT_mfm ; 
DROP TABLE DEPARTMENT_mfm ;
DROP TABLE COMMISSION_mfm ;
DROP TABLE PRODCAT_mfm ; 

--IA. Create the tables
CREATE TABLE PRODCAT_mfm (
ProdCatID		NUMBER(2),
ProdCatName		VARCHAR(20)		NOT NULL,
PRIMARY KEY	(ProdCatID)
) ;

CREATE TABLE COMMISSION_mfm (
CommClass		CHAR(1),
CommRate		NUMBER(4,2)		NOT NULL,
PRIMARY KEY (CommClass)
) ;

CREATE TABLE DEPARTMENT_mfm (
DeptID			NUMBER(3),
DeptName		VARCHAR(20)		NOT NULL,
PRIMARY KEY (DeptID)
) ;

CREATE TABLE PRODUCT_mfm (
ProdID			NUMBER(5),
ProdName 		VARCHAR(20)		NOT NULL,
ProdCatID		NUMBER(2)		NOT NULL,
ProdPrice		NUMBER(5,2)		NOT NULL,
PRIMARY KEY (ProdID),
FOREIGN KEY (ProdCatID) REFERENCES PRODCAT_mfm
) ;

CREATE TABLE SALESREP_mfm (
SalesRepID		NUMBER(3),
SalesRepFName	VARCHAR(15) 	NOT NULL,
SalesRepLName	VARCHAR(15) 	NOT NULL,
CommClass		CHAR(1)			NOT NULL,
DeptID			NUMBER(3)		NOT NULL,
PRIMARY KEY (SalesRepID),
FOREIGN KEY (CommClass) REFERENCES COMMISSION_mfm,
FOREIGN KEY (DeptID) REFERENCES DEPARTMENT_mfm
) ;

CREATE TABLE CUSTOMER_mfm (
CustID			VARCHAR(5),
CustFName		VARCHAR(15)		NOT NULL,
CustLName		VARCHAR(15)		NOT NULL,
CustPhone		CHAR(10),
SalesRepID		NUMBER(3)		NOT NULL,
PRIMARY KEY (CustID),
FOREIGN KEY (SalesRepID) REFERENCES SALESREP_mfm
);

CREATE TABLE ORDER_mfm (
OrderID			NUMBER(5),
OrderDate		DATE 			NOT NULL,
CustID 			VARCHAR(5)			NOT NULL,
PRIMARY KEY (OrderID),
FOREIGN KEY (CustID) REFERENCES CUSTOMER_mfm
) ;

CREATE TABLE ORDERDETAIL_mfm (
OrderID 		NUMBER(5),
ProdID 			NUMBER(5),
ProdQty			NUMBER(4)		NOT NULL,
ProdPrice		NUMBER(5,2)		NOT NULL,
PRIMARY KEY (OrderID, ProdID),
FOREIGN KEY (OrderID) REFERENCES ORDER_mfm,
FOREIGN KEY (ProdID) REFERENCES PRODUCT_mfm
) ;

--IB. Describe the Tables
DESCRIBE PRODCAT_mfm
DESCRIBE COMMISSION_mfm
DESCRIBE DEPARTMENT_mfm
DESCRIBE PRODUCT_mfm
DESCRIBE SALESREP_mfm
DESCRIBE CUSTOMER_mfm
DESCRIBE ORDER_mfm
DESCRIBE ORDERDETAIL_mfm

-- IIA. Insert rows into the tables 
-- Insert PRODCAT rows
INSERT INTO PRODCAT_mfm
VALUES (1, 'Hand Tools');

INSERT INTO PRODCAT_mfm
VALUES (2, 'Power Tools');

INSERT INTO PRODCAT_mfm
VALUES (4, 'Fasteners');

INSERT INTO PRODCAT_mfm
VALUES (6, 'Misc');

INSERT INTO PRODCAT_mfm
VALUES (3, 'Measuring Tools');

INSERT INTO PRODCAT_mfm
VALUES (5, 'Hardware');

-- Save all new rows to disk
COMMIT ;

-- Insert COMMISSION rows
INSERT INTO COMMISSION_mfm
VALUES ('A', 0.1);

INSERT INTO COMMISSION_mfm
VALUES ('B', 0.08);

INSERT INTO COMMISSION_mfm
VALUES ('Z', 0);

INSERT INTO COMMISSION_mfm
VALUES ('C', 0.05);

-- Insert DEPARTMENT rows 
INSERT INTO DEPARTMENT_mfm
VALUES (10, 'Store Sales');

INSERT INTO DEPARTMENT_mfm
VALUES (14, 'Corp Sales');

INSERT INTO DEPARTMENT_mfm
VALUES (16, 'Web Sales');

-- Save all new rows to disk
COMMIT ;

-- Insert PRODUCT rows 

INSERT INTO PRODUCT_mfm
VALUES (228, 'Makita Power Drill', 2, 65.00);

INSERT INTO PRODUCT_mfm
VALUES (480, '1# BD Nails', 4, 3.00);

INSERT INTO PRODUCT_mfm
VALUES (407, '1# BD Screws', 4, 4.25);

INSERT INTO PRODUCT_mfm
VALUES (610, '3M Duct Tape', 6, 1.75);

INSERT INTO PRODUCT_mfm
VALUES (618, '3M Masking Tape', 6, 1.25);

INSERT INTO PRODUCT_mfm
VALUES (380, 'Acme Yard', 3, 1.25);

INSERT INTO PRODUCT_mfm
VALUES (121, 'BD Hammer', 1, 7.00);

INSERT INTO PRODUCT_mfm
VALUES (535, 'Schlage Door', 5, 7.50);

INSERT INTO PRODUCT_mfm
VALUES (123, 'Acme Pry Bar', 1, 5.00);

INSERT INTO PRODUCT_mfm
VALUES (124, 'Acme Hammer', 1, 6.50);

INSERT INTO PRODUCT_mfm
VALUES (229, 'BD Power Drill', 2, 59.00);

INSERT INTO PRODUCT_mfm
VALUES (235, 'Makita Power Drill', 2, 65.00);

-- Save all new rows to disk
COMMIT ;

-- Insert SALESREP rows
INSERT INTO SALESREP_mfm
VALUES (10, 'Alice', 'Jones', 'A', 10);

INSERT INTO SALESREP_mfm
VALUES (12, 'Greg', 'Taylor', 'B', 14);

INSERT INTO SALESREP_mfm
VALUES (14, 'Sara', 'Day', 'Z', 10);

INSERT INTO SALESREP_mfm
VALUES (8, 'Kay', 'Price', 'C', 14);

INSERT INTO SALESREP_mfm
VALUES (20, 'Bob', 'Jackson', 'B', 10);

INSERT INTO SALESREP_mfm
VALUES (22, 'Micah', 'Moore', 'Z', 16);

-- Save all new rows to disk
COMMIT ;

-- Insert CUSTOMER rows 
INSERT INTO CUSTOMER_mfm
VALUES ('S100', 'John', 'Smith', '2145551212', 10);

INSERT INTO CUSTOMER_mfm
VALUES ('A120', 'Jane', 'Adams', '8175553434', 12);

INSERT INTO CUSTOMER_mfm
VALUES ('J090', 'Tim', 'Jones', NULL, 14);

INSERT INTO CUSTOMER_mfm
VALUES ('B200', 'Ann', 'Brown', '9725557979', 8);

INSERT INTO CUSTOMER_mfm
VALUES ('G070', 'Kate', 'Green', '8175551034', 20);

INSERT INTO CUSTOMER_mfm
VALUES ('S120', 'Nicole', 'Sims', NULL, 22);

-- Save all new rows to disk
COMMIT ;

-- Insert ORDER rows 
INSERT INTO ORDER_mfm
VALUES (100, '24-JAN-2022', 'S100');

INSERT INTO ORDER_mfm
VALUES (101, '25-JAN-2022', 'A120');

INSERT INTO ORDER_mfm
VALUES (102, '25-JAN-2022', 'J090');

INSERT INTO ORDER_mfm
VALUES (103, '26-JAN-2022', 'B200');

INSERT INTO ORDER_mfm
VALUES (104, '26-JAN-2022', 'S100');

INSERT INTO ORDER_mfm
VALUES (105, '26-JAN-2022', 'B200');

INSERT INTO ORDER_mfm
VALUES (106, '27-JAN-2022', 'G070');

INSERT INTO ORDER_mfm
VALUES (107, '27-JAN-2022', 'J090');

INSERT INTO ORDER_mfm
VALUES (108, '27-JAN-2022', 'S120');

-- Save all new rows to disk
COMMIT ;

-- Insert ORDERDETAIL rows 
INSERT INTO ORDERDETAIL_mfm
VALUES (100, 121, 2, 8.00);

INSERT INTO ORDERDETAIL_mfm
VALUES (100, 228, 1, 65.00);

INSERT INTO ORDERDETAIL_mfm
VALUES (100, 480, 2, 3.00);

INSERT INTO ORDERDETAIL_mfm
VALUES (100, 407, 1, 4.25);

INSERT INTO ORDERDETAIL_mfm
VALUES (101, 610, 200, 1.75);

INSERT INTO ORDERDETAIL_mfm
VALUES (101, 618, 100, 1.25);

INSERT INTO ORDERDETAIL_mfm
VALUES (102, 380, 2, 1.25);

INSERT INTO ORDERDETAIL_mfm
VALUES (102, 121, 1, 7.00);

INSERT INTO ORDERDETAIL_mfm
VALUES (102, 535, 4, 7.50);

INSERT INTO ORDERDETAIL_mfm
VALUES (103, 121, 50, 7.00);

INSERT INTO ORDERDETAIL_mfm
VALUES (103, 123, 20, 6.25);

INSERT INTO ORDERDETAIL_mfm
VALUES (104, 229, 1, 50.00);

INSERT INTO ORDERDETAIL_mfm
VALUES (104, 610, 200, 1.75);

INSERT INTO ORDERDETAIL_mfm
VALUES (104, 380, 2, 1.25);

INSERT INTO ORDERDETAIL_mfm
VALUES (104, 535, 4, 7.50);

INSERT INTO ORDERDETAIL_mfm
VALUES (105, 610, 200, 1.75);

INSERT INTO ORDERDETAIL_mfm
VALUES (105, 123, 40, 5.00);

INSERT INTO ORDERDETAIL_mfm
VALUES (106, 124, 1, 6.50);

INSERT INTO ORDERDETAIL_mfm
VALUES (107, 229, 1, 59.00);

INSERT INTO ORDERDETAIL_mfm
VALUES (108, 235, 1, 65.00);

-- Save all new rows to disk
COMMIT ;

--IIB. List the contents of the tables 
SELECT * FROM PRODCAT_mfm ;
SELECT * FROM COMMISSION_mfm ;
SELECT * FROM DEPARTMENT_mfm ;
SELECT * FROM PRODUCT_mfm ;
SELECT * FROM SALESREP_mfm ;
SELECT * FROM CUSTOMER_mfm ;
SELECT * FROM ORDER_mfm ;
SELECT * FROM ORDERDETAIL_mfm ;


-- III. Make changes to existing data. 
-- Change the phone number of Customer B200 to '2145551234'
UPDATE CUSTOMER_mfm
	SET CustPhone = '2145551234'
	WHERE CustID = 'B200' ;

-- Add Customer G119 (Amanda Green, no phone number), SalesRep 14
INSERT INTO CUSTOMER_mfm
VALUES ('G119', 'Amanda', 'Green', NULL, 14) ;

-- Change the order date for Order 108 to 28-JAN-2022
UPDATE ORDER_mfm
	SET OrderDate = '28-JAN-2022'
	WHERE OrderID = 108 ;

-- Add OrderID 108, OrderDate 28-JAN-2022, CustID G119
INSERT INTO ORDER_mfm
VALUES (108, '28-JAN-2022', 'G119') ;

-- Change the price of Product 235 in order 108 to $62
UPDATE ORDERDETAIL_mfm
	SET ProdPrice = 62.00
	WHERE OrderID = 108 AND ProdID = 235;

-- Add ProdID 407, ProdQty 1, ProdPrice 5.25 to Order 108
INSERT INTO ORDERDETAIL_mfm
VALUES (108, 407, 1, 5.25) ;

-- Add ProdID 618, ProdQty 2, ProdPrice 2.15 to Order 108
INSERT INTO ORDERDETAIL_mfm
VALUES (108, 618, 2, 2.15) ;

-- Add ProdID 121, ProdQty 1, ProdPrice 8.25 to Order 109
INSERT INTO ORDERDETAIL_mfm
VALUES (109, 121, 1, 8.25) ;

-- Add ProdID 480, ProdQty 1, ProdPrice 3.75 to Order 109
INSERT INTO ORDERDETAIL_mfm
VALUES (109, 480, 1, 3.75) ;

-- Save all changes to disk
COMMIT ; 

-- IV. List the contents of all rows and columns from each table, sorting by the PK in ascending order
SELECT * FROM PRODCAT_mfm ORDER BY ProdCatID ;
SELECT * FROM COMMISSION_mfm ORDER BY CommClass ;
SELECT * FROM DEPARTMENT_mfm ORDER BY DeptID ;
SELECT * FROM PRODUCT_mfm ORDER BY ProdID ;
SELECT * FROM SALESREP_mfm ORDER BY SalesRepID ;
SELECT * FROM CUSTOMER_mfm ORDER BY CustID ;
SELECT * FROM ORDER_mfm ORDER BY OrderID ;
SELECT * FROM ORDERDETAIL_mfm ORDER BY OrderID, ProdID ;


-- This will turn off logging.
set echo off

-- This will close   and save the file
spool off