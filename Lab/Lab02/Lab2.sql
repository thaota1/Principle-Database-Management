
/*Author Ta Thi Phuong Thao - ITDSIU20082*/

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
