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

INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (1, 'Licencia Office 365 x 2 año', N'https://latinkeys.com/colombia/wp-content/uploads/sites/3/2021/06/Office-365-CP.jpg', 200000, NULL, 50);
INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (2, 'Monitor AOC 24 pulgadas', N'https://m.media-amazon.com/images/I/81DqkCBVxuL._AC_SL1500_.jpg', 135250, NULL, 24);
INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (3, 'Mouse inalámbrico logitech', N'https://panamericana.vteximg.com.br/arquivos/ids/359408-600-690/mouse-inalambrico-logitech-triathlon-m720-1-97855121899.jpg?v=637337203958700000', 27500, NULL, 57);
INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (4, 'Teclado mecanico redragon', N'https://images.jumpseller.com/store/tienda-gamer-medellin/9587891/K552-BB-2.png?1618472548', 149900, NULL, 12);
INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (5, 'Licencia Windows Server 2016 Standar', N'https://tienda.zentinels.net/wp-content/uploads/2019/08/windows-server-2016-licencia-escritorio-remoto-rds-50-usuarios-1.jpg', 290000, NULL, 80);
INSERT @Product_Temp ([ProductId], [Name], [Image], [UnitPrice], [Description], [Amount]) VALUES (6, 'Disco duro externo 1 TB', N'https://medios.papeleriamodelo.com/wp-content/uploads/2020/07/disco-duro-toshiba-1tb.jpg', 130000, NULL, 28);

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
ON [Des].[ProductId] = [Ori].[ProductId]
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
		[Des].[Name] <> [Ori].[Name]
		OR [Des].[Image] <> [Ori].[Image]
		OR [Des].[UnitPrice] <> [Ori].[UnitPrice]
		OR [Des].[Description] <> [Ori].[Description]
		OR [Des].[Amount] <> [Ori].[Amount]
	)
	THEN UPDATE SET 
        [Des].[Name] = [Ori].[Name],
        [Des].[Image] = [Ori].[Image],
        [Des].[UnitPrice] = [Ori].[UnitPrice],
        [Des].[Description] = [Ori].[Description],
        [Des].[Amount] = [Ori].[Amount]
WHEN NOT MATCHED BY SOURCE 
THEN DELETE;

SET IDENTITY_INSERT [dbo].[Product] OFF;

SELECT @ResetIdentity = MAX([ProductId]) FROM [dbo].[Product] WITH(NOLOCK);
DBCC CHECKIDENT ('[dbo].[Product]', RESEED, @ResetIdentity);