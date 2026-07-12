/*
============================================================
File: 08_string_date_conversion_functions.sql
Project: E-Commerce Database (SQL Server)

Topics Covered:
- UPPER()
- LOWER()
- LEN()
- TRIM(), LTRIM(), RTRIM()
- LEFT()
- RIGHT()
- SUBSTRING()
- REPLACE()
- CONCAT()
- GETDATE()
- YEAR(), MONTH(), DAY()
- DATEDIFF()
- DATEADD()
- CAST()
- CONVERT()

Description:
Practice manipulating strings, working with dates,
and converting data types using SQL Server's built-in
functions.
============================================================
*/

-- ============================================
-- 8.1 - UPPER() & LOWER()
-- ============================================

-- 1. Full customer name in uppercase.

SELECT CustomerID, UPPER(FirstName + ' ' + LastName) [Customer Name]
FROM Customers;

/* 2. Customer first names in uppercase only for customers living in Delhi.
Sort them alphabetically. */

SELECT CustomerID, UPPER(FirstName) [Customer Name]
FROM Customers
WHERE City = 'Delhi'
ORDER BY [Customer Name];

/* 3. The marketing team is exporting customer data to a third-party email platform.
They have requested:
-> Full customer names in UPPERCASE
-> Email addresses in lowercase
-> City names in UPPERCASE
Sort the report by customer name. */

SELECT CustomerID, 
	   UPPER(FirstName + ' ' + LastName) [Customer Name],
	   LOWER(Email) [Email],
	   UPPER(City) [City]
FROM Customers
ORDER BY [Customer Name] ASC;

-- ============================================
-- 8.2 - LEN()
-- ============================================

/* 1. All customer emails along with their lengths.
Show only emails whose length is greater than 20 characters. */

SELECT Email, LEN(Email) [Email Length]
FROM Customers
WHERE LEN(Email) > 20;

/* 2. Display:
-> CustomerID
-> Full Name (UPPERCASE)
-> Length of Full Name
Sort by the longest full name.
*/

SELECT CustomerID,
	   UPPER(FirstName + ' ' + LastName) [Full Name],
	   LEN(FirstName + ' ' + LastName) [Length of Full Name]
FROM Customers
ORDER BY [Length of Full Name] DESC;

/* 3. Active products whose product name contains more than 15 characters.
Display:
-> ProductID
-> ProductName
-> Name Length
-> Price
Sort by name length (highest first). */

SELECT ProductID, ProductName,
	   LEN(ProductName) [Name Length],
	   Price
FROM Products
WHERE IsActive = 1 AND LEN(ProductName) > 15
ORDER BY [Name Length] DESC;

/* 4. Generate a report showing customers whose full name contains fewer 
than 11 characters.
Display:
-> CustomerID
-> Full Name (Uppercase)
-> Name Length
-> Email
Sort from shortest name to longest. */

SELECT CustomerID,
	   UPPER(FirstName + ' ' + LastName) [Full Name],
	   LEN(FirstName + ' ' + LastName) [Name Length],
	   Email
FROM Customers
WHERE LEN(FirstName + ' ' + LastName) < 11
ORDER BY [Name Length] ASC;

-- ============================================
-- 8.3 - TRIM(), RTRIM() & LTRIM()
-- ============================================

/* 1. Display customer emails after removing unwanted spaces.
Also display the email length after trimming. */

SELECT FirstName,
	   TRIM(Email) [Cleaned Email],
	   LEN(TRIM(Email)) [Cleaned Email Length]
FROM Customers;

/* 2. Display:
-> CustomerID
-> Full Customer Name (Trimmed & Uppercase)
Sort alphabetically. */

SELECT CustomerID, 
	   UPPER(TRIM(FirstName) + ' ' + TRIM(LastName)) [Trimmed Full Name]
FROM Customers
ORDER BY [Trimmed Full Name];

/* 3. Display:
-> ProductID
-> ProductName
-> Clean Product Name
-> Length of Clean Product Name
Show only active products whose cleaned name contains more than 12 characters. */

SELECT ProductID, ProductName,
	   TRIM(ProductName) [Clean Product Name],
	   LEN(TRIM(ProductName)) [Length of Clean Product Name]
FROM Products
WHERE IsActive = 1 AND LEN(TRIM(ProductName)) > 12
ORDER BY [Length of Clean Product Name] DESC;

/* 4. Create a cleaned customer report displaying:
-> CustomerID
-> Customer Name (Trimmed & Uppercase)
-> Email (Trimmed & Lowercase)
-> City (Trimmed)
-> Length of Customer Name
Sort the report alphabetically by customer name. */

SELECT CustomerID, 
	   UPPER(TRIM(FirstName) + ' ' + TRIM(LastName)) [Customer Name],
	   LOWER(TRIM(Email)) [Email],
	   TRIM(City) [City],
	   LEN(TRIM(FirstName) + ' ' + TRIM(LastName)) [Name Length]
FROM Customers
ORDER BY [Customer Name];

-- ============================================
-- 8.4 - LEFT(), RIGHT() & SUBSTRING()
-- ============================================

/* 1. Display:
-> ProductID
-> ProductName
-> Last 4 characters of ProductName
Show only active products. */

SELECT ProductID, ProductName,
	   RIGHT(ProductName,4)
FROM Products
WHERE IsActive = 1;

/* 2. Display:
-> CustomerID
-> Full Customer Name (Uppercase)
-> First 2 characters of LastName */

SELECT CustomerID,
	   UPPER(FirstName + ' ' + LastName) [Customer Name],
	   LEFT(LastName,2)
FROM Customers;

/* 3. Active products whose first 3 letters are 'Lap'
Display:
-> ProductID
-> ProductName
-> Price */

SELECT ProductID, ProductName, Price
FROM Products
WHERE IsActive = 1 AND LEFT(ProductName,3) = 'Lap';

/* 4. Display
-> ProductID
-> ProductName
-> Characters 4–8 of ProductName
Show only products whose name length is greater than 10. */

SELECT ProductID, ProductName, 
	   SUBSTRING(ProductName,4,5) [Extracted Text]
FROM Products
WHERE LEN(ProductName) > 10;

/* 5. Generate a customer report displaying
-> CustomerID
-> Customer Name (Uppercase)
-> City
-> First 3 letters of City
-> Last 2 letters of State
Sort by City. */

SELECT CustomerID, 
	   UPPER(FirstName + ' ' + LastName) [Customer Name],
	   City, 
	   LEFT(City,3) [City PREFIX],
	   RIGHT(State,2) [State SUFFIX]
FROM Customers
ORDER BY City ASC;

-- ============================================
-- 8.5 - REPLACE() & CONCAT()
-- ============================================

/* 1. Display:
-> CustomerID
-> Customer Name (Uppercase)
-> Email with .com replaced by .org */

SELECT CustomerID, 
	   UPPER(CONCAT(FirstName,' ',LastName)) [Customer Name],
	   REPLACE(Email,'.com','.org')
FROM Customers;

/* 2. Generate a report displaying:
-> ProductID
-> Product Name
-> Product Code
Where Product Code is created by:
Converting the name to uppercase and replacing spaces with '_'.
Show only products whose names contain more than 10 characters. */

SELECT ProductID,
	   ProductName,
	   REPLACE(UPPER(ProductName),' ','_') [Product Code]
FROM Products
WHERE LEN(ProductName) > 10;

/* 3. Generate a customer report displaying:
-> CustomerID
-> Customer Name
-> Initials
Initials should contain:
First letter of FirstName and first letter of LastName */

SELECT CustomerID,
	   CONCAT(FirstName,' ',LastName) [Customer Name],
	   CONCAT(LEFT(FirstName,1),LEFT(LastName,1)) [Initials]
FROM Customers;

-- 4. Hide a specific part of the Email for each customer.

SELECT CustomerID,
	   CONCAT(FirstName,' ',LastName) [Customer Name],
       REPLACE(Email,SUBSTRING(Email,3,8),'******')
FROM Customers;

/* 5. Generate usernames using this format: FirstName.LastName
Rules:
-> Convert everything to lowercase.
-> Remove spaces from both names.
   Display:
   -> CustomerID
   -> Customer Name
   -> Username */

SELECT CustomerID, 
	   CONCAT(TRIM(FirstName),' ',TRIM(LastName)) [Customer Name],
	   CONCAT(LOWER(TRIM(FirstName)),'.',LOWER(TRIM(LastName))) [Username]
FROM Customers;

-- ============================================
-- 8.6 - GETDATE()
-- ============================================

-- 1. Current Date & Time

SELECT GETDATE() [Current DateTime];

/* 2. Display:
-> OrderID
-> OrderDate
-> Current Date & Time
Show only orders placed before today. */

SELECT OrderID, OrderDate, GETDATE() [Current DateTime]
FROM Orders
WHERE OrderDate < GETDATE();

-- ============================================
-- 8.7 - YEAR(), MONTH() & DAY()
-- ============================================

/* 1. Display:
-> PaymentID
-> PaymentDate
-> Payment Year
Show only payments made in the current year. */

SELECT PaymentID, PaymentDate, YEAR(PaymentDate) [Payment Year] 
FROM Payments
WHERE YEAR(PaymentDate) = YEAR(GETDATE());

/* 2. Display:
-> CustomerID
-> Customer Name
-> Registration Month
Show only customers who registered in January. */

SELECT CustomerID, 
       CONCAT(FirstName,' ',LastName) [Customer Name],
	   MONTH(RegisterDate) [Registration Month]
FROM Customers
WHERE MONTH(RegisterDate) = 1;

/* 3. Display active products along with today's:
-> Year
-> Month
-> Day  */

SELECT ProductID, ProductName,
	   YEAR(GETDATE()) [Current Year],
	   MONTH(GETDATE()) [Current Month],
	   DAY(GETDATE()) [Current Day]
FROM Products
WHERE IsActive = 1;

/* 4. The management team wants a customer registration report.
Display:
-> CustomerID
-> Customer Name (Uppercase)
-> Registration Date
-> Registration Year
-> Registration Month
-> Registration Day
Show only customers who registered in the current year.
Sort by registration month and then by registration day. */

SELECT CustomerID,
	   UPPER(CONCAT(FirstName,' ',LastName)) [Customer Name],
	   RegisterDate,
	   YEAR(RegisterDate) [Registration Year],
	   MONTH(RegisterDate) [Registration Month],
	   DAY(RegisterDate) [Registration Day]
FROM Customers
WHERE YEAR(RegisterDate) = YEAR(GETDATE()) 
ORDER BY [Registration Month], [Registration Day];

-- ============================================
-- 8.8 - DATEDIFF()
-- ============================================

/* 1. Display:
-> CustomerID
-> Customer Name
-> Number of days since registration
Sort by the customer who has been registered the longest. */

SELECT CustomerID,
	   UPPER(CONCAT(FirstName,' ',LastName)) [Customer Name],
	   DATEDIFF(DAY,RegisterDate,GETDATE()) [Days Registered]
FROM Customers
ORDER BY [Days Registered] DESC;

/* 2. Display:
-> CustomerID
-> Customer Name
-> Number of years since registration
Show only customers who have been registered for at least 2 years and sort by the 
longest registered customer. */

SELECT CustomerID, 
	   CONCAT(FirstName,' ',LastName) [Customer Name],
	   DATEDIFF(YEAR,RegisterDate,GETDATE()) [Years Registered]
FROM Customers
WHERE DATEDIFF(YEAR,RegisterDate,GETDATE()) >= 2
ORDER BY [Years Registered] DESC;

/* 3. Generate a report displaying:
-> CustomerID
-> Customer Name
-> Registration Date
-> Total Days Registered
-> Total Months Registered
-> Total Years Registered
Show only customers who have been registered for more than 365 days.
Sort by total days registered (highest first). */

SELECT CustomerID,
	   CONCAT(FirstName,' ',LastName) [Customer Name],
	   RegisterDate,
	   DATEDIFF(DAY,RegisterDate,GETDATE()) [Days Registered],
	   DATEDIFF(MONTH,RegisterDate,GETDATE()) [Months Registered],
	   DATEDIFF(YEAR,RegisterDate,GETDATE()) [Years Registered]
FROM Customers
WHERE DATEDIFF(DAY,RegisterDate,GETDATE()) > 365
ORDER BY [Days Registered] DESC;

-- ============================================
-- 8.9 - DATEADD()
-- ============================================

/* 1. Display:
-> OrderID
-> OrderDate
-> Expected Delivery Date
Assume delivery takes 5 days. */

SELECT OrderID, OrderDate, 
	   DATEADD(DAY,5,OrderDate) [Delivery Date]
FROM Orders;

/* 2. Display active products along with:
-> ProductID
-> ProductName
-> Date exactly 30 days from today
Sort by Product Name. */

SELECT ProductID, ProductName,
	   DATEADD(DAY,30,GETDATE()) [Future Date]
FROM Products
WHERE IsActive = 1
ORDER BY ProductName;

/* 3. Generate an order report displaying:
-> OrderID
-> OrderDate
-> Expected Delivery (7 days later)
-> Warranty Expiry (1 year after OrderDate)
Sort by OrderDate. */

SELECT OrderID, OrderDate,
	   DATEADD(DAY,7,OrderDate) [Expected Delivery],
	   DATEADD(YEAR,1,OrderDate) [Warranty Expire]
FROM Orders
ORDER BY OrderDate;

/* 4. Generate a delivery schedule displaying:
-> OrderID
-> CustomerID
-> OrderDate
-> Expected Delivery Date
-> Reminder Date (2 days before delivery)
Sort by Expected Delivery Date. */

SELECT OrderID, CustomerID, OrderDate,
       DATEADD(DAY,7,OrderDate) [Expected Delivery],
	   DATEADD(DAY,5,OrderDate) [Reminder Date]
FROM Orders
ORDER BY [Expected Delivery];

-- OR

SELECT OrderID, CustomerID, OrderDate,
       DATEADD(DAY,7,OrderDate) [Expected Delivery],
	   DATEADD(DAY,-2,DATEADD(DAY,7,OrderDate)) [Reminder Date]
FROM Orders
ORDER BY [Reminder Date];


