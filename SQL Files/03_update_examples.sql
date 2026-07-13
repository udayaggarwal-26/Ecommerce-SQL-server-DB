/* ============================================================
File: 03_update_examples.sql   
Project: E-Commerce Database (SQL Server)

Topics covered: 
- UPDATE

Description:
Practice updating data in the E-Commerce databaseusing various
UPDATE statements and conditions.
============================================================ 
*/

SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Payments;

--1 Increase the price of the Bluetooth Headphones.
UPDATE Products
SET Price = 2199.00
WHERE ProductName = 'Bluetooth Headphones';

--2 Wireless Mouse restocked.
UPDATE Products
SET StockQuantity = 200
WHERE ProductName = 'Wireless Mouse';
--Verify
SELECT ProductName, StockQuantity FROM Products
WHERE ProductName = 'Wireless Mouse';

--3 Sneha provided her phone number (Previously it was NULL).
UPDATE Customers
SET Phone = '9876519165'
WHERE FirstName = 'Sneha';

--4 OrderID 1 has now been shipped.
UPDATE Orders
SET Status = 'Shipped'
WHERE OrderID = 1;

--5 Pending payment has now been completed.
UPDATE Payments
SET PaymentStatus = 'Completed'
WHERE PaymentID = 3;

--6 Karan Singh's city from Delhi to Noida and state from Delhi to UP.
UPDATE Customers
SET City = 'Noida',
	State = 'Uttar Pradesh'
WHERE CustomerID = 5;

--7 Increase the price of Yoga Mat from ₹699 to ₹749.
UPDATE Products
SET Price = 749
WHERE ProductName = 'Yoga Mat';

--8 Restock Electric Kettle to 150 units.
UPDATE Products
SET StockQuantity = 150 
WHERE ProductName = 'Electric Kettle';

--9 OrderID = 2 to Delivered.
UPDATE Orders
SET Status = 'Delivered'
WHERE OrderID = 2;

--10 Karan Singh's city from Noida to Gurugram and state from UP to Haryana.
UPDATE Customers
SET City = 'Gurugram',
	State = 'Haryana'
WHERE CustomerID = 5;

--11 Discontinued Radio as active again.
UPDATE Products
SET IsActive = 1
WHERE ProductID = 13;