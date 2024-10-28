/*
<documentation>
	<object type="U" schema="auth" name="Users" />
	<summary>Users Table</summary>
	<author>Jheison J. Mayta C.</author>
	<createdAt>2024.10.27</createdAt>
	<sourceLink></sourceLink>
</documentation>
*/
CREATE TABLE [auth].[Users]
(
	  [Id]				[CHAR](24)			NOT NULL
	, [Password]		[NVARCHAR](255)		NOT NULL
	, [LastLogin]		[DATETIMEOFFSET]	NULL
	, [IsSuperuser]		[BIT]				NULL
	, [Username]		[VARCHAR](150)		NOT NULL
	, [FirstName]		[NVARCHAR](250)		NULL
	, [LastName]		[NVARCHAR](250)		NULL
	, [Email]			[NVARCHAR](250)		NULL
	, [IsStaff]			[BIT]				NULL
	, [IsActive]		[BIT]				NOT NULL
	, [DateJoined]		[DATETIMEOFFSET]	NULL
	, [UpdatedAt]		[DATETIMEOFFSET]	NULL
) ON [PRIMARY]
GO

-- CONSTRAINTS
ALTER TABLE [auth].[Users]
	ADD CONSTRAINT PK_Users_Id
		PRIMARY KEY CLUSTERED ([Id]);
GO
ALTER TABLE [auth].[Users]
	ADD CONSTRAINT DF_Users_IsSuperuser
		DEFAULT 0 FOR [IsSuperuser];
GO
ALTER TABLE [auth].[Users]
	ADD CONSTRAINT DF_Users_FirstName
		DEFAULT '' FOR [FirstName];
GO
ALTER TABLE [auth].[Users]
	ADD CONSTRAINT DF_Users_LastName
		DEFAULT '' FOR [LastName];
GO
ALTER TABLE [auth].[Users]
	ADD CONSTRAINT DF_Users_Email
		DEFAULT '' FOR [Email];
GO
ALTER TABLE [auth].[Users]
	ADD CONSTRAINT DF_Users_IsStaff
		DEFAULT 0 FOR [IsStaff];
GO
ALTER TABLE [auth].[Users]
	ADD CONSTRAINT DF_Users_IsActive
		DEFAULT 1 FOR [IsActive];
GO
ALTER TABLE [auth].[Users]
	ADD CONSTRAINT DF_Users_DateJoined
		DEFAULT SWITCHOFFSET(SYSDATETIMEOFFSET(), '+00:00')
			FOR [DateJoined];
GO
ALTER TABLE [auth].[Users]
	ADD CONSTRAINT DF_Users_UpdatedAt
		DEFAULT SWITCHOFFSET(SYSDATETIMEOFFSET(), '+00:00')
			FOR [UpdatedAt];
GO

-- INDEXES
CREATE NONCLUSTERED INDEX IX_Users_Username
	ON [auth].[Users] ([Username])
		INCLUDE ([FirstName], [LastName], [Email], [IsActive], [DateJoined])
GO

-- EXTENDED PROPERTIES
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'Users Table'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users';
GO
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'User Password'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users'
, @level2type	= 'COLUMN'		, @level2name	= N'Password';
GO
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'Date and time of the user''s last login.'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users'
, @level2type	= 'COLUMN'		, @level2name	= N'LastLogin';
GO
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'Determines if the user is a superuser. Default value is 0 (false)'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users'
, @level2type	= 'COLUMN'		, @level2name	= N'IsSuperuser';
GO
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'Username'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users'
, @level2type	= 'COLUMN'		, @level2name	= N'Username';
GO
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'First name. Default value is empty'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users'
, @level2type	= 'COLUMN'		, @level2name	= N'FirstName';
GO
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'Last name. Default value is empty'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users'
, @level2type	= 'COLUMN'		, @level2name	= N'LastName';
GO
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'Email. Default value is empty'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users'
, @level2type	= 'COLUMN'		, @level2name	= N'Email';
GO
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'Determines if the user belongs to the staff. Default value is 0 (false)'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users'
, @level2type	= 'COLUMN'		, @level2name	= N'IsStaff';
GO
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'Enable indicator. Determines if the user is enabled or disabled.'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users'
, @level2type	= 'COLUMN'		, @level2name	= N'IsActive';
GO
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'Date and time when the user was registered in the system.'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users'
, @level2type	= 'COLUMN'		, @level2name	= N'DateJoined';
GO
EXEC sp_addextendedproperty
  @name			= N'MS_Description'
, @value		= 'Date and time when the user''s information was updated.'
, @level0type	= 'SCHEMA'		, @level0name	= N'auth'
, @level1type	= 'TABLE'		, @level1name	= N'Users'
, @level2type	= 'COLUMN'		, @level2name	= N'UpdatedAt';
GO
