/*
	THIS SCRIPT SHOULD BE EXCECUTED ONCE DIRECTLY IN A QUERY WINDOW TO SETUP
	THE DATABASE, LOGINS AND INITIAL PERMISSIONS.
*/
USE [master];
GO
-- CREATE DB IF NOT EXISTS
IF DB_ID(N'MWSAXSAYDB') IS NULL
BEGIN
	CREATE DATABASE [MWSAXSAYDB]
		COLLATE SQL_Latin1_General_CP1_CI_AI;
END
GO
-- USE DB AFTER CREATION
USE MWSAXSAYDB;
GO

/*
|------------------------------------------------------------------------------|
| MAIN EXECUTION
|------------------------------------------------------------------------------|
*/
SET XACT_ABORT ON;
GO
-- DECLARATIONS
DECLARE
	  @_userName     	NVARCHAR(20)  	= N'mwsaxsay'
	, @_loginName    	NVARCHAR(20)  	= N'mwsaxsay'
	, @_memberName   	NVARCHAR(20) 	= N'mwsaxsay'
	, @_readRoleName 	NVARCHAR(30) 	= N'db_datareader'
	, @_writeRoleName	NVARCHAR(30) 	= N'db_datawriter'
	, @_sqlString    	NVARCHAR(2000)	= N''
	, @_sqlParameters	NVARCHAR(2000)	= N'';

--------------------------------------------------------------------------------
--> USER AND LOGIN CREATION
--------------------------------------------------------------------------------
-- LOGIN
IF NOT EXISTS ( SELECT 1
				FROM [sys].[server_principals]
				WHERE [name] = @_loginName
					AND [type] = 'S'
)
BEGIN
	CREATE LOGIN mwsaxsay
		  WITH PASSWORD = '54f3P455w0rd' 
		, DEFAULT_DATABASE = MWSAXSAYDB;
END

-- USER
IF NOT EXISTS ( SELECT 1
				FROM [sys].[database_principals]
				WHERE [name] = @_userName
					AND [type] = 'S')
BEGIN
	SET @_sqlString =	N'CREATE USER ' + QUOTENAME(@_userName) +
						'	FOR LOGIN ' + QUOTENAME(@_loginName) + ';';
	EXECUTE sp_executesql
		@stmt = @_sqlString;
END
/*
--------------------------------------------------------------------------------
-> PERMISSIONS ASSIGNMENT
--------------------------------------------------------------------------------
*/
IF NOT EXISTS ( SELECT 1
				FROM [sys].[database_role_members] drm
				INNER JOIN [sys].[database_principals] mm
						ON drm.[member_principal_id] = mm.[principal_id]
				INNER JOIN [sys].[database_principals] rm
						ON drm.[role_principal_id] = rm.[principal_id]
				WHERE mm.[name] = @_memberName
					AND rm.[name] = @_readRoleName
)
BEGIN
	-- add read permission to the application user
	EXECUTE sp_addrolemember
		  @rolename = @_readRoleName
		, @membername = @_memberName;
END                

IF NOT EXISTS ( SELECT 1
				FROM [sys].[database_role_members] drm
				INNER JOIN [sys].[database_principals] mm
						ON drm.[member_principal_id] = mm.[principal_id]
				INNER JOIN [sys].[database_principals] rm
						ON drm.[role_principal_id] = rm.[principal_id]
				WHERE mm.[name] = @_memberName
					AND rm.[name] = @_writeRoleName
)
BEGIN
	-- add write permission to the application user
	EXECUTE sp_addrolemember
		  @rolename = @_writeRoleName
		, @membername = @_memberName;
END
GO

SET XACT_ABORT OFF;
GO