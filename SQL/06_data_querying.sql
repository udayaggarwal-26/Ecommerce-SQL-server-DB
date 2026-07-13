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
- OFFSET
- FETCH

Description:
Practice querying data from the E-Commerce database using
various filtering, sorting, and pagination techniques.
====================================================
*/

-- ============================================
-- 6.1 - SELECT
-- ============================================

-- 1. Display all products

SELECT * FROM Products;

-- 2. ProductNames and Prices

SELECT ProductName, Price
FROM Products;

-- ============================================
-- 6.2 - DISTINCT
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
-- 6.3 - WHERE
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
-- 6.4 - Comparison Operators
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
-- 6.5 - AND, OR & NOT
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
-- 6.6 - BETWEEN & IN
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

-- ============================================
-- 6.7 - LIKE
-- ============================================

-- 1. Products whose names contain Wireless

SELECT ProductName, Price
FROM Products
WHERE ProductName LIKE '%Wireless%';

-- 2. All customers whose first name starts with "A".

SELECT CustomerID, FirstName, LastName
FROM Customers
WHERE FirstName LIKE 'A%';

-- 3. Marketing team wants to send promotional emails only to Gmail users.

SELECT FirstName, LastName, Email
FROM Customers
WHERE Email LIKE '%@gmail.com';

-- 4. Customers whose city contains the letter "a" anywhere in its name.

SELECT FirstName, LastName, City
FROM Customers
WHERE City LIKE '%a%';

/* 5. A query that returns all products:
-> Whose names contain Head
-> Are active
-> Cost more than ₹1000 */

SELECT ProductID, ProductName, Price, StockQuantity
FROM Products
WHERE ProductName LIKE '%Head%'
      AND IsActive = 1
      AND Price > 1000;

-- ============================================
-- 6.8 - ORDER BY
-- ============================================

-- 1. Products from the lowest price to the highest price.

SELECT ProductName, Price
FROM Products
ORDER BY Price ASC;

-- 2. All customers in alphabetical order of their last name.

SELECT FirstName, LastName, City
FROM Customers
ORDER BY LastName ASC;

-- 3. Display the latest orders

SELECT OrderID, CustomerID, OrderDate, Status
FROM Orders
ORDER BY OrderDate DESC;

/* 4. All products sorted by: 
-> CategoryID (ascending)
-> Price (descending) */

SELECT ProductName, CategoryID, Price
FROM Products
ORDER BY CategoryID ASC, Price DESC;

/* 5. Products that satisfy all of the following:
-> Price between ₹500 and ₹5000
-> Category is either Electronics or Home & Kitchen

Sort the results by:
-> CategoryID (ascending)
-> Price (descending)
-> ProductName (ascending) */

SELECT ProductID, ProductName, CategoryID, Price, StockQuantity
FROM Products
WHERE Price BETWEEN 500 AND 5000
      AND CategoryID IN (1,4)
ORDER BY CategoryID ASC,
         Price DESC,
         ProductName ASC;

-- ============================================
-- 6.9 - TOP & TOP PERCENT
-- ============================================

-- 1. Top 5 most expensive products

SELECT TOP 5 ProductName, Price, StockQuantity
FROM Products
ORDER BY Price DESC;

-- 2. Top 30% of highest available products

SELECT TOP 30 PERCENT ProductName, Price, StockQuantity
FROM Products
ORDER BY StockQuantity DESC;

/* 3. TOP 3 products that satisfy all these conditions:
-> Category = Electronics
-> Active products only
-> Price greater than ₹500

Sort the result by:
-> Price(highest first)
-> StockQuantity (highest first) */

SELECT TOP 3 ProductID, ProductName, Price, StockQuantity
FROM Products
WHERE CategoryID = 1 AND IsActive = 1
      AND Price > 500 
ORDER BY Price DESC, StockQuantity DESC;

-- ============================================
-- 6.10 - OFFSET & FETCH
-- ============================================

-- 1. Second page of products ordered by ProductID (Page Size = 5)

SELECT ProductID, ProductName, Price
FROM Products 
ORDER BY ProductID ASC
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;

-- 2. Customers ordered by LastName. Skip the first 2 and return the next 3.

SELECT CustomerID, FirstName, LastName
FROM Customers
ORDER BY LastName ASC
OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY;

/* 3. Query to display:
Only Electronics products (CategoryID = 1)
Sorted by price (highest first)
Show only the products for Page 2 (Page Size = 4) */

SELECT ProductID, ProductName, Price, StockQuantity
FROM Products
WHERE CategoryID = 1 
ORDER BY Price DESC 
OFFSET 4 ROWS
FETCH NEXT 4 ROWS ONLY;