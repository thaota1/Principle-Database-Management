
/*Author TaThiPhuongThao - ITDSIU20082*/

/*LAB 2*/
/*PART 3*/
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'ApressFinancial')
DROP DATABASE [ApressFinancial]
GO
CREATE DATABASE ApressFinancial 
GO 

USE [ApressFinancial]
GO
CREATE SCHEMA [TransactionDetails] AUTHORIZATION dbo
GO
CREATE SCHEMA [ShareDetails] AUTHORIZATION dbo
GO
CREATE SCHEMA [CustomerDetails] AUTHORIZATION dbo

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CustomerDetails].[Customers](
	[CustomerId] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerTitleId] [int] NOT NULL,
	[CustomerFirstName] [nvarchar](50) NOT NULL,
	[CustomerOtherInitials] [nvarchar](50) NULL,
	[CustomerLastName] [nvarchar](50) NOT NULL,
	[AddressId] [bigint] NOT NULL,
	[AccountNumber] [nvarchar](15) NOT NULL,
	[AccountTypeId] [int] NOT NULL,
	[ClearedBalance] [money] NOT NULL,
	[UnclearedBalance] [money] NOT NULL,
	[DateAddedd] [datetime] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY NONCLUSTERED 
(
	[CustomerId] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CustomerDetails].[CustomerProducts](
	[CustomerFinancialProductId] [bigint] NOT NULL,
	[CustomerId] [bigint] NOT NULL,
	[FinancialProductId] [bigint] NOT NULL,
	[AmountToCollect] [money] NOT NULL,
	[Frequency] [smallint] NOT NULL,
	[LastCollected] [datetime] NOT NULL,
	[LastCollection] [datetime] NOT NULL,
	[Renewable] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerProducts] PRIMARY KEY CLUSTERED 
(
	[CustomerFinancialProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [CustomerDetails].[CustomerProducts]  WITH CHECK ADD  CONSTRAINT [FK_Customers_CustomerProducts] FOREIGN KEY(CustomerId)
REFERENCES [CustomerDetails].[Customers](CustomerId)
GO  

CREATE TABLE TransactionDetails.Transactions
(TransactionId bigint IDENTITY(1,1) NOT NULL,
CustomerId bigint NOT NULL,
TransactionType int NOT NULL,
DateEntered datetime NOT NULL,
Amount numeric(18, 5) NOT NULL,
ReferenceDetails nvarchar(50) NULL,
Notes nvarchar(max) NULL,
RelatedShareId bigint NULL,
RelatedProductId bigint NOT NULL) 
 GO
CREATE TABLE TransactionDetails.TransactionTypes(
TransactionTypeId int IDENTITY(1,1) NOT NULL,
TransactionDescription nvarchar(30) NOT NULL,
CreditType bit NOT NULL
)
GO

USE ApressFinancial
GO
CREATE TABLE CustomerDetails.FinancialProducts(
ProductId bigint NOT NULL,
ProductName nvarchar(50) NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE ShareDetails.SharePrices(
SharePriceId bigint IDENTITY(1,1) NOT NULL,
ShareId bigint NOT NULL,
Price numeric(18, 5) NOT NULL,
PriceDate datetime NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE ShareDetails.Shares(
ShareId bigint IDENTITY(1,1) NOT NULL,
ShareDesc nvarchar(50) NOT NULL,
ShareTickerId nvarchar(50) NULL,
CurrentPrice numeric(18, 5) NOT NULL
) ON [PRIMARY]
GO 
/*IC*/
GO
ALTER TABLE TransactionDetails.TransactionTypes
ADD AffectCashBalance bit NULL
GO

ALTER TABLE TransactionDetails.TransactionTypes
ALTER COLUMN AffectCashBalance bit NOT NULL
GO
 /*-------*/

/*PART 4*/
/*RELATIONSHIP*/
ALTER TABLE [TransactionDetails].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Transactions] FOREIGN KEY(CustomerId)
REFERENCES [CustomerDetails].[Customers](CustomerId)
GO 

ALTER TABLE ShareDetails.SharePrices  WITH CHECK ADD  CONSTRAINT [FK_SharePrice_Shares] FOREIGN KEY(ShareId)
REFERENCES ShareDetails.Shares(ShareId)
GO 
/*-------*/
/*IC*/
ALTER TABLE CustomerDetails.CustomerProducts
WITH NOCHECK
ADD CONSTRAINT CK_CustProds_AmtCheck
CHECK ((AmountToCollect > 0))
GO

ALTER TABLE CustomerDetails.CustomerProducts WITH NOCHECK
ADD CONSTRAINT DF_CustProd_Renewable
DEFAULT (0)
FOR Renewable 

/*--------*/
/*INSERT SOME VALUE*/
INSERT INTO CustomerDetails.Customers
(CustomerTitleId,CustomerFirstName,CustomerOtherInitials,
CustomerLastName,AddressId,AccountNumber,AccountTypeId,
ClearedBalance,UnclearedBalance)
VALUES (3,'Bernie','I','McGee',314,65368765,1,6653.11,0.00),
(2,'Julie','A','Dewson',2134,81625422,1,53.32,-12.21),
(1,'Kirsty',NULL,'Hull',4312,96565334,1,1266.00,10.32) 

INSERT INTO ShareDetails.Shares
(ShareDesc, ShareTickerId,CurrentPrice)
VALUES ('FAT-BELLY.COM','FBC',45.20)
INSERT INTO ShareDetails.Shares
(ShareDesc, ShareTickerId,CurrentPrice)
VALUES ('NetRadio Inc','NRI',29.79)
INSERT INTO ShareDetails.Shares
(ShareDesc, ShareTickerId,CurrentPrice)
VALUES ('Texas Oil Industries','TOI',0.455)
INSERT INTO ShareDetails.Shares
(ShareDesc, ShareTickerId,CurrentPrice)
VALUES ('London Bridge Club','LBC',1.46)


SET QUOTED_IDENTIFIER OFF
GO
INSERT INTO [ApressFinancial].[ShareDetails].[Shares]
([ShareDesc]
,[ShareTickerId]
,[CurrentPrice])
      VALUES
("ACME'S HOMEBAKE COOKIES INC",
'AHCI',
2.34125) 
GO 
GO
INSERT INTO [ApressFinancial].[ShareDetails].[Shares]
([ShareDesc]
,[ShareTickerId]
,[CurrentPrice])
      VALUES
("FAT-BELLY.COM",
'AHCI', 

2.34125) 
GO 
/*----------*/ 

/*SELECT*/
SELECT * FROM CustomerDetails.Customers 

SELECT ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareDesc = "FAT-BELLY.COM" 

SELECT ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareTickerId = "AHCI" 

SELECT ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareDesc > 'FAT-BELLY.COM'
AND ShareDesc < 'TEXAS OIL INDUSTRIES' 

SELECT ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareDesc <> 'FAT-BELLY.COM'
SELECT ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE NOT ShareDesc = 'FAT-BELLY.COM'

/*---------*/

/*LAB 03 */ 
/*TASK 1 - UPDATING DATA*/
SELECT * FROM CustomerDetails.Customers  /*View all table*/

UPDATE CustomerDetails.Customers		/*update values with condition*/
SET CustomerLastName = 'Brodie'
WHERE CustomerId = 1 

SELECT * FROM CustomerDetails.Customers	/*view values that are satify condition*/
WHERE CustomerId = 1

/*update a row of information using the value within a variable, and a column from the same table */
DECLARE @ValueToUpdate VARCHAR(30) /* Khai bao Bien ao*/
SET @ValueToUpdate = 'McGlynn'		/*Set bien ao thanh value can update*/
UPDATE CustomerDetails.Customers
SET CustomerLastName = @ValueToUpdate, /*update theo bien ao*/
ClearedBalance = ClearedBalance + UnclearedBalance ,
UnclearedBalance = 0
WHERE CustomerLastName = 'Brodie'

/*update value with wrong data type*/
DECLARE @WrongDataType VARCHAR(20)
SET @WrongDataType = '4311.22'
UPDATE CustomerDetails.Customers
SET ClearedBalance = @WrongDataType
WHERE CustomerId = 1

/*view output if the code above*/
SELECT CustomerFirstName, CustomerLastName,
ClearedBalance, UnclearedBalance
FROM CustomerDetails.Customers
WHERE CustomerId = 1

/*numberic data type cannot update with wrong data type*/ /*ERROR CODE*/
DECLARE @WrongDataType2 VARCHAR(20)
SET @WrongDataType2 = '2.0'
UPDATE CustomerDetails.Customers
SET AddressId = @WrongDataType2  /*AddressId is numeric datatype(bigint), cannot update by varchar*/
WHERE CustomerId = 1

/*--------------------------------------------------------------------------------------------------*/
/*TASK 2 - TRANSACTION*/ 

SELECT 'Before',ShareId,ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareId = 2
BEGIN TRAN ShareUpd
UPDATE ShareDetails.Shares
SET CurrentPrice = CurrentPrice * 1.1
WHERE ShareId = 2
COMMIT TRAN
SELECT 'After',ShareId,ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareId = 2

SELECT 'Before',ShareId,ShareDesc,CurrentPrice
FROM ShareDetails.Shares
     WHERE ShareId = 2
BEGIN TRAN ShareUpd
UPDATE ShareDetails.Shares
SET CurrentPrice = CurrentPrice * 1.1
WHERE ShareId = 2
SELECT 'Within the transaction',ShareId,ShareDesc,CurrentPrice
FROM ShareDetails.Shares
ROLLBACK TRAN
SELECT 'After',ShareId,ShareDesc,CurrentPrice
FROM ShareDetails.Shares
WHERE ShareId = 2

BEGIN TRAN ShareUpd
SELECT '1st TranCount',@@TRANCOUNT
BEGIN TRAN ShareUpd2
SELECT '2nd TranCount',@@TRANCOUNT
COMMIT TRAN ShareUpd2
SELECT '3rd TranCount',@@TRANCOUNT
COMMIT TRAN -- It is at this point that data modifications will be committed
SELECT 'Last TranCount',@@TRANCOUNT

/*TASK 3*/
USE ApressFinancial
GO
SELECT CustomerFirstName + ' ' + CustomerLastName AS [Name],
ClearedBalance,UnclearedBalance
INTO CustTemp
FROM CustomerDetails.Customers 

BEGIN TRAN
DELETE CustTemp

BEGIN TRAN
SELECT * FROM CustTemp
DELETE CustTemp
SELECT * FROM CustTemp
ROLLBACK TRAN
SELECT * FROM CustTemp

BEGIN TRAN
SELECT * FROM CustTemp
DELETE TOP (2) CustTemp
SELECT * FROM CustTemp
ROLLBACK TRAN
SELECT * FROM CustTemp
GO


/*TASK 4*/ 
TRUNCATE TABLE CustomerDetails.Customers 

/*TASK 5*/
CREATE DATABASE EMPLOYEE
USE EMPLOYEE
GO
CREATE TABLE Employee(
Employeename varchar(30) NOT NULL,
street varchar(30) NOT NULL,
city varchar(30) NOT NULL
PRIMARY KEY(Employeename)
)
CREATE TABLE WORKS(
Employeename varchar(30) NOT NULL,
Companyname varchar(30) NOT NULL ,
Salary [money] NOT NULL
PRIMARY KEY(Employeename) 
)

CREATE TABLE COMPANY(
Companyname varchar(30) NOT NULL , 
city varchar(30) NOT NULL 
PRIMARY KEY(Companyname)
)
CREATE TABLE MANAGES(
Employeename varchar(30) NOT NULL,
Managername varchar(30) NOT NULL
PRIMARY KEY(Managername)
)

ALTER TABLE WORKS  WITH CHECK ADD  CONSTRAINT [FK_WORKS_Employee] FOREIGN KEY(Employeename)
REFERENCES Employee (Employeename)
ALTER TABLE WORKS  WITH CHECK ADD  CONSTRAINT [FK_WORKS_COMPANY] FOREIGN KEY(Companyname)
REFERENCES COMPANY (Companyname) 
ALTER TABLE MANAGES WITH CHECK ADD  CONSTRAINT [FK_MANAGES_Employee] FOREIGN KEY(Employeename)
REFERENCES Employee (Employeename)


GO
INSERT INTO Employee(Employeename, street, city) 
VALUES('NGUYEN VAN A', 'DIEN BIEN PHU', 'HO CHI MINH')
INSERT INTO Employee(Employeename, street, city) 
VALUES('TRUONG VAN B', 'LE THI RIENG', 'HO CHI MINH')
INSERT INTO Employee(Employeename, street, city) 
VALUES('LY VAN C', 'PHAM VAN DONG', 'HO CHI MINH')
INSERT INTO Employee(Employeename, street, city) 
VALUES('MAI VAN D', 'NAM KY KHOI NGHIA', 'HO CHI MINH')
INSERT INTO Employee(Employeename, street, city) 
VALUES('PHAN VAN E', 'HAI BA TRUNG', 'HO CHI MINH') 



INSERT INTO COMPANY(Companyname, city)
VALUES('First Bank Corporation', 'HO CHI MINH') 
INSERT INTO COMPANY(Companyname, city)
VALUES('VIETTEL', 'HANOI')
INSERT INTO COMPANY(Companyname, city)
VALUES('GRAB', 'HO CHI MINH')
INSERT INTO COMPANY(Companyname, city)
VALUES('Small Bank Corporation', 'HANOI')
INSERT INTO COMPANY(Companyname, city)
VALUES('THEGIOIDIDONG', 'HO CHI MINH') 

INSERT INTO WORKS(Employeename, Companyname,Salary)
VALUES('NGUYEN VAN A', 'VIETTEL', 1000)
INSERT INTO WORKS(Employeename, Companyname,Salary)
VALUES('TRUONG VAN B', 'First Bank Corporation', 2000)
INSERT INTO WORKS(Employeename, Companyname,Salary)
VALUES('LY VAN C', 'GRAB', 10000)
INSERT INTO WORKS(Employeename, Companyname,Salary)
VALUES('MAI VAN D', 'Small Bank Corporation', 15000)
INSERT INTO WORKS(Employeename, Companyname,Salary)
VALUES('PHAN VAN E', 'THEGIOIDIDONG', 5000) 



INSERT INTO MANAGES(Employeename, Managername)
VALUES('NGUYEN VAN A', 'TRUONG VAN B') 
INSERT INTO MANAGES(Employeename, Managername)
VALUES('TRUONG VAN B', 'LY VAN C')
INSERT INTO MANAGES(Employeename, Managername)
VALUES('LY VAN C', 'MAI VAN D')
INSERT INTO MANAGES(Employeename, Managername)
VALUES('MAI VAN D', 'PHAN VAN E')
INSERT INTO MANAGES(Employeename, Managername)
VALUES('PHAN VAN E', 'NGUYEN VAN A')

SELECT * FROM WORKS
/*NAME OF EMPLOYEES WHO WORK FOR THE 1ST BANK*/
SELECT Employeename
FROM WORKS
WHERE Companyname = 'First Bank Corporation'  
/*the names and cities of residence of all employees who work for First Bank Corporation*/
SELECT WORKS.Employeename, Employee.city
FROM WORKS, Employee
WHERE Companyname = 'First Bank Corporation' AND WORKS.Employeename = Employee.Employeename


/*the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $10,000*/

SELECT WORKS.Employeename, Employee.street, Employee.city
FROM WORKS, Employee
WHERE WORKS.Salary >= 10000 AND Employee.Employeename = WORKS.Employeename 

/*all employees in the database who live in the same cities as the companies for which they work*/
SELECT Employee.Employeename
FROM COMPANY, Employee, WORKS
WHERE Employee.city = COMPANY.city AND WORKS.Employeename = Employee.Employeename AND COMPANY.Companyname = WORKS.Companyname 

/*all employees in the database who live in the same cities and on the same streets as do their managers*/
SELECT Employee.Employeename
FROM Employee, MANAGES
WHERE Employee.city = Employee.city AND Employee.street = Employee.street AND MANAGES.Managername = Employee.Employeename 

/*all employees in the database who do not work for First Bank Corporation*/
SELECT Employeename
FROM  WORKS
WHERE Companyname != 'GRAB' 

/*all employees in the database who earn more than each employee of Small Bank Corporation*/
SELECT Employee.Employeename
FROM WORKS, Employee
WHERE WORKS.Salary > WORKS.Salary AND WORKS.Companyname = WORKS.Companyname AND Employee.Employeename = WORKS.Employeename 
