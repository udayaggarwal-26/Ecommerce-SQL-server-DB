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


