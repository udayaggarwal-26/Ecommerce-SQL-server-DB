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
-- 8.5 - LEFT(), RIGHT() & SUBSTRING()
-- ============================================