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

-- 1. Products priced above ₹2,000

SELECT ProductName, Price
FROM Products
WHERE Price > 2000;

-- 2. Products with 20 units or fewer in stock

SELECT ProductName, StockQuantity
FROM Products 
WHERE StockQuantity <= 20;

-- 3. Category whose CategoryID is exactly 3

SELECT * FROM Categories
WHERE CategoryID = 3;

-- 4. Order whose status is not 'Delivered'

SELECT OrderID, CustomerID, Status
FROM Orders
WHERE Status <> 'Delivered';

-- 5. Products that cost ₹1,500 or less

SELECT ProductName, Price
FROM Products
WHERE Price <= 1500;

-- 6. Customer whose CustomerID is greater than 3

SELECT FirstName, LastName, City
FROM Customers
WHERE CustomerID = 3;

-- 7. Every product whose price is greater than ₹3,000

SELECT ProductID, ProductName, Price, StockQuantity
FROM Products
WHERE Price > 3000;

-- ============================================
-- STEP 6.5 - AND, OR & NOT
-- ============================================

-- 1. Products that are active and cost more than ₹1000.

SELECT ProductName, Price, IsActive
FROM Products
WHERE Price > 1000 AND IsActive = 1;

-- 2. Customers who belong to Delhi or Mumbai.

SELECT CustomerID, FirstName, LastName, City
FROM Customers
WHERE City = 'Delhi' OR City = 'Mumbai';

-- 3. Products that belong to the Books or the Sports category and are Active.

SELECT ProductName, CategoryID, Price, IsActive
FROM Products
WHERE (CategoryID = 3 OR CategoryID = 5) AND IsActive = 1;

-- 4. Customers who do not live in Delhi.

SELECT FirstName, LastName, City
FROM Customers
WHERE NOT City = 'Delhi'

SELECT FirstName, LastName, City
FROM Customers
WHERE City <> 'Delhi'

/* 5. List products that are active, are priced greater than ₹500, stock quantity
greater than 10 and belong to either Electronics or Home & Kitchen category. */

SELECT ProductID, ProductName, CategoryID, Price, StockQuantity 
FROM Products
WHERE Price > 500 AND IsActive = 1 AND StockQuantity > 10
      AND (CategoryID = 1 OR CategoryID = 4);

-- ============================================
-- STEP 6.6 - BETWEEN & IN
-- ============================================

-- 1. Products priced between ₹500 and ₹1500

SELECT ProductName, Price
FROM Products
WHERE Price BETWEEN 500 AND 1500;

/* 2. Company is promoting products belonging 
to only Electronics, Clothing and Sports category */

SELECT ProductName, CategoryID, Price
FROM Products
WHERE CategoryID IN (1,2,5);

/* 3. Highlight products that cost between ₹1000 and ₹5000, 
belong to Electronics or Home & Kitchen and are active */

SELECT ProductName, CategoryID, Price, StockQuantity 
FROM Products
WHERE CategoryID IN (1,4) AND Price BETWEEN 1000 AND 5000 
      AND IsActive = 1;

/* 4. Products must satisfy all of these conditions:
-> Price between ₹800 and ₹4000
-> Category is either Books, Home & Kitchen, or Sports 
-> Product is active
-> Stock quantity greater than 10 */

SELECT ProductID, ProductName, CategoryID, Price, StockQuantity
FROM Products
WHERE CategoryID IN (3,4,5) AND IsActive = 1
      AND StockQuantity > 10 AND
      Price BETWEEN 800 AND 4000;



