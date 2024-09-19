
-- Project Title: SQL Stored Procedure Operations

-- Agenda Stored Procedure
-- A stored procedure is a precompiled collection of SQL statements and optional control-of-flow statements 
-- that are stored in a database. It can be executed multiple times with different parameters, allowing for reuse of the same 
-- code. Stored procedures can include SELECT, INSERT, UPDATE, DELETE operations, and can also handle complex logic using loops, 
-- conditional statements, transactions, and error handling.

--Why use Store Procedure - By grouping SQL statements, a stored procedure allows them to be executed with a single call.

CREATE DATABASE STORE_PROCEDURE
USE STORE_PROCEDURE

Create Table Customers
(
CustomerID INT IDENTITY(1,1) PRIMARY KEY,
CustomerName NVARCHAR(50),
EMAIL NVARCHAR(50),
Phone NVARCHAR(15),
Status NVARCHAR(50),
)
INSERT INTO Customers VALUES('Vinay Chauhan','Vinay.C001@gmail.com','8800114455','Active'),
('Vikrant Gupta','VikrantG00@2gmail.com','7700663355','Active'),
('Ravi Sharma','RaviS003@gmail.com','9955330011','Inactive'),
('Aarti verma','AartiV004@gmail.com','6655440022','Inactive'),
('Ankush Sharma','AnkushS005@gmail.com','4455660088','Active')

SELECT * FROM Customers

Create Table Orders
(
OrderID INT IDENTITY(1,1) PRIMARY KEY,
CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
OrderDate DATE,
Amount DECIMAL(10,2)
)
INSERT INTO Orders VALUES(1,'2024-09-18',150.00),
(2,'2024-09-19',200.00),
(3,'2024-09-15',250.00),
(4,'2024-09-14',300.00),
(5,'2024-09-15',350.00)

SELECT * FROM Orders

Create Table OrderItems
(
OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
ProductID INT,
Quantity INT,
UnitPrice DECIMAL(10,2)
)
INSERT INTO OrderItems VALUES(1,101,2,50.00),
(2,102,1,50.00),
(3,103,4,50.00),
(4,104,10,80.00),
(5,105,15,110.00)

SELECT * FROM OrderItems

--1. Simple Stored Procedure
-- This procedure retrieves all customers from the Customers table.

CREATE PROCEDURE GetAllCustomers
AS
BEGIN
    SELECT * FROM Customers
END

EXEC GetAllCustomers

--2. Stored Procedure with Parameters
-- This procedure retrieves customer details by CustomerID.

CREATE PROCEDURE GetCustomerByID
@CustomerID INT
AS
BEGIN
     SELECT * FROM Customers WHERE CustomerID = @CustomerID
END

EXEC GetCustomerByID 4

--3. Stored Procedure with Output Parameters
-- This procedure calculates the total amount of a specific order and returns it via an output parameter.

CREATE PROCEDURE GetOrderTotal
@OrderID INT,
@TotalAmount DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @TotalAmount = SUM(UnitPrice * Quantity) FROM OrderItems WHERE OrderID = @OrderID
END

DECLARE @TotalAmount DECIMAL(10, 2);
EXEC GetOrderTotal 1, @TotalAmount OUTPUT;
SELECT @TotalAmount AS TotalOrderAmount;

--4.Stored Procedure with Multiple Parameters
--This procedure retrieves orders based on CustomerID and OrderDate.

CREATE PROCEDURE GetCustomerOrders
@CustomerID INT,
@OrderDate Date
AS
BEGIN
    SELECT * FROM Orders WHERE CustomerID = @CustomerID AND OrderDate = @OrderDate
END

EXEC GetCustomerOrders 2, '2024-09-19'
