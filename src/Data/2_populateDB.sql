USE [Shop];
GO

DECLARE @ResetIdentity INT;

SET IDENTITY_INSERT [dbo].[Franchise] OFF;
SET IDENTITY_INSERT [dbo].[Product] OFF;

-----------------------------------------------------------------------Data dbo.Franchise------------------------------------------------------------------
DECLARE @Franchise_Temp TABLE
(
	[FranchiseId] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL
);

INSERT @Franchise_Temp ([FranchiseId], [Description]) VALUES (1, 'Visa');
INSERT @Franchise_Temp ([FranchiseId], [Description]) VALUES (2, 'MasterCard');

SET IDENTITY_INSERT [dbo].[Franchise] ON;

MERGE INTO [dbo].[Franchise] AS [Des]
USING
	(
		SELECT 
			[FranchiseId],
			[Description]
		FROM @Franchise_Temp
	)AS [Ori]
ON [Ori].[FranchiseId] = [Des].[FranchiseId]
WHEN NOT MATCHED BY TARGET 
THEN INSERT
	(
		[FranchiseId],
		[Description]
	)
	VALUES
	(
		[Ori].[FranchiseId],
		[Ori].[Description]
	)
WHEN MATCHED AND TRIM([Des].[Description]) <> TRIM([Ori].[Description])
	THEN UPDATE SET 
        [Des].[Description] = TRIM([Ori].[Description]);

SET IDENTITY_INSERT [dbo].[Franchise] OFF;

SELECT @ResetIdentity = MAX([FranchiseId]) FROM [dbo].[Franchise] WITH(NOLOCK);
DBCC CHECKIDENT ('[dbo].[Franchise]', RESEED, @ResetIdentity);

-----------------------------------------------------------------------Data dbo.Product------------------------------------------------------------------
DECLARE @Product_Temp TABLE
(
	[ProductId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Image] [varchar](1024) NULL,
	[UnitPrice] [int] NOT NULL,
	[Description] [varchar](1024) NULL,
	[Amount] [int] NOT NULL
);

INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (1, 'Licencia Office 365 x 2 año', NULL, 200000, NULL, 0);
INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (2, 'Monitor AOC 24 pulgadas', NULL, 135250, NULL, 24);
INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (3, 'Mouse inalámbrico logitech', NULL, 27500, NULL, 57);
INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (4, 'Teclado mecanico redragon', NULL, 149900, NULL, 12);
INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (5, 'Licencia Windows Server 2016 Standar', NULL, 290000, NULL, 80);
INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (6, 'Disco duro externo 1 TB', NULL, 130000, NULL, 28);

SET IDENTITY_INSERT [dbo].[Product] ON;

MERGE INTO [dbo].[Product] AS [Des]
USING
	(
		SELECT 
			[ProductId],
			[Name],
			[Image], 
			[UnitPrice], 
			[Description], 
			[Amount]
		FROM @Product_Temp
	)AS [Ori]
ON [Ori].[ProductId] = [Des].[ProductId]
WHEN NOT MATCHED BY TARGET 
THEN INSERT
	(
		[ProductId],
		[Name],
		[Image], 
		[UnitPrice], 
		[Description], 
		[Amount]
	)
	VALUES
	(
		[Ori].[ProductId],
		[Ori].[Name],
		[Ori].[Image], 
		[Ori].[UnitPrice], 
		[Ori].[Description], 
		[Ori].[Amount]
	)
WHEN MATCHED AND
	(
		TRIM([Des].[Name]) <> TRIM([Ori].[Name])
		OR TRIM([Des].[Image]) <> TRIM([Ori].[Image])
		OR [Des].[UnitPrice] <> [Ori].[UnitPrice]
		OR TRIM([Des].[Description]) <> TRIM([Ori].[Description])
		OR [Des].[Amount] <> [Ori].[Amount]
	)
	THEN UPDATE SET 
        [Des].[Name] = TRIM([Ori].[Name]),
        [Des].[Image] = TRIM([Ori].[Image]),
        [Des].[UnitPrice] = [Ori].[UnitPrice],
        [Des].[Description] = TRIM([Ori].[Description]),
        [Des].[Amount] = [Ori].[Amount];

SET IDENTITY_INSERT [dbo].[Product] OFF;

SELECT @ResetIdentity = MAX([ProductId]) FROM [dbo].[Product] WITH(NOLOCK);
DBCC CHECKIDENT ('[dbo].[Product]', RESEED, @ResetIdentity);