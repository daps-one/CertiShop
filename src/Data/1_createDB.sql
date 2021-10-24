USE [master];
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Shop')
BEGIN
	CREATE DATABASE [Shop]
END
GO

USE [Shop];
GO

-------------------------------------------------------Clear foreign keys------------------------------------------------
DECLARE @Counter INT = 1, @sql VARCHAR(MAX)
DECLARE @Foreign table
(
	Counter INT IDENTITY(1,1),
	Text1 VARCHAR(200),
	Text2 VARCHAR(200)
)

INSERT INTO @Foreign (Text1,Text2)
SELECT 
	FK.name, 
	PFK.name AS parentTable
FROM sys.foreign_keys FK
INNER JOIN sys.objects PFK ON PFK.object_id = FK.parent_object_id
INNER JOIN sys.objects RFK ON RFK.object_id = FK.referenced_object_id
WHERE FK.schema_id in (SELECT schema_id FROM sys.schemas WHERE name in (N'dbo'))

WHILE ((SELECT max(Counter) FROM @Foreign) >= @Counter)
BEGIN
	SET @sql = 'ALTER TABLE [dbo].[' + (SELECT MAX(Text2) FROM @Foreign WHERE Counter = @Counter) +
			   '] DROP CONSTRAINT [' + (SELECT MAX(Text1) FROM @Foreign WHERE Counter = @Counter) + ']'
	
	EXEC(@sql)
	SET @Counter = @Counter + 1;
END
GO

-----------------------------------------------------------------------Table dbo.User------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type in (N'U'))
BEGIN
	IF NOT EXISTS (SELECT * FROM [dbo].[User])
	BEGIN
		DROP TABLE [dbo].[User];
	END
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[User](
		[UserId] [int] IDENTITY(1,1) NOT NULL,
		[IdentificationNumber] [varchar](15) NOT NULL,
		[Names] [varchar](255) NOT NULL,
		[Surnames] [varchar](255) NOT NULL,
		[Email] [varchar](255) NOT NULL,
		[Status] [bit] NOT NULL,
	CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED
	(
		[UserId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	CONSTRAINT [UQ_IdentificationNumber] UNIQUE NONCLUSTERED
	(
		[IdentificationNumber] ASC
	)
	) ON [PRIMARY];
END
GO

-----------------------------------------------------------------------Table dbo.Franchise------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Franchise]') AND type in (N'U'))
BEGIN
	IF NOT EXISTS (SELECT * FROM [dbo].[Franchise])
	BEGIN
		DROP TABLE [dbo].[Franchise];
	END
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Franchise]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[Franchise](
		[FranchiseId] [int] IDENTITY(1,1) NOT NULL,
		[Description] [varchar](50) NOT NULL,
	CONSTRAINT [PK_Franchise] PRIMARY KEY CLUSTERED
	(
		[FranchiseId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY];
END
GO

-----------------------------------------------------------------------Table dbo.Product------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U'))
BEGIN
	IF NOT EXISTS (SELECT * FROM [dbo].[Product])
	BEGIN
		DROP TABLE [dbo].[Product];
	END
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[Product](
		[ProductId] [int] IDENTITY(1,1) NOT NULL,
		[Name] [varchar](50) NOT NULL,
		[Image] [varchar](1024) NULL,
		[UnitPrice] [int] NOT NULL,
		[Description] [varchar](1024) NULL,
		[Amount] [int] NOT NULL,
	CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED
	(
		[ProductId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY];
END
GO

-----------------------------------------------------------------------Table dbo.Transactions------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Transactions]') AND type in (N'U'))
BEGIN
	IF NOT EXISTS (SELECT * FROM [dbo].[Transactions])
	BEGIN
		DROP TABLE [dbo].[Transactions];
	END
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Transactions]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[Transactions](
		[TransactionId] [int] IDENTITY(1,1) NOT NULL,
		[UserId] [int] NOT NULL,
		[FranchiseId] [int] NOT NULL,
		[CreditCardNumber] [varchar](16) NOT NULL,
		[ExpirationDate] [date] NOT NULL,
		[Fees] [int] NOT NULL,
		[TotalPrice] [int] NOT NULL,
		[Observations] [varchar](1024) NULL,
		[TransactionDate] [date] NOT NULL,
	CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED
	(
		[TransactionId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY];
END
GO

-----------------------------------------------------------------------Table dbo.TransactionDetail------------------------------------------------------------------
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TransactionDetail]') AND type in (N'U'))
BEGIN
	IF NOT EXISTS (SELECT * FROM [dbo].[TransactionDetail])
	BEGIN
		DROP TABLE [dbo].[TransactionDetail];
	END
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TransactionDetail]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TransactionDetail](
		[TransactionDetailId] [int] IDENTITY(1,1) NOT NULL,
		[TransactionId] [int] NOT NULL,
		[ProductId] [int] NOT NULL,
		[Amount] [int] NOT NULL,
		[UnitPrice] [int] NOT NULL,
		[TotalPrice] [int] NOT NULL,
	CONSTRAINT [PK_TransactionDetail] PRIMARY KEY CLUSTERED
	(
		[TransactionDetailId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY];
END
GO

-----------------------------------------------------------------------Foreing Keys------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Transaction_UserId_User_UserId]') AND parent_object_id = OBJECT_ID('[dbo].[Transactions]'))
BEGIN
	ALTER TABLE [dbo].[Transactions] WITH CHECK ADD CONSTRAINT [FK_Transaction_UserId_User_UserId] FOREIGN KEY ([UserId])
	REFERENCES [dbo].[User] ([UserId])
	ON UPDATE CASCADE
	ON DELETE CASCADE;
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Transaction_FranchiseId_Franchise_FranchiseId]') AND parent_object_id = OBJECT_ID('[dbo].[Transactions]'))
BEGIN
	ALTER TABLE [dbo].[Transactions] WITH CHECK ADD CONSTRAINT [FK_Transaction_FranchiseId_Franchise_FranchiseId] FOREIGN KEY ([FranchiseId])
	REFERENCES [dbo].[Franchise] ([FranchiseId])
	ON UPDATE CASCADE
	ON DELETE CASCADE;
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TransactionDetail_TransactionId_Transaction_TransactionId]') AND parent_object_id = OBJECT_ID('[dbo].[TransactionDetail]'))
BEGIN
	ALTER TABLE [dbo].[TransactionDetail] WITH CHECK ADD CONSTRAINT [FK_TransactionDetail_TransactionId_Transaction_TransactionId] FOREIGN KEY ([TransactionId])
	REFERENCES [dbo].[Transactions] ([TransactionId])
	ON UPDATE CASCADE
	ON DELETE CASCADE;
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TransactionDetail_ProductId_Product_ProductId]') AND parent_object_id = OBJECT_ID('[dbo].[TransactionDetail]'))
BEGIN
	ALTER TABLE [dbo].[TransactionDetail] WITH CHECK ADD CONSTRAINT [FK_TransactionDetail_ProductId_Product_ProductId] FOREIGN KEY ([ProductId])
	REFERENCES [dbo].[Product] ([ProductId])
	ON UPDATE CASCADE
	ON DELETE CASCADE;
END
GO