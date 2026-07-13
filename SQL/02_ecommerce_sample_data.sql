/* ============================================================
File: 02_ecommerce_sample_data.sql   
Project: E-Commerce Database (SQL Server)

Topics covered: 
- INSERT
Order matters here because of FK constraints:
Categories -> Products -> Customers -> Orders -> OrderDetails -> Payments

Description:
Insert sample data into the E-Commerce database tables
============================================================ 
*/

USE ECommerceDB;


-- 1. Categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Electronics', 'Phones, laptops, gadgets and accessories'),
('Clothing', 'Men, women and kids apparel'),
('Books', 'Fiction, non-fiction and academic books'),
('Home & Kitchen', 'Appliances, cookware and furnishings'),
('Sports', 'Fitness and outdoor equipment');


-- 2. Products
INSERT INTO Products (ProductName, CategoryID, Price, StockQuantity, IsActive) VALUES
('Wireless Mouse', 1, 599.00, 150, 1),
('Bluetooth Headphones', 1, 1999.00, 80, 1),
('Smartphone Stand', 1, 299.00, 200, 1),
('Men''s Cotton T-Shirt', 2, 449.00, 300, 1),
('Women''s Denim Jacket', 2, 1799.00, 60, 1),
('Kids Sneakers', 2, 999.00, 90, 1),
('The Silent Patient (Book)', 3, 350.00, 120, 1),
('Atomic Habits (Book)', 3, 399.00, 200, 1),
('Non-Stick Frying Pan', 4, 899.00, 75, 1),
('Electric Kettle', 4, 1299.00, 100, 1),
('Yoga Mat', 5, 699.00, 150, 1),
('Dumbbell Set 10kg', 5, 2499.00, 40, 1),
('Discontinued Radio', 1, 499.00, 0, 0);  -- inactive product example


-- 3. Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, City, State, Country) VALUES
('Aarav', 'Sharma', 'aarav.sharma@example.com', '9876543210', 'Delhi', 'Delhi', 'India'),
('Priya', 'Verma', 'priya.verma@example.com', '9876500011', 'Mumbai', 'Maharashtra', 'India'),
('Rohan', 'Mehta', 'rohan.mehta@example.com', '9876500022', 'Bengaluru', 'Karnataka', 'India'),
('Sneha', 'Iyer', 'sneha.iyer@example.com', NULL, 'Chennai', 'Tamil Nadu', 'India'),
('Karan', 'Singh', 'karan.singh@example.com', '9876500044', 'Delhi', 'Delhi', 'India'),
('Anita', 'Das', 'anita.das@example.com', '9876500055', 'Kolkata', 'West Bengal', 'India');


-- 4. Orders
INSERT INTO Orders (CustomerID, OrderDate, Status, ShippingAddress) VALUES
(1, '2026-05-01', 'Delivered', '12 MG Road, Delhi'),
(2, '2026-05-03', 'Shipped', '45 Marine Drive, Mumbai'),
(3, '2026-05-10', 'Processing', '78 Koramangala, Bengaluru'),
(1, '2026-05-15', 'Pending', '12 MG Road, Delhi'),
(4, '2026-06-01', 'Delivered', '9 Anna Nagar, Chennai'),
(5, '2026-06-05', 'Cancelled', '22 Connaught Place, Delhi'),
(6, '2026-06-20', 'Delivered', '5 Park Street, Kolkata');


-- 5. OrderDetails (line items per order)
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 2, 599.00),
(1, 7, 1, 350.00),
(2, 5, 1, 1799.00),
(3, 10, 1, 1299.00),
(3, 9, 1, 899.00),
(4, 2, 1, 1999.00),
(5, 8, 3, 399.00),
(6, 12, 1, 2499.00),
(7, 4, 4, 449.00),
(7, 11, 2, 699.00);


-- 6. Payments (one per order, except the pending one which has no payment yet)
INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod, PaymentStatus) VALUES
(1, '2026-05-01', 1548.00, 'UPI', 'Completed'),
(2, '2026-05-03', 1799.00, 'CreditCard', 'Completed'),
(3, '2026-05-10', 2198.00, 'DebitCard', 'Completed'),
(5, '2026-06-01', 1197.00, 'UPI', 'Completed'),
(6, '2026-06-05', 2499.00, 'CreditCard', 'Refunded'),
(7, '2026-06-20', 3194.00, 'COD', 'Completed');