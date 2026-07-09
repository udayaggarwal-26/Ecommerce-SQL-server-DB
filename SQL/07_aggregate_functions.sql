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
-- STEP 7.1 - COUNT()
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
-- STEP 7.2 - MAX() & MIN()
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
-- STEP 7.3 - SUM() & AVG()
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

