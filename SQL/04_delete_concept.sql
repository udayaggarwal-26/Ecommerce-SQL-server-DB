/* ============================================================
File: 04_delete_concept.sql   
Project: E-Commerce Database (SQL Server)

Topics covered: 
- DELETE

Description:
Practice deleting records from the E-Commerce database 
and explore how foreign key relationships affect DELETE operations.
============================================================ 
*/

SELECT * FROM Customers;

--Insert a test row in the Customer table
INSERT INTO Customers (FirstName, LastName, Email, Phone, City, State, Country) 
VALUES
('Test', 'User', 'testuser@gmail.com', '9999999999', 'Delhi', 'Delhi', 'India');

--Proper deletion workflow
-- STEP 1 (Select the row to be deleted)
SELECT * FROM Customers
WHERE FirstName = 'Test';

-- STEP 2 (Delete the record)
DELETE FROM Customers
WHERE FirstName = 'Test';

-- STEP 3 (Verify)
SELECT * FROM Customers
WHERE FirstName = 'Test';



SELECT * FROM Categories;

--Insert a test category
INSERT INTO Categories (CategoryName, Description) 
VALUES
('Temporary Category', 'A category just for testing purposes');

-- STEP 1
SELECT * FROM Categories
WHERE CategoryName = 'Temporary Category';

-- STEP 2
DELETE FROM Categories
WHERE CategoryName = 'Temporary Category';

-- STEP 3
SELECT * FROM Categories
WHERE CategoryName = 'Temporary Category';


-- FK based Delete
SELECT * FROM Customers;
SELECT * FROM Orders;

DELETE FROM Customers
WHERE CustomerID = 1;
/*
Error because of FK Constraint
The DELETE statement conflicted with the REFERENCE constraint "FK_Orders_Customers". 
The conflict occurred in database "ECommerceDB", table "dbo.Orders", column 'CustomerID'.
*/

