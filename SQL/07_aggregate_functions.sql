/*
============================================================
File: 07_aggregate_functions.sql
Project: E-Commerce Database (SQL Server)

Topics Covered:
- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()
- GROUP BY
- HAVING

Description:
Practice summarizing and analyzing E-Commerce data using
aggregate functions and grouped reports.
============================================================
*/

-- ============================================
-- 7.1 - COUNT()
-- ============================================

-- 1. How many products are available in the Products table?

SELECT COUNT(*) [No of Products]
FROM Products;

-- 2. How many products belong to the Electronics category?

SELECT COUNT(*) [Electronics]
FROM Products
WHERE CategoryID = 1;

-- 3. Customers belonging to either Delhi or Mumbai.

SELECT COUNT(*) 
FROM Customers
WHERE City IN ('Delhi','Mumbai');

-- 4. Products having selling price above ₹1000

SELECT COUNT(*)
FROM Products
WHERE Price > 1000;

-- 5. Different cities of Customers

SELECT COUNT(DISTINCT City)
FROM Customers;

-- 6. How many customers belong to Delhi, Mumbai, and Bangalore combined?

SELECT COUNT(*)
FROM Customers
WHERE City IN ('Delhi', 'Mumbai', 'Bangalore');

-- ============================================
-- 7.2 - MAX() & MIN()
-- ============================================

-- 1. Highest payment amount ever recorded.

SELECT MAX(Amount) [Highest Payment]
FROM Payments;

-- 2. Lowest stock quantity

SELECT MIN(StockQuantity) [Lowest Stock]
FROM Products;

-- 3. Latest customer registration date

SELECT MAX(RegisterDate)
FROM Customers;

-- 4. Earliest order date among all customer orders

SELECT MIN(OrderDate)
FROM Orders;

-- 5. Highest product price currently in the catalog.

SELECT MAX(Price) AS HighestPrice
FROM Products;

-- ============================================
-- 7.3 - SUM() & AVG()
-- ============================================

-- 1. Total amount received through all successful and unsuccessful payments combined.

SELECT SUM(Amount) [Total Sales]
FROM Payments;

-- 2. Total stock quantity available across all active products.

SELECT SUM(StockQuantity) [Total Stock]
FROM Products
WHERE IsActive = 1;

-- 3. Average selling price of all active products.

SELECT AVG(Price) [Average Price]
FROM Products
WHERE IsActive = 1;

-- 4. Total quantity of products sold.

SELECT SUM(Quantity) [Units Sold] 
FROM OrderDetails;

-- 5. Total value of the current inventory

SELECT SUM(Price * StockQuantity) [Inventory Value]
FROM Products;

-- ============================================
-- 7.4 - GROUP BY
-- ============================================

-- 1. Number of customers registered from each city.

SELECT City, COUNT(*) [Total Customers]
FROM Customers
GROUP BY City;

-- 2. Total stock quantity available for each product category.

SELECT CategoryID, SUM(StockQuantity) [Total Stock]
FROM Products
GROUP BY CategoryID;

-- 3. Total quantity of items sold for each order.

SELECT OrderID, SUM(Quantity) [Total Quantity]
FROM OrderDetails
GROUP BY OrderID;

-- 4. For each order, calculate the total order value.

SELECT OrderID, SUM(Quantity * UnitPrice) [Total Order Value]
FROM OrderDetails
GROUP BY OrderID;

-- 5. The number of orders in each order status.

SELECT Status, COUNT(*) [Total Orders]
FROM Orders
GROUP BY Status
ORDER BY [Total Orders] DESC;

-- ============================================
-- 7.5 - HAVING
-- ============================================

-- 1. Cities that have more than one registered customer.

SELECT City, COUNT(*) [Total Customers] 
FROM Customers
GROUP BY City
HAVING COUNT(*) > 1;

-- 2. Payment methods whose total payment amount exceeds ₹5,000.

SELECT PaymentMethod, SUM(Amount) [Total Amount]
FROM Payments
GROUP BY PaymentMethod
HAVING SUM(Amount) > 5000;

-- 3. Order IDs where the total quantity of products ordered is greater than 5.

SELECT OrderID, SUM(Quantity) [Total Quantity]
FROM OrderDetails
GROUP BY OrderID
HAVING SUM(Quantity) > 5;

-- 5. Order IDs where the total order value exceeds ₹3,000.

SELECT OrderID, SUM(Quantity * UnitPrice) [Total Order Value]
FROM OrderDetails
GROUP BY OrderID
HAVING SUM(Quantity * UnitPrice) > 3000;

/* 6. Payment methods where:
-> Total revenue exceeds ₹5,000
-> Sort the result from highest revenue to lowest. */ 

SELECT PaymentMethod, SUM(Amount) [Total Revenue]
FROM Payments
GROUP BY PaymentMethod
HAVING SUM(Amount) > 5000
ORDER BY [Total Revenue] DESC;

-- ============================================
-- Aggregate Challenge 
-- ============================================

/* 1. Categories having more than 50 units in stock considering only active products.
Sort the categories from highest stock to lowest. */

SELECT CategoryID, SUM(StockQuantity) [Total Stock] 
FROM Products
WHERE IsActive = 1
GROUP BY CategoryID
HAVING SUM(StockQuantity) > 50	
ORDER BY [Total Stock] DESC;

/* 2. Payment methods that have collected more than ₹5,000 from completed payments only.
Sort by total revenue (highest first). */

SELECT PaymentMethod, SUM(Amount) [Total Revenue] 
FROM Payments
WHERE PaymentStatus = 'Completed'
GROUP BY PaymentMethod
HAVING SUM(Amount) > 5000
ORDER BY [Total Revenue] DESC;

/* 3. Which customer cities have at least 2 registered customers?
Sort alphabetically by city. */

SELECT City, COUNT(*) [Total Customers] 
FROM Customers
GROUP BY City
HAVING COUNT(*) >= 2
ORDER BY City ASC;

/* 4. Product categories where the average product price is greater than ₹1000,
considering only active products. Sort by average price in descending order. */

SELECT CategoryID, AVG(Price) [Average Price]
FROM Products
WHERE IsActive = 1
GROUP BY CategoryID
HAVING AVG(Price) > 1000
ORDER BY [Average Price] DESC;

/* 5. Orders whose total order value exceeds ₹3000.
Sort by order value from highest to lowest. */

SELECT OrderID, SUM(Quantity * UnitPrice) [Order Value]
FROM OrderDetails
GROUP BY OrderID
HAVING SUM(Quantity * UnitPrice) > 3000
ORDER BY [Order Value] DESC;

/* 6. Among active products, identify categories where:
-> Average product price exceeds ₹1500
-> Total stock quantity exceeds 30 units
Sort by average price in descending order. */

SELECT CategoryID, AVG(Price) [Average Price], SUM(StockQuantity) [Total Stock]
FROM Products
WHERE IsActive = 1
GROUP BY CategoryID
HAVING AVG(Price) > 1500 AND SUM(StockQuantity) > 30
ORDER BY [Average Price] DESC;

/* 7. For each category, calculate:
-> Number of Products
-> Average Price
-> Highest Price
-> Lowest Price
Display only categories having at least 2 products.
Sort by average price (highest first). */

SELECT CategoryID, 
	   COUNT(*) [No of Products], 
	   AVG(Price) [Average Price],
	   MAX(Price) [Highest Price],
	   MIN(Price) [Lowest Price]
FROM Products
GROUP BY CategoryID
HAVING COUNT(*) >= 2
ORDER BY [Average Price] DESC;

/* 8. Generate a report showing only categories that satisfy all of the following:
-> Products are active.
-> Total stock is greater than 50 units.
-> Average product price is greater than ₹1000.
-> There are at least 2 products in the category.
Display: CategoryID, Number of Products, Total Stock, Average Price,
         Highest Product Price, Lowest Product Price
Sort the report by Average Price (highest first).
*/

SELECT CategoryID, 
	   SUM(StockQuantity) [Total Stock],
	   AVG(Price) [Average Price],
	   COUNT(*) [Total Products],
	   MAX(Price) [Highest Product Price],
	   MIN(Price) [Lowest Product Price]
FROM Products
WHERE IsActive = 1
GROUP BY CategoryID
HAVING SUM(StockQuantity) > 50 AND
	   AVG(Price) > 1000 AND
	   COUNT(*) >= 2
ORDER BY [Average Price] DESC;
	   
	   

