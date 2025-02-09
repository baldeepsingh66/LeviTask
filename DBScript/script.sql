USE [PropertyManagementDb]
GO
/****** Object:  UserDefinedFunction [dbo].[GenPass]    Script Date: 04-08-2024 13:03:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ============================================================
-- Author:      Eli Leiba
-- Create date: 01-2018
-- Description: a view and a scalar UDF to generate a random
-- 8 characters password
-- ============================================================
CREATE FUNCTION [dbo].[GenPass]()
RETURNS VARCHAR(8)
AS
BEGIN
   -- Declare the variables here
   DECLARE @Result VARCHAR(8)
   DECLARE @BinaryData VARBINARY(8)
   DECLARE @CharacterData VARCHAR(8)
 
   SELECT @BinaryData = randval
   FROM vRandom
 
   Set @CharacterData=cast ('' as xml).value ('xs:base64Binary(sql:variable("@BinaryData"))',
                   'varchar (max)')
   
   SET @Result = @CharacterData
   
   -- Return the result of the function
   RETURN @Result
END
GO
/****** Object:  View [dbo].[vRandom]    Script Date: 04-08-2024 13:03:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- create view for function call
CREATE VIEW [dbo].[vRandom]
AS
SELECT randval = CRYPT_GEN_RANDOM (8)
GO
/****** Object:  Table [dbo].[PropertyDetail]    Script Date: 04-08-2024 13:03:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PropertyManagerId] [int] NOT NULL,
	[PropertyName] [nvarchar](50) NOT NULL,
	[PropertyArea] [nvarchar](50) NOT NULL,
	[PropertyRentalPrice] [int] NOT NULL,
	[PropertyCurrentValue] [int] NOT NULL,
	[PropertyOccupied] [bit] NOT NULL,
 CONSTRAINT [PK_PropertyDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyManager]    Script Date: 04-08-2024 13:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyManager](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PropertyManager] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PropertyDetail]  WITH CHECK ADD  CONSTRAINT [FK_PropertyDetail_PropertyDetail] FOREIGN KEY([PropertyManagerId])
REFERENCES [dbo].[PropertyManager] ([Id])
GO
ALTER TABLE [dbo].[PropertyDetail] CHECK CONSTRAINT [FK_PropertyDetail_PropertyDetail]
GO
/****** Object:  StoredProcedure [dbo].[CreatePropertyManager]    Script Date: 04-08-2024 13:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreatePropertyManager] 
	@name nvarchar(50)
AS
BEGIN
	DECLARE @newPass VARCHAR(8);
    SELECT @newPass = dbo.GenPass();
    Insert into PropertyManager (Name,Password) values (@name,@newPass)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetPropertyDetails]    Script Date: 04-08-2024 13:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetPropertyDetails]
	@type nvarchar(50)
AS
BEGIN
	IF @type='all'
	BEGIN
	   select pd.Id,PropertyManagerId,pm.Name,PropertyName,PropertyArea,PropertyRentalPrice,PropertyCurrentValue, PropertyOccupied from PropertyDetail as pd 
	   join PropertyManager as pm on pd.PropertyManagerId= pm.Id  
	END 
	ELSE IF @type='lowest'
	BEGIN
	   select pd.Id,PropertyManagerId,pm.Name,PropertyName,PropertyArea,PropertyRentalPrice,PropertyCurrentValue, PropertyOccupied from PropertyDetail as pd 
	   join PropertyManager as pm on pd.PropertyManagerId= pm.Id order by PropertyCurrentValue desc
	END
	ELSE IF @type='occupied'
	BEGIN
	   select pd.Id,PropertyManagerId,pm.Name,PropertyName,PropertyArea,PropertyRentalPrice,PropertyCurrentValue, PropertyOccupied from PropertyDetail as pd 
	   join PropertyManager as pm on pd.PropertyManagerId= pm.Id where PropertyOccupied = 1
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePropertyCurrentvalue]    Script Date: 04-08-2024 13:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdatePropertyCurrentvalue]

@id int,
@currentvalue int

AS
BEGIN
	SET NOCOUNT ON;
    Update PropertyDetail set PropertyCurrentValue= @currentvalue where Id=@id
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePropertyManager]    Script Date: 04-08-2024 13:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdatePropertyManager]

@id int,
@propertymanagerid bit
AS
BEGIN
	SET NOCOUNT ON;
    Update PropertyDetail set PropertyManagerId= @propertymanagerid where Id=@id
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePropertyOccupied]    Script Date: 04-08-2024 13:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdatePropertyOccupied]

@id int,
@isOccupied bit
AS
BEGIN
	SET NOCOUNT ON;
    Update PropertyDetail set PropertyOccupied= @isOccupied where Id=@id
END
GO
