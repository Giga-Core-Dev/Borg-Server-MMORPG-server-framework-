USE [Borg]
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_accounts_flags]') AND parent_object_id = OBJECT_ID(N'[dbo].[accounts]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_accounts_flags]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[accounts] DROP CONSTRAINT [DF_accounts_flags]
END


End
GO
IF  EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_worlds_secret_key]') AND parent_object_id = OBJECT_ID(N'[dbo].[worlds]'))
Begin
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_worlds_secret_key]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[worlds] DROP CONSTRAINT [DF_worlds_secret_key]
END


End
GO
/****** Object:  StoredProcedure [dbo].[login_check]    Script Date: 12/12/2009 08:42:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[login_check]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[login_check]
GO
/****** Object:  Table [dbo].[worlds]    Script Date: 12/12/2009 08:42:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[worlds]') AND type in (N'U'))
DROP TABLE [dbo].[worlds]
GO
/****** Object:  Table [dbo].[accounts]    Script Date: 12/12/2009 08:42:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[accounts]') AND type in (N'U'))
DROP TABLE [dbo].[accounts]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 12/12/2009 08:42:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Log]') AND type in (N'U'))
DROP TABLE [dbo].[Log]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 12/12/2009 08:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Log]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL,
	[thread] [varchar](255) NOT NULL,
	[level] [varchar](50) NOT NULL,
	[logger] [varchar](255) NOT NULL,
	[message] [varchar](4000) NOT NULL,
	[exception] [varchar](2000) NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[accounts]    Script Date: 12/12/2009 08:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[accounts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[accounts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](20) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[pwd] [nvarchar](500) NOT NULL,
	[status] [int] NOT NULL,
	[last_login] [smalldatetime] NULL,
	[locked_untill] [smalldatetime] NULL,
	[description] [nvarchar](250) NULL,
	[flags] [int] NOT NULL,
 CONSTRAINT [PK_accounts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Default [DF_accounts_flags]    Script Date: 12/17/2009 08:55:05 ******/
ALTER TABLE [dbo].[accounts] ADD  CONSTRAINT [DF_accounts_flags]  DEFAULT ((0)) FOR [flags]

GO
SET IDENTITY_INSERT [dbo].[accounts] ON
INSERT [dbo].[accounts] ([id], [name], [email], [pwd], [status], [last_login], [locked_untill], [description], [flags]) VALUES (1, N'sa', N'eriba@titanium.hr',   N'52F3F38442068C4D6469EC2509DCDE87ED2A412F1DF8835F5E2ECED868217F57D76A689BD4C72B646C5D03292C34626E0D4DF4B7FA1E1ECC0732F15249E3324B19015ABE0B53B57C0AC0089412B3B90BFF3B84F804A09A05CEEBAC39192B646C', 1, NULL, NULL, NULL, 0)
INSERT [dbo].[accounts] ([id], [name], [email], [pwd], [status], [last_login], [locked_untill], [description], [flags]) VALUES (2, N'borg_dev', N'borg@borg.com', N'52F3F38442068C4D6469EC2509DCDE87ED2A412F1DF8835F5E2ECED868217F57D76A689BD4C72B646C5D03292C34626E0D4DF4B7FA1E1ECC0732F15249E3324B19015ABE0B53B57C0AC0089412B3B90BFF3B84F804A09A05CEEBAC39192B646C', 1, NULL, NULL, N'Test account for borg developers. Password is ''nimda''', 0)
SET IDENTITY_INSERT [dbo].[accounts] OFF
/****** Object:  Table [dbo].[worlds]    Script Date: 12/12/2009 08:42:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[worlds]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[worlds](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[hostip] [nvarchar](50) NOT NULL,
	[port] [int] NOT NULL,
	[online] [bit] NOT NULL,
	[users_online] [smallint] NOT NULL,
	[users_allowed] [smallint] NOT NULL,
	[secret_key] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[worlds] ON
INSERT [dbo].[worlds] ([id], [name], [hostip], [port], [online], [users_online], [users_allowed], [secret_key]) VALUES (2, N'World0', N'riki.kicks-ass.net', 20002, 1, 0, 32, N'kicks-ass SECRET')
SET IDENTITY_INSERT [dbo].[worlds] OFF
/****** Object:  StoredProcedure [dbo].[login_check]    Script Date: 12/12/2009 08:42:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[login_check]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[login_check]	@name nvarchar(20), @status INT OUT
AS
BEGIN	
	SET NOCOUNT ON;    
	declare @id INT;
    declare @lockedDate datetime;

	SELECT @id = id, @status = [status], @lockedDate = locked_untill FROM accounts WHERE [name] = @name
	SET @id = isnull(@id, -1)

	IF @id >0 BEGIN	-- the account exists

		-- if kicked or locked reset the status after expiry
		IF ((@status = 3) OR (@status = 4)) AND (NOT @lockedDate IS NULL) BEGIN  
			IF @lockedDate <= GetDate() BEGIN
				SET @status = 1
				UPDATE  accounts SET [status] = @status, locked_untill = NULL WHERE [name] = @name
			END
		END

		-- status is OK update login date
		IF @status = 1 BEGIN
			UPDATE accounts SET last_login = GetDate() WHERE [name] = @name
		END
	END

	return @id
END'

END
GO
/****** Object:  Default [DF_accounts_flags]    Script Date: 12/12/2009 08:42:25 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_accounts_flags]') AND parent_object_id = OBJECT_ID(N'[dbo].[accounts]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_accounts_flags]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[accounts] ADD  CONSTRAINT [DF_accounts_flags]  DEFAULT ((0)) FOR [flags]
END


End
GO
/****** Object:  Default [DF_worlds_secret_key]    Script Date: 12/12/2009 08:42:25 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_worlds_secret_key]') AND parent_object_id = OBJECT_ID(N'[dbo].[worlds]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_worlds_secret_key]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[worlds] ADD  CONSTRAINT [DF_worlds_secret_key]  DEFAULT (N'We are the Borg') FOR [secret_key]
END


End
GO
