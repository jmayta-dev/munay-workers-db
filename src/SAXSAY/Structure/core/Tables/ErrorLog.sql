CREATE TABLE [core].[ErrorLog]
(
	[Id]			[BIGINT] IDENTITY(1,1),
	[Number]		[INT]					NULL,		-- ERROR_NUMBER()
	[Severity]		[INT]					NULL,		-- ERROR_SEVERITY()
	[State]		 	[INT]					NULL,		-- ERROR_STATE()
	[Line]		  	[INT]					NULL,		-- ERROR_LINE()
	[Message]		[NVARCHAR](4000)		NULL,		-- ERROR_MESSAGE()
	[Procedure]		[NVARCHAR](128)			NULL,		-- ERROR_PROCEDURE()
	[StackTrace]	[NVARCHAR](4000)		NULL,		-- APPLICATION CLIENT ST

	[HostName]		[NVARCHAR](128)	  		NULL,		-- HOST_NAME()
	[AppName]		[NVARCHAR](128)	  		NULL,		-- APP_NAME()
	[UserName]		[NVARCHAR](128)	  		NULL,		-- SUSER_SNAME()
	[CreatedAt]	  	[DATETIME]		  		NULL		-- GETUTCDATE()
) ON [PRIMARY]
GO
/*
<documentation>
	<object type="U" schema="core" name="ErrorLog" />
	<summary>
		Stores the error log generated in the application and/or database
	</summary>
	<author>Jheison J. Mayta C.</author>
	<createdAt>2024.10.26</createdAt>
	<sourceLink></sourceLink>
	<example></example>
</documentation>
*/

ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT PK_ErrorLog_Id PRIMARY KEY CLUSTERED ([Id]);
GO
ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT DF_ErrorLog_Number DEFAULT -1 FOR [Number]
GO
ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT DF_ErrorLog_Severity DEFAULT -1 FOR [Severity]
GO
ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT DF_ErrorLog_State DEFAULT -1 FOR [State]
GO
ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT DF_ErrorLog_Line DEFAULT -1 FOR [Line]
GO
ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT DF_ErrorLog_Message DEFAULT '' FOR [Message]
GO
ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT DF_ErrorLog_Procedure DEFAULT '' FOR [Procedure]
GO
ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT DF_ErrorLog_StackTrace DEFAULT '' FOR [StackTrace]
GO

-- AUDIT FIELDS
ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT DF_ErrorLog_HostName DEFAULT HOST_NAME() FOR [HostName]
GO
ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT DF_ErrorLog_AppName DEFAULT APP_NAME() FOR [AppName]
GO
ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT DF_ErrorLog_UserId DEFAULT SUSER_SNAME() FOR [UserName]
GO
ALTER TABLE [core].[ErrorLog]
	ADD CONSTRAINT DF_ErrorLog_CreatedAt DEFAULT GETUTCDATE() FOR [CreatedAt]
GO

-- INDEXES
CREATE NONCLUSTERED INDEX IXC_ErrorLog_CreatedAt ON [core].[ErrorLog] ([CreatedAt])
	INCLUDE ([Severity])
GO

-- EXTENDED PROPERTIES
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Error Log table'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Error Identifier (auto)'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'Id'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Error number'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'Number'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Error message'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'Message'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Error severity value at the time the error ocurred'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'Severity'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'State number which caused the error to be caught (sql)'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'State'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Line number where the error occurred'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'Line'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Procedure name when the error occurred'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'Procedure'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Error stack trace when the error occurred'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'StackTrace'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Application name that sent the instruction'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'AppName'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Logged user''s name at the time the error ocurred'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'UserName'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Workstation name when the error ocurred'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'HostName'
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'Date and time when error was thrown'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
	, @level1type	= 'TABLE'
	, @level1name	= N'ErrorLog'
	, @level2type	= 'COLUMN'
	, @level2name	= N'CreatedAt'
GO