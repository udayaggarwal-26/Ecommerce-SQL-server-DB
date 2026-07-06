/*
====================================================
File: 06_data_querying.sql
Project: E-Commerce Database (SQL Server)

Topics Covered:
- SELECT
- DISTINCT
- WHERE
- Comparison Operators (=, >, <, >=, <=, <>, !=)
- Logical Operators (AND, OR, NOT)
- BETWEEN
- IN
- LIKE
- IS NULL / IS NOT NULL
- ORDER BY
- TOP
- OFFSET ... FETCH

Description:
Practice querying data from the E-Commerce database using
various filtering, sorting, and pagination techniques.
====================================================
*/

-- ============================================
-- STEP 6.1 - SELECT
-- ============================================

-- 1. Display all products

SELECT * FROM Products;

-- 2. ProductNames and Prices

SELECT ProductName, Price
FROM Products;

-- ============================================
-- STEP 6.2 - DISTINCT
-- ============================================

-- 1. Cities of Customers 

SELECT DISTINCT City 
FROM Customers;

-- 2. All unique order statuses.

SELECT DISTINCT Status
FROM Orders;

-- 3. Unique combinations of category and active status.

SELECT DISTINCT CategoryID, IsActive 
FROM Products;

-- ============================================
-- STEP 6.3 - WHERE
-- ============================================

-- 1. Name and price of products that cost more than ₹1000.

SELECT ProductName, Price
FROM Products
WHERE Price > 1000;

-- 2. Products taht have less than 25 units in stock.

SELECT ProductName, StockQuantity
FROM Products
WHERE StockQuantity < 25;

-- 3. Customers who live in Mumbai

SELECT * FROM Customers
WHERE City = 'Mumbai';

-- 4. Order ID, Order Date, and Status of all orders that are Delivered.

SELECT OrderID, OrderDate, Status
FROM Orders
WHERE Status = 'Delivered';

-- 5. Products whose CategoryID corresponds to books.

SELECT ProductName
FROM Products
WHERE CategoryID = 3;

-- ============================================
-- STEP 6.4 - Comparison Operators
-- ============================================

