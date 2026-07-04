/* ============================================================
   ECOMMERCE PROJECT - STEP 1: DATABASE + TABLES
   Topics used: Database Concepts, Data Types, Constraints, PK/FK,
                CREATE
   ============================================================ */

-- 1. Create the database
CREATE DATABASE ECommerceDB;
GO

USE ECommerceDB;
GO

-- 2. Categories table
CREATE TABLE Categories (
    CategoryID      INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName    VARCHAR(50)  NOT NULL UNIQUE,
    Description     VARCHAR(255) NULL
);
GO

-- 3. Products table
CREATE TABLE Products (
    ProductID       INT IDENTITY(1,1) PRIMARY KEY,
    ProductName     VARCHAR(100)   NOT NULL,
    CategoryID      INT            NOT NULL,
    Price           DECIMAL(10,2)  NOT NULL CHECK (Price >= 0),
    StockQuantity   INT            NOT NULL DEFAULT 0 CHECK (StockQuantity >= 0),
    IsActive        BIT            NOT NULL DEFAULT 1,
    CreatedDate     DATETIME       NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Products_Categories
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
GO

-- 4. Customers table
CREATE TABLE Customers (
    CustomerID      INT IDENTITY(1,1) PRIMARY KEY,
    FirstName       VARCHAR(50)  NOT NULL,
    LastName        VARCHAR(50)  NOT NULL,
    Email           VARCHAR(100) NOT NULL UNIQUE,
    Phone           VARCHAR(20)  NULL,
    City            VARCHAR(50)  NULL,
    State           VARCHAR(50)  NULL,
    Country         VARCHAR(50)  NULL,
    RegisterDate    DATETIME     NOT NULL DEFAULT GETDATE()
);
GO

-- 5. Orders table
CREATE TABLE Orders (
    OrderID         INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID      INT           NOT NULL,
    OrderDate       DATETIME      NOT NULL DEFAULT GETDATE(),
    Status          VARCHAR(20)   NOT NULL DEFAULT 'Pending'
                    CHECK (Status IN ('Pending','Processing','Shipped','Delivered','Cancelled')),
    ShippingAddress VARCHAR(255)  NOT NULL,

    CONSTRAINT FK_Orders_Customers
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

-- 6. OrderDetails table (line items)
CREATE TABLE OrderDetails (
    OrderDetailID   INT IDENTITY(1,1) PRIMARY KEY,
    OrderID         INT           NOT NULL,
    ProductID       INT           NOT NULL,
    Quantity        INT           NOT NULL CHECK (Quantity > 0),
    UnitPrice       DECIMAL(10,2) NOT NULL CHECK (UnitPrice >= 0),

    CONSTRAINT FK_OrderDetails_Orders
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Products
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- 7. Payments table
CREATE TABLE Payments (
    PaymentID       INT IDENTITY(1,1) PRIMARY KEY,
    OrderID         INT           NOT NULL UNIQUE, -- one payment per order
    PaymentDate     DATETIME      NOT NULL DEFAULT GETDATE(),
    Amount          DECIMAL(10,2) NOT NULL CHECK (Amount >= 0),
    PaymentMethod   VARCHAR(20)   NOT NULL
                    CHECK (PaymentMethod IN ('CreditCard','DebitCard','UPI','NetBanking','COD')),
    PaymentStatus   VARCHAR(20)   NOT NULL DEFAULT 'Pending'
                    CHECK (PaymentStatus IN ('Pending','Completed','Failed','Refunded')),

    CONSTRAINT FK_Payments_Orders
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
GO
