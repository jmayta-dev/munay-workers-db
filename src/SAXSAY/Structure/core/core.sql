CREATE SCHEMA [core];
GO
EXEC sp_addextendedproperty
	@name			= N'MS_Description'
	, @value		= 'CORE schema'
	, @level0type	= 'SCHEMA'
	, @level0name	= N'core'
GO