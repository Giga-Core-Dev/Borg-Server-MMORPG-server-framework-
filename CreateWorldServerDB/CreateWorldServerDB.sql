
/*-------------------------------
	Create World Server Database
  -------------------------------

	TODO BEFORE RUNNING THE SCRIPT: 
	
		* replace the file names and file paths as needed
        * replace the Database name [World0] with a real world name 
*/

USE [master]
GO
PRINT 'Creasting World Server DB ...'

/****** Object:  Database [World0]    Script Date: 11/30/2009 17:35:24 ******/
CREATE DATABASE [World0] ON  PRIMARY 
( NAME = N'World0', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\World0.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'World0_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\DATA\World0_1.ldf' , SIZE = 4096KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [World0] SET COMPATIBILITY_LEVEL = 90
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [World0].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO

ALTER DATABASE [World0] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [World0] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [World0] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [World0] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [World0] SET ARITHABORT OFF 
GO

ALTER DATABASE [World0] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [World0] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [World0] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [World0] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [World0] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [World0] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [World0] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [World0] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [World0] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [World0] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [World0] SET  DISABLE_BROKER 
GO

ALTER DATABASE [World0] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [World0] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [World0] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [World0] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [World0] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [World0] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [World0] SET  READ_WRITE 
GO

ALTER DATABASE [World0] SET RECOVERY FULL 
GO

ALTER DATABASE [World0] SET  MULTI_USER 
GO

ALTER DATABASE [World0] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [World0] SET DB_CHAINING OFF 
GO


/*-------------------------------
	Create World Server Tables
---------------------------------*/
PRINT 'Creasting DB tables...'

USE [World0]
GO
/****** Object:  Table [dbo].[attributes]    Script Date: 11/30/2009 17:33:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[attributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[attributes](
	[attributeId] [int] IDENTITY(1,1) NOT NULL,
	[classId] [int] NOT NULL,
	[name] [nvarchar](50) NULL,
	[description] [nvarchar](500) NULL,
	[generic] [bit] NOT NULL,
 CONSTRAINT [PK_class_attributes] PRIMARY KEY CLUSTERED 
(
	[attributeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[settings]    Script Date: 11/30/2009 17:33:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[settings]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[settings](
	[secret_key] [nvarchar](50) NOT NULL,
	[users_allowed] [int] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[classes]    Script Date: 11/30/2009 17:33:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[classes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[classes](
	[classId] [int] NOT NULL,
	[name] [nvarchar](25) NOT NULL,
	[description] [nvarchar](1024) NULL,
 CONSTRAINT [PK_classes] PRIMARY KEY CLUSTERED 
(
	[classId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[characters]    Script Date: 11/30/2009 17:33:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[characters]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[characters](
	[accountId] [int] NOT NULL,
	[characterId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[last_played] [smalldatetime] NULL,
	[created] [datetime] NOT NULL,
	[classId] [int] NOT NULL,
 CONSTRAINT [PK_characters] PRIMARY KEY CLUSTERED 
(
	[characterId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[characters]') AND name = N'IX_characters')
CREATE NONCLUSTERED INDEX [IX_characters] ON [dbo].[characters] 
(
	[accountId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[character_attributes]    Script Date: 11/30/2009 17:33:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[character_attributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[character_attributes](
	[characterId] [int] NOT NULL,
	[attributeId] [int] NOT NULL,
	[value] [int] NOT NULL
) ON [PRIMARY]
END
GO



/****** Object:  Table [dbo].[entity_properties]    Script Date: 12/16/2009 17:03:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[entity_properties]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[entity_properties](
	[entityId] [int] NOT NULL,
	[name] [nvarchar](15) NOT NULL,
	[value] [nvarchar](500) NULL
) ON [PRIMARY]
END
GO
CREATE NONCLUSTERED INDEX [IX_entity_properties_Id] ON [dbo].[entity_properties] 
(
	[entityId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_entity_properties_name] ON [dbo].[entity_properties] 
(
	[name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



PRINT 'Creating constrains and foreign keys...'
/****** Object:  Default [DF_class_attributes_generic]    Script Date: 11/30/2009 17:33:36 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_class_attributes_generic]') AND parent_object_id = OBJECT_ID(N'[dbo].[attributes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_class_attributes_generic]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[attributes] ADD  CONSTRAINT [DF_class_attributes_generic]  DEFAULT ((0)) FOR [generic]
END


End
GO
/****** Object:  Default [DF_character_attributes_value]    Script Date: 11/30/2009 17:33:36 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_character_attributes_value]') AND parent_object_id = OBJECT_ID(N'[dbo].[character_attributes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_character_attributes_value]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[character_attributes] ADD  CONSTRAINT [DF_character_attributes_value]  DEFAULT ((0)) FOR [value]
END


End
GO
/****** Object:  Default [DF_characters_created]    Script Date: 11/30/2009 17:33:36 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_characters_created]') AND parent_object_id = OBJECT_ID(N'[dbo].[characters]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_characters_created]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[characters] ADD  CONSTRAINT [DF_characters_created]  DEFAULT (getdate()) FOR [created]
END

End
GO
/****** Object:  Default [DF_characters_classId]    Script Date: 11/30/2009 17:33:36 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_characters_classId]') AND parent_object_id = OBJECT_ID(N'[dbo].[characters]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_characters_classId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[characters] ADD  CONSTRAINT [DF_characters_classId]  DEFAULT ((1)) FOR [classId]
END
End
GO
/****** Object:  ForeignKey [FK_character_attributes_attributes]    Script Date: 11/30/2009 17:33:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_character_attributes_attributes]') AND parent_object_id = OBJECT_ID(N'[dbo].[character_attributes]'))
ALTER TABLE [dbo].[character_attributes]  WITH CHECK ADD  CONSTRAINT [FK_character_attributes_attributes] FOREIGN KEY([attributeId])
REFERENCES [dbo].[attributes] ([attributeId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_character_attributes_attributes]') AND parent_object_id = OBJECT_ID(N'[dbo].[character_attributes]'))
ALTER TABLE [dbo].[character_attributes] CHECK CONSTRAINT [FK_character_attributes_attributes]
GO
/****** Object:  ForeignKey [FK_character_attributes_characters]    Script Date: 11/30/2009 17:33:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_character_attributes_characters]') AND parent_object_id = OBJECT_ID(N'[dbo].[character_attributes]'))
ALTER TABLE [dbo].[character_attributes]  WITH NOCHECK ADD  CONSTRAINT [FK_character_attributes_characters] FOREIGN KEY([characterId])
REFERENCES [dbo].[characters] ([characterId])
ON UPDATE CASCADE
ON DELETE CASCADE
NOT FOR REPLICATION
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_character_attributes_characters]') AND parent_object_id = OBJECT_ID(N'[dbo].[character_attributes]'))
ALTER TABLE [dbo].[character_attributes] CHECK CONSTRAINT [FK_character_attributes_characters]
GO
/****** Object:  ForeignKey [FK_characters_classes]    Script Date: 11/30/2009 17:33:36 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_characters_classes]') AND parent_object_id = OBJECT_ID(N'[dbo].[characters]'))
ALTER TABLE [dbo].[characters]  WITH CHECK ADD  CONSTRAINT [FK_characters_classes] FOREIGN KEY([classId])
REFERENCES [dbo].[classes] ([classId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_characters_classes]') AND parent_object_id = OBJECT_ID(N'[dbo].[characters]'))
ALTER TABLE [dbo].[characters] CHECK CONSTRAINT [FK_characters_classes]
GO



PRINT 'Creating stored procedures...'
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================================================
-- Author:		Enriko Riba
-- Create date: 
-- Description:	Creates a new character record with a set of generic attributes 
--				and the attributes which belong to the characters class
-- ===========================================================================
CREATE PROCEDURE [dbo].[sp_add_character] 	@accountId int, @classId int, @name nvarchar(50)
AS
BEGIN	
	SET NOCOUNT ON;
	
	--	insert characetr record
	DECLARE @characterId int
	INSERT INTO characters VALUES( @accountId, @name, NULL, GETDATE(), @classId)
    SET @characterId = SCOPE_IDENTITY()
    
    --	add attribute records
    DECLARE @att int
    DECLARE c_att CURSOR READ_ONLY
    FOR
	SELECT attributeId FROM attributes 
	WHERE classId = @classId OR generic = 1	
	OPEN c_att

	FETCH NEXT FROM c_att
	INTO @att

	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO character_attributes VALUES (@characterId, @att, 0)
		FETCH NEXT FROM c_att
		INTO @att
	END

	CLOSE c_att
	DEALLOCATE c_att
	
	return @characterId
END
GO

-- ===========================================================================
-- Author:		Enriko Riba
-- Create date: 
-- Description:	Creates a new character record with a set of generic attributes 
--				and the attributes which belong to the characters class
-- ===========================================================================
CREATE PROCEDURE [dbo].[sp_update_attribute] 	@characterId int, @name nvarchar(50), @value int 
AS
BEGIN	
	SET NOCOUNT ON;		
	UPDATE character_attributes 
	SET value = @value FROM 
	character_attributes INNER JOIN attributes ON attributes.attributeId = character_attributes.attributeId  
    WHERE attributes.name = @name AND character_attributes.characterId = @characterId    
END
GO

-- ===========================================================================
-- Author:		Enriko Riba
-- Create date: 
-- Description:	Creates a new character record with a set of generic attributes 
--				and the attributes which belong to the characters class
-- ===========================================================================
CREATE PROCEDURE [dbo].[sp_get_attributes] @characterId int	
AS
BEGIN	
	SET NOCOUNT ON;   
	SELECT character_attributes.value, attributes.generic, attributes.name, attributes.description
	FROM attributes INNER JOIN character_attributes 
			ON character_attributes.attributeId = attributes.attributeId
			WHERE character_attributes.characterId = @characterId
END
GO


/*-------------------------------
	INSERT default values
---------------------------------*/
SET NOCOUNT ON
PRINT 'Inserting values into [settings]'
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [settings] ([secret_key],[users_allowed])VALUES('kicks-ass SECRET',128)
PRINT 'Done'

PRINT 'Inserting values into [classes]'
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [classes] ([classId],[name],[description])VALUES(0,'generic','__***placeholder for generic attribute links ***__')
INSERT INTO [classes] ([classId],[name],[description])VALUES(1,'Mage','Magicians are masters of white or dark magic, intellect and spell casting is their greates weapon.')
INSERT INTO [classes] ([classId],[name],[description])VALUES(2,'Mercenary','Great warriors, strength and vitality is their greatest weapon.')
PRINT 'Done'
 
 
SET IDENTITY_INSERT [dbo].[attributes] ON
GO
PRINT 'Inserting values into [attributes]'
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [attributes] ([attributeId],[classId],[name],[description],[generic])VALUES(1,0,'health',NULL,1)
INSERT INTO [attributes] ([attributeId],[classId],[name],[description],[generic])VALUES(2,0,'strength',NULL,1)
INSERT INTO [attributes] ([attributeId],[classId],[name],[description],[generic])VALUES(3,0,'dexterity',NULL,1)
INSERT INTO [attributes] ([attributeId],[classId],[name],[description],[generic])VALUES(4,0,'mana',NULL,1)
INSERT INTO [attributes] ([attributeId],[classId],[name],[description],[generic])VALUES(5,0,'intelligence',NULL,1)
INSERT INTO [attributes] ([attributeId],[classId],[name],[description],[generic])VALUES(6,0,'experience',NULL,1)
INSERT INTO [attributes] ([attributeId],[classId],[name],[description],[generic])VALUES(7,1,'White magic',NULL,0)
INSERT INTO [attributes] ([attributeId],[classId],[name],[description],[generic])VALUES(8,1,'Dark magic',NULL,0)
INSERT INTO [attributes] ([attributeId],[classId],[name],[description],[generic])VALUES(9,2,'Melee',NULL,0)
INSERT INTO [attributes] ([attributeId],[classId],[name],[description],[generic])VALUES(10,2,'Block',NULL,0)
PRINT 'Done'
SET IDENTITY_INSERT [dbo].[attributes] OFF
GO
 
 
SET IDENTITY_INSERT [dbo].[characters] ON
GO
PRINT 'Inserting values into [characters]'
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [characters] ([accountId],[characterId],[name],[last_played],[created],[classId])VALUES(1,1,'Developer_test_mercenary',NULL,'Nov 27 2009  8:21:49:857AM',2)
INSERT INTO [characters] ([accountId],[characterId],[name],[last_played],[created],[classId])VALUES(1,2,'Developer_test_mage',NULL,'Nov 27 2009  8:21:49:857AM',1)
PRINT 'Done'
SET IDENTITY_INSERT [dbo].[characters] OFF
GO


PRINT 'Inserting values into [character_attributes]'
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(1,1,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(1,2,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(1,3,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(1,4,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(1,5,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(1,6,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(1,9,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(1,10,0)

INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(2,1,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(2,2,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(2,3,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(2,4,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(2,5,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(2,6,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(2,7,0)
INSERT INTO [character_attributes] ([characterId],[attributeId],[value])VALUES(2,8,0)
PRINT 'Done'



