-- Drop the database if it exists and create a new one
DROP DATABASE IF EXISTS github;
CREATE DATABASE github;
GO

USE github;
GO

-- Create Roles table
CREATE TABLE Roles (
    roleID INT IDENTITY(1,1) PRIMARY KEY,
    roleName VARCHAR(100)
);
GO

-- Create Users table
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    userName NVARCHAR(100),
    roleID INT,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    phone int,
    status INT,
    FOREIGN KEY (roleID) REFERENCES Roles(roleID)
);
GO

-- Create Employees table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FOREIGN KEY (EmpID) REFERENCES Users(UserID)
);
GO

-- Create Customers table
CREATE TABLE Customers (
    CustID INT PRIMARY KEY,
    points INT,
    birthday DATE,
    province_city NVARCHAR(100),
    district NVARCHAR(100),
    ward NVARCHAR(100),
    detailAddress VARCHAR(255),
    FOREIGN KEY (CustID) REFERENCES Users(UserID)
);
GO

CREATE TABLE PasswordRecovery (
    ResetID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    token VARCHAR(100),
    expiredDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    tokenStatus INT
);
GO  

-- Create Brands table
CREATE TABLE Brands (
    BrandID INT IDENTITY(1,1) PRIMARY KEY,
    BrandName VARCHAR(100),
	image VARCHAR(MAX),
    status INT
);
GO

-- Create Products table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    productName VARCHAR(100),
    description VARCHAR(100),
    NumberOfPurchasing INT,
    status INT,
    BrandID INT,
    FOREIGN KEY (BrandID) REFERENCES Brands(BrandID)
);
GO

-- Create ProductDetails table
CREATE TABLE ProductDetails (
    ProductDetailsID INT IDENTITY(1,1) PRIMARY KEY,
	ProductID INT,
    color VARCHAR(50),
    size VARCHAR(50),
    stockQuantity INT,
    price INT,
    importDate DATE,
    image VARCHAR(MAX),
	status INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Create OverseeProducts table
CREATE TABLE OverseeProducts (
	HistoryID INT IDENTITY(1,1),
    EmpID INT,
    ProductID INT,
	FieldOld VARCHAR(MAX),
	[Action] VARCHAR(MAX),
	FieldNew VARCHAR(MAX),
    PRIMARY KEY (EmpID, ProductID, HistoryID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	ChangeDate DATETIME DEFAULT GETDATE()
);
GO

-- Create OverseeProducts table
CREATE TABLE OverseeProductDetail (
    HistoryID INT IDENTITY(1,1),
    EmpID INT,
    ProductDetailsID INT,
	FieldOld VARCHAR(MAX),
	[Action] VARCHAR(MAX),
	FieldNew VARCHAR(MAX),
    PRIMARY KEY (EmpID, ProductDetailsID, HistoryID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (ProductDetailsID) REFERENCES ProductDetails(ProductDetailsID),
	ChangeDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE SuperviseEmployees (
    HistoryID INT IDENTITY(1,1),
	UserID INT,
    EmpID INT,
	FieldOld VARCHAR(max),
	[Action] VARCHAR(max),
	FieldNew VARCHAR(max),
    PRIMARY KEY (EmpID, UserID, HistoryID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
	ChangeDate DATETIME DEFAULT GETDATE()
);
GO

-- Create SuperviseCustomers table
CREATE TABLE SuperviseCustomers (
    HistoryID INT IDENTITY(1,1),
	UserID INT,
    EmpID INT,
	FieldOld VARCHAR(max),
	[Action] VARCHAR(max),
	FieldNew VARCHAR(max),
    PRIMARY KEY (EmpID, UserID, HistoryID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
	ChangeDate DATETIME DEFAULT GETDATE()
);
GO

-- Create Supports table
CREATE TABLE Supports (
    SupportID INT IDENTITY(1,1) PRIMARY KEY,
    status INT,
	title Nvarchar(100),
    requestDate DATE,
    requestMessage NVARCHAR(100),
    CustID INT,
    FOREIGN KEY (CustID) REFERENCES Customers(CustID)
);
GO

-- Create ProcessSupports table
CREATE TABLE ProcessSupports (
    EmpID INT,
    SupportID INT,
    responseMessage NVARCHAR(100),
	title Nvarchar(100),
    responseDate DATE,
    PRIMARY KEY (EmpID, SupportID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (SupportID) REFERENCES Supports(SupportID)
);
GO

-- Create Promotions table
CREATE TABLE Promotions (
    PromotionID INT IDENTITY(1,1) PRIMARY KEY,
    promotionName VARCHAR(100),
    startDate DATE,
    endDate DATE,
    discountPer DECIMAL(5, 2),
	description varchar(100),
	image VARCHAR(MAX),
    condition INT,
	status INT
);
GO

-- Create Wishlists table
CREATE TABLE Wishlists (
    WishlistID INT IDENTITY(1,1) PRIMARY KEY,
    CustID INT UNIQUE,
    status INT,
    FOREIGN KEY (CustID) REFERENCES Customers(CustID)
);
GO

-- Create WishlistDetails table
CREATE TABLE WishlistDetails (
    WishlistID INT,
    ProductID INT,
    status INT,
	ProductDetailsID INT,
	PRIMARY KEY (WishlistID, ProductID, ProductDetailsID),
	FOREIGN KEY (WishlistID) REFERENCES Wishlists(WishlistID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	FOREIGN KEY (ProductDetailsID) REFERENCES ProductDetails(ProductDetailsID)
);
GO

-- Create Carts table
CREATE TABLE Carts (
    CartID INT IDENTITY(1,1) PRIMARY KEY,
    totalPrice DECIMAL(10, 2), --CHange totalPrice from int to Decimal
    status INT,
    CustID INT,
	PromotionID INT,
    FOREIGN KEY (CustID) REFERENCES Customers(CustID),
	FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID)
);
GO

-- Create CartDetails table
CREATE TABLE CartDetails (
    CartID INT,
    ProductID INT,
	ProductDetailsID INT,
	quantity INT,
	price INT,
    PRIMARY KEY (CartID, ProductID, ProductDetailsID),
    FOREIGN KEY (CartID) REFERENCES Carts(CartID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	FOREIGN KEY (ProductDetailsID) REFERENCES ProductDetails(ProductDetailsID)
);
GO


-- Create Orders table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    status INT,
    total DECIMAL(10, 2), 
	orderDate DATE,
    CustID INT,
    promotionID INT,
    CartID INT,
    userName NVARCHAR(100),
    city NVARCHAR(100), 
    district NVARCHAR(100),
    ward NVARCHAR(100),
    address NVARCHAR(100),
    phone INT,
    note NVARCHAR(100),
    FOREIGN KEY (CustID) REFERENCES Customers(CustID),
    FOREIGN KEY (promotionID) REFERENCES Promotions(PromotionID),
    FOREIGN KEY (CartID) REFERENCES Carts(CartID)
);
GO

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
	ProductDetailsID INT,
    quantity INT,
    unitPrice INT,
	PRIMARY KEY (OrderID, ProductID, ProductDetailsID),
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	FOREIGN KEY (ProductDetailsID) REFERENCES ProductDetails(ProductDetailsID)
);
GO

-- Create ManageOrders table
CREATE TABLE ManageOrders (
	HistoryID INT IDENTITY(1,1),	
    OrderID INT,
    EmpID INT,
	FieldOld VARCHAR(MAX),
	[Action] VARCHAR(MAX),
	FieldNew VARCHAR(MAX),
    PRIMARY KEY (OrderID, EmpID, HistoryID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
	ChangeDate DATETIME DEFAULT GETDATE()
);
GO

-- Create ManagePromotions table
CREATE TABLE ManagePromotions (
    HistoryID INT IDENTITY(1,1),
    PromotionID INT,
    EmpID INT,
	FieldOld VARCHAR(MAX),
	[Action] VARCHAR(MAX),
	FieldNew VARCHAR(MAX),
    PRIMARY KEY (PromotionID, EmpID, HistoryID),
    FOREIGN KEY (PromotionID) REFERENCES Promotions(PromotionID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
	ChangeDate DATETIME DEFAULT GETDATE()
);
GO


-- Create ManageBrands table
CREATE TABLE ManageBrands (
	HistoryID INT IDENTITY(1,1),
    BrandID INT,
    EmpID INT,
	FieldOld VARCHAR(max),
	[Action] VARCHAR(max),
	FieldNew VARCHAR(max),
    PRIMARY KEY (BrandID, EmpID, HistoryID),
    FOREIGN KEY (BrandID) REFERENCES Brands(BrandID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
	ChangeDate DATETIME DEFAULT GETDATE()
);
GO

-- Create Categories table
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoriesName VARCHAR(100),
    Description VARCHAR(100),
	image VARCHAR(MAX),
    status INT
);
GO

-- Create ChildrenCategories table
CREATE TABLE ChildrenCategories (
    CDCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoriesName VARCHAR(100),
    ParentID INT,
    status INT,
    FOREIGN KEY (ParentID) REFERENCES Categories(CategoryID)
);
GO

-- Create ManageCategories table
CREATE TABLE ManageCategories (
	HistoryID INT IDENTITY(1,1),
    Categories INT,
    EmpID INT,
	FieldOld VARCHAR(MAX),
	[Action] VARCHAR(MAX),
	FieldNew VARCHAR(MAX),
    PRIMARY KEY (Categories, EmpID, HistoryID),
    FOREIGN KEY (Categories) REFERENCES Categories(CategoryID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
	ChangeDate DATETIME DEFAULT GETDATE()
);
GO

-- Create ManageCDCategories table
CREATE TABLE ManageCDCategories (
    HistoryID INT IDENTITY(1,1),
    CDCategoryID INT,
    EmpID INT,
	FieldOld VARCHAR(MAX),
	[Action] VARCHAR(MAX),
	FieldNew VARCHAR(MAX),
    PRIMARY KEY (CDCategoryID, EmpID, HistoryID),
    FOREIGN KEY (CDCategoryID) REFERENCES ChildrenCategories(CDCategoryID),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
	ChangeDate DATETIME DEFAULT GETDATE()
);
GO

-- Create ProductBelongtoCategories table
CREATE TABLE ProductBelongtoCategories (
    ProductID INT,
    Categories INT,
    PRIMARY KEY (ProductID, Categories),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (Categories) REFERENCES Categories(CategoryID)
);
GO

-- Create ProductBelongtoCDCategories table
CREATE TABLE ProductBelongtoCDCategories (
    ProductID INT,
    CDCategoryID INT,
    PRIMARY KEY (ProductID, CDCategoryID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CDCategoryID) REFERENCES ChildrenCategories(CDCategoryID)
);
GO

DELETE From Users where UserID = 5;

SELECT * FROM Roles;
SELECT * FROM Users;
SELECT * FROM Carts WHERE CustID = 3 AND status = 1
SELECT * FROM Employees;
SELECT * FROM Customers c JOIN Users u ON c.CustID = u.UserID;
SELECT * FROM Brands;
SELECT * FROM Products;
SELECT * FROM ProductDetails;

SELECT * FROM Supports WHERE CustID like '%%' OR status like '%%' OR SupportID like '%%' OR requestDate like '%%' OR requestMessage like '%%';
SELECT *  FROM Supports s 
INNER JOIN Customers c ON s.CustID = c.CustID
INNER JOIN Users u ON c.CustID = u.UserID
WHERE u.userName like '%%'

SELECT * FROM Supports s 
INNER JOIN Customers c ON s.CustID = c.CustID
INNER JOIN Users u ON c.CustID = u.UserID
WHERE s.SupportID = 1;
SELECT * FROM Promotions;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM ManageOrders;

SELECT * FROM Categories;
SELECT * FROM ChildrenCategories;
SELECT * FROM ProductBelongtoCategories;
SELECT * FROM ProductBelongtoCDCategories;
SELECT * FROM ManageCategories;
SELECT * FROM ManageBrands;
SELECT * FROM ManagePromotions;
SELECT * FROM WishlistDetails;
SELECT * FROM Wishlists;
SELECT * FROM CartDetails;
SELECT * FROM Carts;
SELECT * FROM ProductDetails;
SELECT * FROM OverseeProducts;
SELECT * FROM SuperviseEmployees;
SELECT * FROM SuperviseCustomers;
SELECT * FROM Supports;
SELECT * FROM ProcessSupports;
SELECT * FROM ForgetPassword;
SELECT * FROM ForgetPassword WHERE token = '26c77a61-0541-4d57-b6cc-afbb56b9d50f' AND expiredDate > GETDATE() AND tokenStatus = 1


INSERT INTO Roles (roleName) VALUES ('System Manager');
INSERT INTO Roles (roleName) VALUES ('Shop Manager');
INSERT INTO Roles (roleName) VALUES ('Shop Staff');
INSERT INTO Roles (roleName) VALUES ('Customer');


INSERT INTO Users (userName, roleID, email, password, phone, status) VALUES ('admin', 1, 'admin@gmail.com', '123', 123456789, 1);
INSERT INTO Users (userName, roleID, email, password, phone, status) VALUES ('manager', 2, 'manager@gmail.com', '123', 987654321, 1);
INSERT INTO Users (userName, roleID, email, password, phone, status) VALUES ('employee', 3, 'employee@gmail.com', '123', 1234567890, 1);
INSERT INTO Users (userName, roleID, email, password, phone, status) VALUES ('customer', 4, 'customer@gmail.com', '123', 1234467890, 1);


INSERT INTO Employees (EmpID) VALUES (1);
INSERT INTO Employees (EmpID) VALUES (2);
INSERT INTO Employees (EmpID) VALUES (3);

INSERT INTO Customers (CustID, points, birthday, province_city, district, ward, detailAddress) VALUES (4,0, '2000-01-01', 'HCM', '1', 'Da Kao', '123 Nguyen Dinh Chieu');

INSERT INTO Promotions(promotionName, startDate, endDate, discountPer, description, condition) VALUES('SALE50', '2024-01-01', '2024-02-01', 50.00,'Happy Sale', 100);
INSERT INTO Promotions(promotionName, startDate, endDate, discountPer, description, condition) VALUES('SALE35', '2024-01-01', '2024-02-01', 35.00,'Happy Sale', 50);
INSERT INTO Promotions(promotionName, startDate, endDate, discountPer, description, condition) VALUES('NOSALE', '2024-01-01', '2024-02-01', 0,'Sad No Sale', 0);
INSERT INTO Promotions(promotionName, startDate, endDate, discountPer, description, condition,status) VALUES('SALEFORALL', '2024-01-01', '2024-02-01', 20,'Sad No Sale', 0,1);

INSERT INTO Brands (BrandName, status) VALUES ('Adidas', 1);
INSERT INTO Brands (BrandName, status) VALUES ('Nike', 1);
INSERT INTO Brands (BrandName, status) VALUES ('Puma', 1);
INSERT INTO [Supports] (status, title, requestDate, requestMessage, CustID) VALUES (1,'HELP', '2021-01-01', 'Help me', 4);
INSERT INTO [Supports] (status, title, requestDate, requestMessage, CustID) VALUES (0,'HELP', '2021-01-01', 'Help me', 7);
INSERT INTO [Supports] (status, title, requestDate, requestMessage, CustID) VALUES (0,'HELP', '2021-01-01', 'Help me', 7);
INSERT INTO [Supports] (status, title, requestDate, requestMessage, CustID) VALUES (0,'HELP', '2021-01-01', 'Help me', 7);
INSERT INTO [Supports] (status, title, requestDate, requestMessage, CustID) VALUES (1,'HELP', '2021-01-01', 'Help me', 7);
INSERT INTO [Supports] (status, title, requestDate, requestMessage, CustID) VALUES (1,'HELP', '2021-01-01', 'Help me', 7);
INSERT INTO [Supports] (status, title, requestDate, requestMessage, CustID) VALUES (1,'HELP', '2021-01-01', 'Help me', 7);
INSERT INTO [Supports] (status, title, requestDate, requestMessage, CustID) VALUES (1,'HELP', '2021-01-01', 'Help me', 7);
INSERT INTO [Supports] (status, title, requestDate, requestMessage, CustID) VALUES (1,'HELP', '2021-01-01', 'Help me', 7);
DELETE FROM Supports
INSERT INTO [Supports] (status, title, requestDate, requestMessage, CustID) VALUES (1,'TEST', '2021-01-01', 'Help me', 8);


INSERT INTO Products (productName, description, NumberOfPurchasing, status, BrandID) VALUES ('Shoes', 'Good', 0, 1, 1);


INSERT INTO  ProcessSupports (EmpID, SupportID, title, responseMessage, responseDate) VALUES (3, 2,'SHOP REPLY YOUR SUPPORT', 'I will help you', GETDATE());
DELETE FROM ProcessSupports WHERE EmpID = 3 AND SupportID = 1;
SELECT * FROM CartDetails
SELECT * FROM Carts

INSERT INTO CartDetails(CartID,ProductID,ProductDetailsID,quantity, price) VALUES (2,2,3,2,5000000),(2,2,4,1,5000000);
INSERT INTO Carts (totalPrice, status, CustID, PromotionID) VALUES (12000000,0,2,1);

SELECT * FROM Orders
INSERT INTO Orders (status, total, orderDate, CustID, promotionID, CartID, userName, city, district, ward, address, phone) 
			VALUES (0, 1000000, '2021-01-21', 3, 1 , 2, 'Nhu','HCM','1','ben nghe','111','0123456787');
INSERT INTO Orders (status, total, orderDate, CustID, promotionID, CartID, userName, city, district, ward, address, phone) 
			VALUES (1, 15000000, '2021-01-22', 3, 2 , 2, 'Nhu','HCM','1','ben nghe','111','0123456787');
INSERT INTO Orders (status, total, orderDate, CustID, promotionID, CartID, userName, city, district, ward, address, phone) 
			VALUES (2, 7000000, '2021-01-23', 3, 3 , 2, 'Nhu','HCM','1','ben nghe','111','0123456787');
INSERT INTO Orders (status, total, orderDate, CustID, promotionID, CartID, userName, city, district, ward, address, phone) 
			VALUES (3, 2500000, '2021-01-24', 3, 1 , 2, 'Nhu','HCM','1','ben nghe','111','0123456787');
INSERT INTO Orders (status, total, orderDate, CustID, promotionID, CartID, userName, city, district, ward, address, phone) 
			VALUES (4, 5000000, '2021-01-25', 3, 1 , 2, 'Nhu','HCM','1','ben nghe','111','0123456787');
INSERT INTO Products (productName, description, NumberOfPurchasing, status, BrandID) VALUES ('Shoes', 'Good', 0, 1, 1);
INSERT INTO OrderDetails (orderID, productID, quantity, unitPrice) VALUES (2, 2, 1, 100) 

INSERT INTO OrderDetails (OrderID, ProductID, ProductDetailsID, quantity, unitPrice)
VALUES (1, 1, 1, 2, 5000000),(2, 1, 2, 2, 5000000),(3, 1, 3, 2, 5000000),(4, 1, 4, 2, 5000000),(5, 1, 5, 2, 5000000),(5, 1, 4, 2, 5000000)

UPDATE Orders SET status = 0 WHERE OrderID = 1
SELECT * FROM Products
-- ALTER TABLE Products
-- ALTER COLUMN status int;
-- ALTER TABLE Products
-- ALTER COLUMN description nvarchar(255);
SELECT * FROM ForgetPassword WHERE token = '3c9894b9-6266-4f3d-9dbf-272a70c2ac12' AND expiredDate > GETDATE() AND tokenStatus = 1
SELECT TOP 1 * FROM ForgetPassword WHERE userID = 8 AND tokenStatus = 1 ORDER BY ResetID DESC 
SELECT * FROM Users

SELECT* FROM ForgetPassword

SELECT SUM(c.quantity * pd.price) FROM Carts c 
INNER JOIN CartDetails cd ON cd.CartID = c.CartID
INNER JOIN Products p ON p.ProductID = cd.ProductID
INNER JOIN ProductDetails pd ON pd.ProductID = p.ProductID
WHERE c.CartID = 
SELECT * FROM ProcessSupports WHERE supportID = 1

INSERT INTO Carts()
SELECT * FROM Customers
INSERT INTO Supports (status, requestDate, requestMessage, CustID) VALUES (0, '2021-01-01', 'Help me', 4);
SELECT *  FROM Supports INNER JOIN Customers c ON s.CustID = c.CustID
INNER JOIN Users u ON c.CustID = u.UserID
WHERE u.userName like '%%'


--Insert data to cart ,cart details, product, product details for checkout
INSERT INTO Carts (totalPrice, CustID) VALUES (100,12);
INSERT INTO CartDetails (CartID, ProductID, ProductDetailsID, quantity, price) VALUES (2, 1, 2, 1, 100);
INSERT INTO Products (productName, description, NumberOfPurchasing, status, BrandID) VALUES ('Shoes', 'Good', 0, 1, 1);
INSERT INTO ProductDetails (ProductDetailsID, ProductID, color, size, stockQuantity, price, importDate, image, status) VALUES (1, 1, 'Red', 'M', 10, 100, '2021-01-01', 'image', 1);
INSERT INTO Users(userName, roleID, email, password, phone, status) VALUES('',4,'','',423, 1)
SELECT * FROM Users
SELECT * FROM ProductDetails
INSERT INTO ProductDetails (ProductDetailsID, ProductID, color, size, stockQuantity, price, importDate, image, status) VALUES (2, 1, 'Red', 'M', 10, 100, '2021-01-01', 'image', 1);

DELETE From Users where UserID = 1002;

DBCC CHECKIDENT ('Users', RESEED, 0);
-- The next inserted row will have ID = 1
SELECT * FROM Carts
INSERT INTO Orders (status, total, orderDate, CustID, promotionID, CartID, userName, city, district, ward, address, phone, note) 
            VALUES (3, 100, '2021-01-01', 12, 3 , 2, 'Nhu','HCM','1','ben nghe','111','0123456787', 'note');
SELECT * FROM Orders o 
INNER JOIN Customers c ON o.CustID = c.CustID
INNER JOIN Users u ON c.CustID = u.UserID
WHERE OrderID = 2

SELECT * FROM Promotions
INSERT INTO Promotions (promotionName, startDate, endDate, discountPer, description, condition) VALUES ('SALE50', '2024-01-01', '2024-02-01', 50.00,'Happy Sale', 100);
INSERT INTO Promotions (promotionName, startDate, endDate, discountPer, description, condition) VALUES ('NOSALE', '2024-01-01', '2024-02-01', 0.00,'Happy Sale', 100);

