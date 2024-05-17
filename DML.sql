
--SWITCH TO DATABASE
USE CS660_DEMO

--INSERT RECORDS IN THE CORRECT ORDER, BASED ON DEPENDENCIES (PARENT BEFORE CHILD)

--Customers
INSERT INTO Customers
VALUES (1000,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972', NULL),
		(1001,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1002,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1003,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1004,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1005,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1006,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1007,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1008,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1009,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1010,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1011,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1012,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1013,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1014,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1015,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu'),
		(1016,'John','Conklin', '12345 Main Street', NULL, 'Phoenix', 'AZ', '85083','602-796-5972','jconklin@coloradotech.edu')


/* SELECT * FROM Customers */

-- Orders
INSERT INTO Orders
VALUES (2000,'11/11/2021', 245.55, 1004 )
INSERT INTO Orders
VALUES (2001, '11/11/2021', 245.55, 1003)
INSERT INTO Orders
VALUES (2002,'11/11/2021', 445.55, 1004)
INSERT INTO Orders
VALUES (2003, '11/11/2021', 246.55, 1000)
INSERT INTO Orders
VALUES (2004, '11/11/2021', 25.55, 1004)
INSERT INTO Orders
VALUES (2005, '11/11/2021', 2435.55, 1005)

-- SELECT * FROM Orders

--OrderLine
INSERT INTO OrderLine
VALUES (3000, 2000, 5000, 345.66, 1),
		(3001, 2002, 5003, 234.00, 1),
		(3002, 2005, 5002, 1234.45, 1)

INSERT INTO OrderLine
VALUES (3003, 2000, 5007, 345.66, 1)
		-- SELECT * FROM OrderLine

--Products
INSERT INTO Product
VALUES (5000, 'Bedroom table', 'Bedroom table', 234.55, 20, 4000, 6000)
INSERT INTO Product
VALUES (5002, 'Kitchen table', '6 feet x 9 Feet Kitchen table', 234.55, 20, 4000, 6000)
INSERT INTO Product
VALUES (5003, 'Sofa table', '2 feet x 4 feet Sofa table', 234.55, 20, 4000, 6000)
INSERT INTO Product
VALUES (5004, 'Leather Chair', 'Leather Dinning Room Chair', 234.55, 20, 4000, 6000)
INSERT INTO Product
VALUES (5005, 'Recliner', 'Beige Recliner', 234.55, 20, 4000, 6000)
INSERT INTO Product
VALUES (5006, 'Sofa table', '2 feet x 4 feet Sofa table', 234.55, 20, 4000, 6001)
INSERT INTO Product
VALUES (5007, 'Leather Chair', 'Leather Dinning Room Chair', 234.55, 20, 4000, 6001)
INSERT INTO Product
VALUES (5008, 'Recliner', 'Beige Recliner', 234.55, 20, 4000, 6001)


INSERT INTO [dbo].[Categories]
VALUES (6000, 'Kitchen Furniture', 'Furniture for your kitchen'),
		(6001, 'Bedroom Furniture', 'Furniture for your bedroom')

-- SELECT * FROM [dbo].[Categories]	

/* UPDATE AND DELETE CODE BELOW*/

UPDATE Customers
SET City = 'Tempe'
WHERE CustID = 1007

UPDATE Customers
SET Address2 = 'Apt 123'
WHERE CustID = 1007

--  SELECT * FROM Customers

UPDATE Product
SET [ProductCost] = 567.00 
WHERE [ProductID] = 5005

-- SELECT * FROM Product

--To delete a parent record in which there is one or more related child records, the child records
--must be deleted first before the parent

--delete department associated with store that needs to be deleted from tblstores based on StoreID
BEGIN TRAN
DELETE FROM Customers
where CustID = 1006
COMMIT TRAN;

--delete store from tblstores based on StoreID (USING A TRANSACTION WITH ERROR HANDLER)
BEGIN TRAN
DELETE  FROM tblStores
where StoreName = 'Johnson Company'

    IF (@@ERROR <> 0) BEGIN
        PRINT 'Unexpected error occurred!'
        ROLLBACK TRAN  
    END
COMMIT TRAN

