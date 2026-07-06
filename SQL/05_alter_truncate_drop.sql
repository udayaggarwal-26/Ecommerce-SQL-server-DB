-- ===========================================
-- ALTER / TRUNCATE / DROP Practice
-- ===========================================

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

-- Practice ALTER commands here

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

-- Practice TRUNCATE here

-- 1. TRUNCATE the table
TRUNCATE TABLE ProductPractice;

-- Practice DROP here

-- 1. DROP the table
DROP TABLE ProductPractice;