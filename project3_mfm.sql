-- run the project 2 SQL file
start 'C:\Users\saadi\OneDrive\Desktop\faizanmirza\3304_Proj3StarterFile_sp2025.sql'

-- include the full path. This will create and output and start logging to the specified file.
spool 'C:\Users\saadi\OneDrive\Desktop\faizanmirza\project3_mfm.txt'

-- This will ensure that all input and output is logged to the file
set echo on 

-- Mohammad Faizan Mirza
-- INSY 3304-001
-- Project 3

-- Part I
/* 1. All column headings must show in their entirety-- no truncated coloumn headings
only needed on CHAR and VARCHAR data types
Note: Wait until after you've completed queries in Part 2, so you'll know which columns need to be formatted */
COLUMN "SalesRepFirstName" FORMAT A18
COLUMN "SalesRepLastName" FORMAT A18
COLUMN "AvgCommRate" FORMAT A15
COLUMN "Avg_Price" FORMAT A12
COLUMN "Cust ID" FORMAT A10
COLUMN "CustID" FORMAT A10
COLUMN "Customer ID" FORMAT A12
COLUMN "OrderDate" FORMAT A10
COLUMN "Commission_Class" FORMAT A18
COLUMN "Commission Class" FORMAT A19
COLUMN "CommClass" FORMAT A10

-- 2. Line size should be set to at least 125 and no more than 150 to minimize column wrapping.
SET LINESIZE 150

-- 3. Properly use table aliases and dot notation where applicable.
-- No code goes here for this--it will be done throughout Part II  

-- 4. Add a new Customer 
INSERT INTO CUSTOMER_mfm
VALUES ('T104', 'Wes', 'Thomas', '4695551215', 22);

-- 5. Add a new Product 
INSERT INTO PRODUCT_mfm
VALUES (246, 'Milwaukee Power Drill', 2, 179);

-- 6. Add a new Order. Generate the OrderID by incrementing the max OrderID by 1.
INSERT INTO ORDER_mfm
VALUES ((SELECT MAX(OrderID) + 1 FROM ORDER_mfm), '28-JAN-2022', 'T104');

-- Add OrderDetails using the OrderID for the new Order above:
INSERT INTO ORDERDETAIL_mfm 
VALUES ((SELECT MAX(OrderID) FROM ORDER_mfm), 618, 1, 
		(SELECT ProdPrice FROM PRODUCT_mfm WHERE ProdID = 618));

INSERT INTO ORDERDETAIL_mfm 
VALUES ((SELECT MAX(OrderID) FROM ORDER_mfm), 407, 2, 
		(SELECT ProdPrice FROM PRODUCT_mfm WHERE ProdID = 407));

INSERT INTO ORDERDETAIL_mfm 
VALUES ((SELECT MAX(OrderID) FROM ORDER_mfm), 124, 1, 
		(SELECT ProdPrice FROM PRODUCT_mfm WHERE ProdID = 124));

 -- 7. Add a new Order. Generate the OrderID by incrementing the max OrderID by 1.
INSERT INTO ORDER_mfm
VALUES ((SELECT MAX(OrderID) + 1 FROM ORDER_mfm), '29-JAN-2022', 'S100');

-- Add OrderDetails using the OrderID for the new Order above:
INSERT INTO ORDERDETAIL_mfm 
VALUES ((SELECT MAX(OrderID) FROM ORDER_mfm), 535, 3,
		(SELECT ProdPrice FROM PRODUCT_mfm WHERE ProdID = 535));

INSERT INTO ORDERDETAIL_mfm 
VALUES ((SELECT MAX(OrderID) FROM ORDER_mfm), 246, 1, 
		(SELECT ProdPrice FROM PRODUCT_mfm WHERE ProdID = 246));

INSERT INTO ORDERDETAIL_mfm 
VALUES ((SELECT MAX(OrderID) FROM ORDER_mfm), 124, 1, 
		(SELECT ProdPrice FROM PRODUCT_mfm WHERE ProdID = 124));

-- 8. Change the Phone Number for Customer B200 to 8175558918
UPDATE CUSTOMER_mfm
	SET CustPhone = '8175558918'
	WHERE CustID = 'B200';

-- 9. Commit all changes above before proceeding to the next step. 
COMMIT; 




-- Part II
-- 1.
SELECT SalesRepFName || ' ' || SalesRepLName AS "SalesRep Name",  
       SalesRepID AS "Sales Rep ID",  
       SALESREP_mfm.CommClass AS "Commission Class",  
       CommRate AS "Commission Rate"  
FROM SALESREP_mfm, COMMISSION_mfm
WHERE SALESREP_mfm.CommClass = COMMISSION_mfm.CommClass  
ORDER BY SalesRepLName ;

-- 2.
SELECT OrderID AS "Order ID",  
       ProdID AS "Product ID",  
       ProdQty AS "Qty",  
       TO_CHAR(ProdPrice, '$999.99') AS "Price"  
FROM ORDERDETAIL_mfm  
ORDER BY OrderID, ProdID ;

-- 3. 
SELECT CustID AS "CustID", CustFName AS "CustFirstName", CustLName AS "CustLastName", '(' || SUBSTR(CustPhone, 1, 3) || ') ' || SUBSTR(CustPhone, 4, 3) 
	|| '-' || SUBSTR(CustPhone, 7, 4) AS "CustPhone", S.SalesRepID AS "SalesRepID", SalesRepFName AS "SalesRepFirstName",
	SalesRepLName AS "SalesRepLastName" 
	FROM CUSTOMER_mfm C, SALESREP_mfm S
	WHERE C.SalesRepID = S.SalesRepID
	ORDER BY CustID ;

-- 4. 
SELECT D.DeptID AS "Dept_ID", DeptName AS "Dept_Name", SalesRepID AS "Sales_Rep_ID" , SalesRepFName AS "First_Name",
 SalesRepLName AS "Last_Name", S.CommClass AS "Commission_Class", CommRate AS "Commission_Rate"
	FROM SALESREP_mfm S, COMMISSION_mfm COM, DEPARTMENT_mfm D 
	WHERE D.DeptID = S.DeptID AND 
		COM.CommClass = S.CommClass AND
		(D.DeptID, CommRate) IN
		(SELECT DeptID, MAX(CommRate)
			FROM SALESREP_mfm, COMMISSION_mfm
			WHERE SALESREP_mfm.CommClass = COMMISSION_mfm.CommClass
			GROUP BY DeptID) ;

-- 5.
SELECT P.ProdID AS "Product_ID", ProdName AS "Product_Name", ProdCatName AS "Category", TO_CHAR(P.ProdPrice, '$999.99') AS "Price" 
	FROM PRODCAT_mfm PC, PRODUCT_mfm P, ORDERDETAIL_mfm OD
	WHERE P.ProdID = OD.ProdID AND
	P.ProdCatID = PC.ProdCatID AND 
	OD.OrderID = 100 AND 
	(P.ProdPrice) IN
	(SELECT MAX(P.ProdPrice)
		FROM PRODUCT_mfm PR, ORDERDETAIL_mfm ORD
		WHERE PR.ProdID = ORD.ProdID AND
		ORD.OrderID = 100) ;

-- 6. 
SELECT DeptName AS "Dept_Name", COUNT(SalesRepID) AS "Sales_Rep_Count"
	FROM DEPARTMENT_mfm, SALESREP_mfm
	WHERE DEPARTMENT_mfm.DeptID = SALESREP_mfm.DeptID
	GROUP BY DeptName
	ORDER BY "Sales_Rep_Count" ;

COLUMN "Commission_Rate" FORMAT A19

-- 7. 
SELECT SalesRepID AS "Sales_Rep_ID", SalesRepFName AS "First_Name", SalesRepLName AS "Last_Name", TO_CHAR(CommRate * 100, '990.00') || '%' AS "Commission_Rate"
	FROM SALESREP_mfm SR, COMMISSION_mfm COM
	WHERE SR.CommClass = COM.CommClass AND
	CommRate <= 0.05 AND 
	CommRate > 0 
	ORDER BY CommRate DESC ;

-- 8.
SELECT OrderID, TO_CHAR(OrderDate, 'MM/DD/YY') AS "OrderDate", O.CustID, CustFName, CustLName, SR.SalesRepID, SalesRepFName, SalesRepLName
	FROM ORDER_mfm O, CUSTOMER_mfm C, SALESREP_mfm SR
	WHERE O.CustID = C.CustID AND
	C.SalesRepID = SR.SalesRepID
	ORDER BY OrderID ;

-- 9.
SELECT OrderID AS "OrderID", OD.ProdID AS "ProdID", ProdName AS "ProdName", ProdCatID AS "CatID", TO_CHAR(OD.ProdPrice, '$9,999.99') AS "Price", 
	ProdQty AS "Qty", TO_CHAR(OD.ProdPrice * ProdQty, '$999,999.99') AS "ExtPrice"
	FROM ORDERDETAIL_mfm OD, PRODUCT_mfm P
	WHERE OD.ProdID = P.ProdID AND  
	OrderID = 104
	ORDER BY "ExtPrice" ;

-- 10. 
SELECT D.DeptID AS "DeptID", DeptName AS "DeptName", COUNT(SalesRepID) AS "SalesRepCount", TO_CHAR(AVG(CommRate) * 100, '990.00') || '%' AS "AvgCommRate"
	FROM DEPARTMENT_mfm D, SALESREP_mfm SR, COMMISSION_mfm COM
	WHERE D.DeptID = SR.DeptID AND
	COM.CommClass = SR.CommClass
	GROUP BY D.DeptID, DeptName
	ORDER BY AVG(CommRate) ;

-- 11. 
SELECT SalesRepID, SalesRepFName, SalesRepLName, DeptName, SR.CommClass, CommRate
	FROM SALESREP_mfm SR, COMMISSION_mfm COM, DEPARTMENT_mfm D
	WHERE SR.CommClass = COM.CommClass AND
	SR.DeptID = D.DeptID AND
	CommRate > 0 
	ORDER BY SalesRepID ;

-- 12.
SELECT SalesRepID, SalesRepFName || ' ' || SalesRepLName AS "SalesRep_Name", SR.DeptID, DeptName
	FROM SALESREP_mfm SR, DEPARTMENT_mfm D
	WHERE SR.DeptID = D.DeptID AND
	CommClass = 'A'
	ORDER BY SR.DeptID, SalesRepID ;

-- 13. 
 SELECT OrderID AS "Order_ID", TO_CHAR(SUM(ProdPrice * ProdQty), '$999,999.99') AS "Order_Total"
 	FROM ORDERDETAIL_mfm 
 	WHERE OrderID = 104
 	GROUP BY OrderID ;

 -- 14.
 SELECT TO_CHAR(AVG(ProdPrice), '$999.99') AS "Avg_Price"
 	FROM ORDERDETAIL_mfm ;

 -- 15.
SELECT P.ProdID AS "ProductID", ProdName AS "Name", TO_CHAR(P.ProdPrice, '$999.99') AS "Price"
  FROM PRODUCT_mfm P, ORDERDETAIL_mfm OD
 WHERE P.ProdID = OD.ProdID
 GROUP BY P.ProdID, ProdName, P.ProdPrice
HAVING COUNT(DISTINCT OrderID) = (
         SELECT MAX(OrderCount)
           FROM (SELECT COUNT(DISTINCT OrderID) AS OrderCount
                   FROM ORDERDETAIL_mfm
                  GROUP BY ProdID));

-- 16.
SELECT ProdCatID AS "Cat_ID", ProdID AS "Prod_ID", ProdName AS "Prod_Name", TO_CHAR(ProdPrice, '$999.99') AS "Price"
  	FROM PRODUCT_mfm
	WHERE (ProdCatID, ProdPrice) IN (
         SELECT ProdCatID, MIN(ProdPrice)
           	FROM PRODUCT_mfm
          	GROUP BY ProdCatID);

-- 17. 
SELECT P.ProdID AS "Product_ID",ProdName AS "Product_Name",ProdCatName AS "Category_Name", TO_CHAR(ProdPrice, '$999.99') AS "Price"
	FROM PRODUCT_mfm P, PRODCAT_mfm PC
	WHERE P.ProdCatID = PC.ProdCatID AND 
	ProdPrice > (SELECT AVG(ProdPrice) FROM PRODUCT_mfm);

-- 18. 
SELECT OrderID AS "Order ID", TO_CHAR(OrderDate, 'MM-DD-YYYY') AS "Order Date", C.CustID AS "Cust ID", 
	CustFName || ' ' || CustLName AS "Name", CustPhone AS "Phone"
	FROM ORDER_mfm O, CUSTOMER_mfm C
	WHERE O.CustID = C.CustID AND
	OrderDate <= TO_DATE('1/26/22', 'MM/DD/YY')
	ORDER BY OrderDate, C.CustID;

-- 19.
SELECT CustID AS "CustID", CustFName AS "FirstName", CustLName AS "LastName"
	FROM CUSTOMER_mfm 
	WHERE CustFName LIKE 'A%'
	ORDER BY CustLName ;

-- 20.
SELECT CustID AS "Customer ID", CustFName || ' ' || CustLName AS "Name", 
	SUBSTR(CustPhone, 1,3) || '-' || SUBSTR(CustPhone, 4,3) || '-' || SUBSTR(CustPhone, 7, 4) AS "Phone"
	FROM CUSTOMER_mfm
	WHERE SalesRepID = 12 ;



-- stop logging to the output file
set echo off

-- close and save the output file 
spool off