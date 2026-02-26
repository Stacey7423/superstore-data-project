----Для пересоздания БД при ошибках загрузки
--USE master
--GO
---- Закрытие соединений к Superstore
--ALTER DATABASE Superstore SET SINGLE_USER WITH ROLLBACK IMMEDIATE
--GO
--DROP DATABASE Superstore
--GO
-- CREATE DATABASE Superstore
-- GO

USE Superstore
GO

CREATE TABLE Customers
(CustomerID NVARCHAR(50) PRIMARY KEY,
CustomerName NVARCHAR(50),
Segment NVARCHAR(50))
GO

CREATE TABLE Dates
(DateID DATE PRIMARY KEY,
DateDay INTEGER,
DateWeek INTEGER,
DateMonth INTEGER,
DateQuarter INTEGER,
DateYear INTEGER,
IsWeekend BIT,
DayNumberOfWeek INTEGER)
GO

CREATE TABLE Products
(ProductID NVARCHAR(50) PRIMARY KEY,
Category NVARCHAR(50),
SubCategory NVARCHAR(50))
GO

CREATE TABLE ProductVersions
(ProductID NVARCHAR(50),
VersionID INTEGER,
ProductName NVARCHAR(MAX),
PRIMARY KEY (ProductID, VersionID),
CONSTRAINT FK_ProductVersions_ProductID FOREIGN KEY(ProductID) REFERENCES Products(ProductID))
GO

CREATE TABLE States
(StateID INTEGER PRIMARY KEY,
StateName NVARCHAR(50),
Region NVARCHAR(50),
Country NVARCHAR(50))

CREATE TABLE Locations
(LocationID INTEGER PRIMARY KEY,
StateID INTEGER,
City NVARCHAR(50),
PostalCode NVARCHAR(50),
CONSTRAINT FK_Locations_StateID FOREIGN KEY(StateID) REFERENCES States(StateID))

CREATE TABLE Promotions
(StateID INTEGER,
ProductID NVARCHAR(50),
Discount DECIMAL(3, 2),
PRIMARY KEY(StateID, ProductID),
CONSTRAINT FK_Promotions_StateID FOREIGN KEY(StateID) REFERENCES States(StateID),
CONSTRAINT FK_Promotions_ProductID FOREIGN KEY(ProductID) REFERENCES Products(ProductID))

CREATE TABLE ShipModes
(ShipModeID INTEGER PRIMARY KEY,
ShipMode NVARCHAR(50))

CREATE TABLE Orders
(OrderID NVARCHAR(50) PRIMARY KEY,
CustomerID NVARCHAR(50),
OrderDate DATE,
ShipDate DATE,
ShipModeID INTEGER,
CONSTRAINT FK_Orders_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
CONSTRAINT FK_Orders_ShipModeID FOREIGN KEY (ShipModeID) REFERENCES ShipModes(ShipModeID),
CONSTRAINT FK_Orders_OrderDate FOREIGN KEY(OrderDate) REFERENCES Dates(DateID),
CONSTRAINT FK_Orders_ShipDate FOREIGN KEY(ShipDate) REFERENCES Dates(DateID))

CREATE TABLE OrderProducts
(OrderID NVARCHAR(50),
ProductID NVARCHAR(50),
VersionID INTEGER,
LocationID INTEGER,
Sales DECIMAL(10, 2),
Quantity INTEGER,
Profit DECIMAL(10, 2),
PRIMARY KEY(OrderID, ProductID, VersionID),
CONSTRAINT FK_OrderProducts_OrderID FOREIGN KEY(OrderID) REFERENCES Orders(OrderID),
CONSTRAINT FK_OrderProducts_ProductID_VersionID FOREIGN KEY(ProductID, VersionID) REFERENCES ProductVersions(ProductID, VersionID),
CONSTRAINT FK_OrderProducts_LocationID FOREIGN KEY(LocationID) REFERENCES Locations(LocationID))

