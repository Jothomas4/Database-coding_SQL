/* Switch to master database to create your new one */
USE master
GO

--CHECK TO SEE IF DATABASE EXISTS AND IF SO, DROP AND RECREATE DATABASE
--CHANGE NAME TO YOUR STORE NAME, NO SPACES, BUT YOU CAN USE UNDERSCORES

IF EXISTS(SELECT name FROM sys.databases
 WHERE name = 'CS660_DEMO')
DROP DATABASE CS660_DEMO

GO

CREATE DATABASE CS660_DEMO


--SWITCH TO DATABASE
USE CS660_DEMO

GO

/* ---------------------------CREATE ALL TABLES---------------------------------*/
/*----------TABLE NAMES SHOULD NOT HAVE SPACES IN THEM FOR EASE IN REPORTING-----*/

CREATE TABLE Customers
(
CustID int NOT NULL PRIMARY KEY,
FirstName varchar(25) NOT NULL,
CustLname varchar(75) NOT NULL,
Address1 varchar(55) NOT NULL,
Address2 varchar(35) NULL,
City varchar(max) NOT NULL,
State varchar(2) NOT NULL,
ZipCode varchar(5) NOT NULL,
Phone varchar(12) NOT NULL,
Email varchar(100) NULL
);

-- SELECT * FROM Customers
-- DROP TABLE Customers
-- TRUNCATE TABLE Customers
-- DELETE FROM Customers


CREATE TABLE Orders
(
OrderID int NOT NULL PRIMARY KEY,
OrderDate Date NOT NULL,
OrderTotal Decimal(9,2) NOT NULL,
CustID int NOT NULL
);

CREATE TABLE OrderLine
(
OrderLineID int NOT NULL PRIMARY KEY,
OrderID int NOT NULL,
ProductID int NOT NULL,
ItemPrice Decimal(7,2) NOT NULL,
ItemQuantity int NOT NULL
);

CREATE TABLE Product
(
ProductID int NOT NULL PRIMARY KEY,
ProductDesc varchar(max) NOT NULL,
ProductShortDesc varchar(100) NOT NULL,
ProductCost Decimal(9,2) NOT NULL,
ReorderQuantity int NOT NULL,
ManufID int NOT NULL,
CatID int NOT NULL
);

-- DROP TABLE Product

CREATE TABLE Categories
(
CatID int NOT NULL PRIMARY KEY,
CatTitle varchar(100) NOT NULL,
CatDesc varchar(max) NOT NULL
);

CREATE TABLE Manufacture
(
ManufID int NOT NULL PRIMARY KEY
);

/*----------RUN SOME ALTER TALBE STATEMENTS TO SET THE FOREIGN KEY REFERENCES-----*/
/* ------------------------------ALTER TABLES------------------------------------*/
/* YOU CAN RUN THIS CODE AFTER INSERTING DATA INTO YOUR TABLES */


--Orders
ALTER TABLE Orders
ADD CONSTRAINT FK_Order_CustID
FOREIGN KEY (CustID) REFERENCES Customers(CustID);

--OrderLine
ALTER TABLE OrderLine
ADD CONSTRAINT FK_OrderLine_OrderID
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)

ALTER TABLE OrderLine
ADD CONSTRAINT FK_OrderLine_ProductID
FOREIGN KEY (ProductID) REFERENCES Product(ProductID)





/* DROP ALL TABLES IF NEEDED */
/*
--DROP CONSTRAINTS BEFORE YOU CAN DROP TABLE
ALTER TABLE Orders DROP CONSTRAINT FK_Order_CustID;
ALTER TABLE tblCustomers DROP CONSTRAINT FK_CountryID;
ALTER TABLE tblCustomers DROP CONSTRAINT FK_RegionID;
ALTER TABLE tblCustomers DROP CONSTRAINT FK_CountryID
ALTER TABLE tblCustAddress DROP CONSTRAINT FK_CustID;
ALTER TABLE tblOrders DROP CONSTRAINT FK_CustID;

--DROP ALL TABLES
DROP TABLE [dbo].[tblCountry]
DROP TABLE [dbo].[tblCustAddress]
DROP TABLE [dbo].[tblCustomers]
DROP TABLE [dbo].[tblOrders]
DROP TABLE [dbo].[tblProducts]
DROP TABLE [dbo].[tblRegion]
*/




