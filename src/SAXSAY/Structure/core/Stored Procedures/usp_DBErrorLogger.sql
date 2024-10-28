/*
<documentation>
	<object type="P" schema="core" name="usp_DBErrorLogger" />
	<summary>
		Alters how the error is displayed and stores its information in the
		error log table.
	</summary>
	<author>Jheison J. Mayta C.</author>
	<createdAt>2024.10.26</createdAt>
	<sourceLink></sourceLink>
	<example>
		-- ... more code above
		END TRY
		BEGIN CATCH
			EXEC [core].[usp_DBErrorLogger];
		END CATCH
		-- and more code below ...
	</example>
</documentation>
*/
CREATE PROCEDURE [core].[usp_DBErrorLogger](
	@userName	NVARCHAR(128) = ''
)
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN
	-- DECLARATIONS
	DECLARE
		  @_userName	NVARCHAR(128)
		, @_errorId		BIGINT;

	-- ARRANGE
	SET @_userName = IIF(@userName = '', SUSER_SNAME(), @userName);

	-- INSERT ERROR
	INSERT INTO [core].[ErrorLog] (
		  [Number]			, [Severity]		, [State]
		, [Line]			, [Message]			, [Procedure]
		, [StackTrace]		, [HostName]		, [AppName]
		, [UserName]		, [CreatedAt]
	) VALUES (
		  ERROR_NUMBER()	, ERROR_SEVERITY()	, ERROR_STATE()
		, ERROR_LINE()		, ERROR_MESSAGE()	, ISNULL(ERROR_PROCEDURE(), 'Not within procedure')
		, ''				, HOST_NAME()		, APP_NAME()
		, @_userName		, GETUTCDATE()
	)

	-- SHOW ERROR INFORMATION
	SET @_errorId = ISNULL(@@IDENTITY, 0)

	SELECT
		  [Id]			, [Number]	, [Severity]	, [State]
		, [Line]		, [Message]	, [Procedure]	, [StackTrace]
		, [HostName]	, [AppName]	, [UserName]	, [CreatedAt]
	FROM [core].[ErrorLog]
	WHERE [Id] = @_errorId;
END
GO