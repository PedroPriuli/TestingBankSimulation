USE [BankingInstitution]
GO
/****** Object:  User [sa1]    Script Date: 04/01/2024 10:29:41 ******/
CREATE USER [sa1] FOR LOGIN [sa1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [SOW]    Script Date: 04/01/2024 10:29:41 ******/
CREATE USER [SOW] FOR LOGIN [SOW] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [SOW]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [SOW]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [SOW]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [SOW]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [SOW]
GO
ALTER ROLE [db_datareader] ADD MEMBER [SOW]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [SOW]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[idClient] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](250) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[idClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Institution]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Institution](
	[idInstitution] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](250) NOT NULL,
 CONSTRAINT [PK_Institution] PRIMARY KEY CLUSTERED 
(
	[idInstitution] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Institution_account]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Institution_account](
	[idAccount] [int] IDENTITY(1,1) NOT NULL,
	[number] [varchar](10) NULL,
 CONSTRAINT [PK_Institution_account] PRIMARY KEY CLUSTERED 
(
	[idAccount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rel_account_historic]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rel_account_historic](
	[idAccountHistoric] [int] IDENTITY(1,1) NOT NULL,
	[idAccount] [int] NULL,
	[date] [datetime] NULL,
	[log] [varchar](4000) NULL,
 CONSTRAINT [PK_rel_account_historic] PRIMARY KEY CLUSTERED 
(
	[idAccountHistoric] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rel_account_vs_balance]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rel_account_vs_balance](
	[idAccountBalance] [int] IDENTITY(1,1) NOT NULL,
	[idAccount] [int] NULL,
	[value] [decimal](18, 2) NULL,
	[date] [datetime] NULL,
 CONSTRAINT [PK_rel_account_vs_balance] PRIMARY KEY CLUSTERED 
(
	[idAccountBalance] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rel_account_vs_client]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rel_account_vs_client](
	[idClient] [int] NULL,
	[idAccount] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rel_institution_vs_account]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rel_institution_vs_account](
	[idInstitution] [int] NULL,
	[idAccount] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[rel_account_historic]  WITH CHECK ADD  CONSTRAINT [FK_rel_account_historic_vs_account] FOREIGN KEY([idAccount])
REFERENCES [dbo].[Institution_account] ([idAccount])
GO
ALTER TABLE [dbo].[rel_account_historic] CHECK CONSTRAINT [FK_rel_account_historic_vs_account]
GO
ALTER TABLE [dbo].[rel_account_vs_balance]  WITH CHECK ADD  CONSTRAINT [FK_rel_account_vs_balance_rel_account_account] FOREIGN KEY([idAccount])
REFERENCES [dbo].[Institution_account] ([idAccount])
GO
ALTER TABLE [dbo].[rel_account_vs_balance] CHECK CONSTRAINT [FK_rel_account_vs_balance_rel_account_account]
GO
ALTER TABLE [dbo].[rel_account_vs_client]  WITH CHECK ADD  CONSTRAINT [FK_rel_account_vs_client_rel_account_account] FOREIGN KEY([idAccount])
REFERENCES [dbo].[Institution_account] ([idAccount])
GO
ALTER TABLE [dbo].[rel_account_vs_client] CHECK CONSTRAINT [FK_rel_account_vs_client_rel_account_account]
GO
ALTER TABLE [dbo].[rel_account_vs_client]  WITH CHECK ADD  CONSTRAINT [FK_rel_account_vs_client_rel_account_client] FOREIGN KEY([idClient])
REFERENCES [dbo].[Client] ([idClient])
GO
ALTER TABLE [dbo].[rel_account_vs_client] CHECK CONSTRAINT [FK_rel_account_vs_client_rel_account_client]
GO
ALTER TABLE [dbo].[rel_institution_vs_account]  WITH CHECK ADD  CONSTRAINT [FK_rel_institution_vs_account_Institution] FOREIGN KEY([idInstitution])
REFERENCES [dbo].[Institution] ([idInstitution])
GO
ALTER TABLE [dbo].[rel_institution_vs_account] CHECK CONSTRAINT [FK_rel_institution_vs_account_Institution]
GO
ALTER TABLE [dbo].[rel_institution_vs_account]  WITH CHECK ADD  CONSTRAINT [FK_rel_institution_vs_account_Institution_account] FOREIGN KEY([idAccount])
REFERENCES [dbo].[Institution_account] ([idAccount])
GO
ALTER TABLE [dbo].[rel_institution_vs_account] CHECK CONSTRAINT [FK_rel_institution_vs_account_Institution_account]
GO
/****** Object:  StoredProcedure [dbo].[ins_adm_account_balance]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pedro H Priuli
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ins_adm_account_balance]
	@idAccount INT,
	@idClient INT,
	@value DECIMAL(18,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO
    [dbo].[rel_account_vs_balance]
	VALUES(@idAccount,@value,GETDATE())

	SELECT 
	SUM(a.value) as creditCurrent
	FROM
	[dbo].[rel_account_vs_balance] a WITH(NOLOCK)
	INNER JOIN [dbo].[rel_account_vs_client] b WITH(NOLOCK) ON(b.idAccount = a.idAccount)
	WHERE b.idClient = @idClient


END
GO
/****** Object:  StoredProcedure [dbo].[ins_adm_client]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pedro H Priuli
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ins_adm_client]
	@name VARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Identity INT

    IF NOT EXISTS(SELECT 1 FROM Client WHERE name = @name)
	BEGIN

		INSERT INTO Client VALUES(@name);

		SET @Identity = SCOPE_IDENTITY()			
		SELECT * FROM Client where idClient = @Identity
	END
	ELSE
	set @Identity= -1

END
GO
/****** Object:  StoredProcedure [dbo].[ins_adm_institution]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ins_adm_institution]
	@name VARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Identity INT

    IF NOT EXISTS(SELECT 1 FROM Institution WHERE name = @name)
	BEGIN

		INSERT INTO Institution	VALUES(@name);

		SET @Identity = SCOPE_IDENTITY()			
		SELECT * FROM Institution where idInstitution = @Identity
	END
	ELSE
	set @Identity= -1

END
GO
/****** Object:  StoredProcedure [dbo].[ins_adm_institution_vs_account]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pedro H Priuli
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ins_adm_institution_vs_account]
@idAccount INT,
@idInstitution INT,
@idClient INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

BEGIN TRY  
   BEGIN TRAN
    INSERT INTO [dbo].[rel_institution_vs_account] VALUES (@idInstitution,@idAccount);
	INSERT INTO [dbo].[rel_account_vs_client] VALUES (@idClient,@idAccount);

	SELECT 
	e.number,
	b.name as ClientName,
	d.name as InstitutionName
	FROM [dbo].[rel_account_vs_client] a WITH(NOLOCK) 
	INNER JOIN [dbo].[rel_institution_vs_account] c WITH(NOLOCK) ON(c.idAccount = a.idAccount)
	INNER JOIN [dbo].[Institution] d WITH(NOLOCK) ON(d.idInstitution = c.idInstitution)	
	INNER JOIN [dbo].[Client] b WITH(NOLOCK) ON(b.idClient = a.idClient)
	INNER JOIN [dbo].[Institution_account] e WITH(NOLOCK) ON(e.idAccount = a.idAccount)
	WHERE b.idClient = @idClient

   COMMIT TRAN
END TRY  
BEGIN CATCH  
   ROLLBACK TRAN
END CATCH 

   

	

END
GO
/****** Object:  StoredProcedure [dbo].[sel_adm_account_balance]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pedro H Priuli
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sel_adm_account_balance]
@idClient INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		a.name as ClientName,
		c.number as NumberAccount,
		e.name as InstitutionName,
		c.idAccount ,
		sum(f.value) as SumBalance
	FROM [dbo].[Client] a WITH(NOLOCK)
	INNER JOIN [dbo].[rel_account_vs_client] b WITH(NOLOCK) ON(b.idClient = a.idClient)
	INNER JOIN [dbo].[Institution_account] c WITH(NOLOCK) ON(c.idAccount = b.idAccount)
	INNER JOIN [dbo].[rel_institution_vs_account] d WITH(NOLOCK) ON(d.idAccount= c.idAccount)
	INNER JOIN [dbo].[Institution] e WITH(NOLOCK) ON(e.idInstitution = d.idInstitution)
	INNER JOIN [dbo].[rel_account_vs_balance] f WITH(NOLOCK) ON( f.idAccount = b.idAccount)
	WHERE a.idClient = @idClient
		group by 
		a.name ,
		c.number ,
		e.name ,
		c.idAccount



END
GO
/****** Object:  StoredProcedure [dbo].[sel_adm_account_generate]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pedro H Priuli
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sel_adm_account_generate]
@idAccount INT OUT,
@number VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


    INSERT INTO [dbo].[Institution_account] VALUES (@number);
	SET @idAccount = SCOPE_IDENTITY()	

END
GO
/****** Object:  StoredProcedure [dbo].[sel_adm_bank_collection]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pedro H Priuli
-- Create date: 07/04/2019
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sel_adm_bank_collection]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[Institution] WITH(NOLOCK)

END
GO
/****** Object:  StoredProcedure [dbo].[sel_adm_client_account]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pedro H Priuli
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sel_adm_client_account]
@idClient INT = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		a.name as ClientName,
		c.number as NumberAccount,
		e.name as InstitutionName,
		c.idAccount ,
		ISNULL(SUM(f.value),0) as balance
	FROM [dbo].[Client] a WITH(NOLOCK)
	INNER JOIN [dbo].[rel_account_vs_client] b WITH(NOLOCK) ON(b.idClient = a.idClient)
	INNER JOIN [dbo].[Institution_account] c WITH(NOLOCK) ON(c.idAccount = b.idAccount)
	INNER JOIN [dbo].[rel_institution_vs_account] d WITH(NOLOCK) ON(d.idAccount= c.idAccount)
	INNER JOIN [dbo].[Institution] e WITH(NOLOCK) ON(e.idInstitution = d.idInstitution)
	LEFT JOIN [dbo].[rel_account_vs_balance] f WITH(NOLOCK) ON(f.idAccount = b.idAccount)
	WHERE a.idClient = IIF(@idClient IS NULL, a.idClient, @idClient)
	group by
		a.name ,
		c.number,
		e.name,
		c.idAccount 

END
GO
/****** Object:  StoredProcedure [dbo].[sel_adm_client_collection]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pedro H Priuli
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sel_adm_client_collection]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from Client WITH(NOLOCK)
END
GO
/****** Object:  StoredProcedure [dbo].[sel_adm_client_simulation]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pedro H Priuli
-- Create date: 07/04/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sel_adm_client_simulation]
	@idClient INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT 
		a.value as balance,
		a.date
	FROM 
	[dbo].[rel_account_vs_balance] a WITH(NOLOCK)
	INNER JOIN [dbo].[rel_account_vs_client] b WITH(NOLOCK) ON(b.idAccount = a.idAccount)
	WHERE b.idClient=@idClient

END
GO
/****** Object:  StoredProcedure [dbo].[upd_adm_account_balance]    Script Date: 04/01/2024 10:29:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[upd_adm_account_balance]
    @idClient INT,
	@idAccount INT,
	@Value DECIMAL(18,2),
	@TypeTransaction BIT,
	@idAccountDestiny INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ValueCurrent DECIMAL(18,2)   
	
	SET @ValueCurrent = (SELECT SUM([value]) FROM [dbo].[rel_account_vs_balance] WHERE idAccount = @idAccount)

	UPDATE [dbo].[rel_account_vs_balance] SET value = ([value] - @Value) where idAccount = @idAccount
		
	INSERT INTO [dbo].[rel_account_vs_balance] 
	VALUEs (@idAccountDestiny,@Value,GETDATE())

	SELECT @ValueCurrent as last, 
	(SELECT SUM([value]) as [current]
	FROM [dbo].[rel_account_vs_balance] WHERE idAccount = @idAccount) 


	
END
GO
