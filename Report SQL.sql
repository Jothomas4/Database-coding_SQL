USE  CS660_DEMO

GO

--CHECK TO SEE IF TABLE EXISTS AND IF SO, DROP AND RECREATE TABLE
IF EXISTS(SELECT 1 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_TYPE = 'BASE TABLE' 
                 AND  TABLE_NAME = 'Crosstab')
DROP TABLE Crosstab
GO

--CREATE TABLE FOR DEMONSTRATION PURPOSES

CREATE TABLE Crosstab
( Year      SMALLINT,
  Quarter   TINYINT, 
  Amount    DECIMAL(2,1) )

GO
--CHANGE THE VALUES FOR THE YEARS AND QUATERS AND ADD ADDITIONAL VALUES
INSERT INTO Crosstab VALUES (2021, 1, 1.1)
INSERT INTO Crosstab VALUES (2021, 2, 1.2)
INSERT INTO Crosstab VALUES (2021, 3, 1.3)
INSERT INTO Crosstab VALUES (2020, 4, 1.4)
INSERT INTO Crosstab VALUES (2020, 1, 2.1)
INSERT INTO Crosstab VALUES (2021, 2, 2.2)
INSERT INTO Crosstab VALUES (2021, 3, 2.3)
INSERT INTO Crosstab VALUES (2021, 4, 2.4)
INSERT INTO Crosstab VALUES (2020, 1, 2.1)
INSERT INTO Crosstab VALUES (2020, 2, 2.2)
INSERT INTO Crosstab VALUES (2020, 3, 2.3)
INSERT INTO Crosstab VALUES (2021, 4, 2.4)
GO


--SELECT the SUM of each quarter, grouped by year:
--THIS IS THE ACTUAL CROSSTAB QUERY

SELECT Year, 
    SUM(CASE Quarter WHEN 1 THEN Amount ELSE 0 END) AS Q1,
    SUM(CASE Quarter WHEN 2 THEN Amount ELSE 0 END) AS Q2,
    SUM(CASE Quarter WHEN 3 THEN Amount ELSE 0 END) AS Q3,
    SUM(CASE Quarter WHEN 4 THEN Amount ELSE 0 END) AS Q4
FROM dbo.Crosstab
GROUP BY Year
GO


--SELECT ALL PROVIDERS

SELECT  CustID, State, ZipCode
FROM  Customers
ORDER BY State
 

--SELECT A purchase order and presecription
SELECT
a.OrderID,
a.Order_Date,
p.CustomerID,
p.[Cust_LName],
d.ProductID,
d.ProductDesc
FROM  Orders a
INNER JOIN  Customers p
	on a.CustomerID = p.CustomerID 
INNER JOIN Products d
	on d.ProductID = a.ProductID
WHERE a.order_date >= '05/01/2021'
ORDER BY p.CustomerID


--Total revenue (sales) per month, grouped by customer
SELECT CustID, DATEPART(mm, OrderDate) AS OrderMonth, SUM(OrderTotal) AS Total_Revenue
FROM Orders
GROUP BY CustID, DATEPART(mm, OrderDate)

--Total revenue (sales) per month, grouped by product
SELECT ProductID, DATEPART(mm, O.OrderDate) AS OrderMonth, SUM(ItemPrice * ItemQuantity) AS Total_Revenue
FROM OrderLine
LEFT JOIN Orders O
	ON O.OrderID = OrderLine.OrderID
GROUP BY ProductID,DATEPART(mm, O.OrderDate)


--AGGREGATE QUERY SHOWING TOTAL COUNT OF PAT ID BY ORDER DATE
SELECT order_date, COUNT(patID) as 'Number of Orders by Patient' 
FROM  [dbo].[tblapporders]
GROUP BY order_date 



-- Count of Orders by Customer
SELECT CustID , COUNT(OrderDate) as 'Number of Orders by Customer' 
FROM  Orders
GROUP BY CustID

select * from Orders