/* ============================================================
File: 05_alter_truncate_drop.sql   
Project: E-Commerce Database (SQL Server)

Topics covered: 
- ALTER
- TRUNCATE
- DROP

Description:
Practice modifying and removing database objects 
using ALTER, TRUNCATE, and DROP statements.
============================================================ 
*/

-- Create practice table

CREATE TABLE ProductPractice
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO ProductPractice(ProductID, ProductName, Price)
VALUES
(1, 'Laptop', 50000),
(2, 'Mouse', 800),
(3, 'Keyboard', 1500);

SELECT * FROM ProductPractice;

-- ============================================
-- 5.1 - ALTER
-- ============================================

-- 1. Add a new column Brand and specify its value for each product
ALTER TABLE ProductPractice
ADD Brand VARCHAR(50);

UPDATE ProductPractice
SET Brand = 'Logitech'
WHERE ProductName = 'Mouse';

UPDATE ProductPractice
SET Brand = 'RedGear'
WHERE ProductName = 'Keyboard';

UPDATE ProductPractice
SET Brand = 'ASUS'
WHERE ProductName = 'Laptop';

-- 2. Increase the size of Brand

ALTER TABLE ProductPractice
ALTER COLUMN Brand VARCHAR(100);

--3. Delete the Brand column

ALTER TABLE ProductPractice
DROP COLUMN Brand;

-- ============================================
-- 5.2 - TRUNCATE
-- ============================================

-- 1. TRUNCATE the table
TRUNCATE TABLE ProductPractice;

-- ============================================
-- 5.3 - DROP
-- ============================================

-- 1. DROP the table
DROP TABLE ProductPractice;