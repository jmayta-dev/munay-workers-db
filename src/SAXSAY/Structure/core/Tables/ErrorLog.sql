/*
<documentation>
    <object type="U" schema="core" name="ErrorLog" />
    <summary>
        Stores the error log generated in the application and/or database
    </summary>
    <author>Jheison J. Mayta C.</author>
    <createdAt>2024.10.26</createdAt>
    <sourceLink></sourceLink>
</documentation>
*/
CREATE TABLE core.ErrorLog
(
      Id             bigint IDENTITY(1,1) NOT NULL
    , ErrorNumber    int                  NULL -- ERROR_NUMBER()
    , ErrorSeverity  int                  NULL -- ERROR_SEVERITY()
    , ErrorState     int                  NULL -- ERROR_STATE()
    , ErrorLine      int                  NULL -- ERROR_LINE()
    , ErrorMessage   nvarchar(4000)       NULL -- ERROR_MESSAGE()
    , ErrorProcedure nvarchar(128)        NULL -- ERROR_PROCEDURE()
    , StackTrace     nvarchar(4000)       NULL -- APPLICATION CLIENT ST
    , HostName       nvarchar(128)        NULL -- HOST_NAME()
    , AppName        nvarchar(128)        NULL -- APP_NAME()
    , UserName       nvarchar(128)        NULL -- SUSER_SNAME()
    , CreatedAt      datetime             NULL -- GETUTCDATE()
) ON [PRIMARY]
GO

-- // CONSTRAINTS ->
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT PK_ErrorLog_Id PRIMARY KEY CLUSTERED (Id);
GO
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT DF_ErrorLog_Number DEFAULT -1 FOR ErrorNumber
GO
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT DF_ErrorLog_Severity DEFAULT -1 FOR ErrorSeverity
GO
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT DF_ErrorLog_State DEFAULT -1 FOR ErrorState
GO
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT DF_ErrorLog_Line DEFAULT -1 FOR ErrorLine
GO
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT DF_ErrorLog_Message DEFAULT '' FOR ErrorMessage
GO
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT DF_ErrorLog_Procedure DEFAULT '' FOR ErrorProcedure
GO
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT DF_ErrorLog_StackTrace DEFAULT '' FOR StackTrace
GO
-- audit fields
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT DF_ErrorLog_HostName DEFAULT HOST_NAME() FOR HostName
GO
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT DF_ErrorLog_AppName DEFAULT APP_NAME() FOR AppName
GO
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT DF_ErrorLog_UserId DEFAULT SUSER_SNAME() FOR UserName
GO
ALTER TABLE core.ErrorLog
    ADD CONSTRAINT DF_ErrorLog_CreatedAt DEFAULT GETUTCDATE() FOR CreatedAt
GO
-- <- CONSTRAINTS //

-- // INDEXES ->
CREATE NONCLUSTERED INDEX IXC_ErrorLog_CreatedAt
    ON core.ErrorLog (CreatedAt) INCLUDE (ErrorSeverity)
GO
-- <- INDEXES //

-- // EXTENDED PROPERTIES ->
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Error Log table'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Error Identifier (auto)'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'Id'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Error number'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'ErrorNumber'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Error message'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'ErrorMessage'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Error severity value at the time the error ocurred'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'ErrorSeverity'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'State number which caused the error to be caught (sql)'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'ErrorState'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Line number where the error occurred'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'ErrorLine'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Procedure name when the error occurred'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'ErrorProcedure'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Error stack trace when the error occurred'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'StackTrace'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Application name that sent the instruction'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'AppName'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Logged user''s name at the time the error ocurred'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'UserName'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Workstation name when the error ocurred'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'HostName'
GO
EXEC sp_addextendedproperty
      @name			= N'MS_Description'
    , @value		= 'Date and time when error was thrown'
    , @level0type	= 'SCHEMA', @level0name	= N'core'
    , @level1type	= 'TABLE' , @level1name	= N'ErrorLog'
    , @level2type	= 'COLUMN', @level2name	= N'CreatedAt'
GO
-- <- EXTENDED PROPERTIES //
