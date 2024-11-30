/*
<documentation>
	<object type="P" schema="core" name="usp_GenerateRandomString" />
	<summary>
		Generates an alpha numeric random string with length provided.
		Limit length is 256
	</summary>
	<author>Jheison J. Mayta C.</author>
	<createdAt>2024.10.14</createdAt>
	<sourceLink></sourceLink>
	<example>
		DECLARE @out NVARCHAR(256);
		EXEC core.usp_GenerateRandomString
			@randomString = @out OUTPUT
		SELECT @out
	</example>
</documentation>
*/
CREATE PROCEDURE [core].[usp_GenerateRandomString](
	  @stringLength	INT = 6
	, @randomString	NVARCHAR(256) OUTPUT
)
AS
SET NOCOUNT ON;
BEGIN
	DECLARE
		  @_lengthLimit INT = 256
		, @_msg			NVARCHAR(2048);

	BEGIN TRY
		IF(@stringLength > 256)
		BEGIN
			SET @_msg = FORMATMESSAGE(
				 'Limit exceeded for string length parameter. Limit is (%d), (%d) provided.'
				, @_lengthLimit
				, @stringLength);
			THROW 50000, @_msg, 1;
		END
	END TRY
	BEGIN CATCH

	END CATCH

	DECLARE
		  @_asciiLowercase	VARCHAR(26)
		, @_asciiUppercase	VARCHAR(26)
		, @_charPool		VARCHAR(62)
		, @_digits			VARCHAR(10)
		, @_loopCount		INT
		, @_poolLength		INT
		, @_randomChar		VARCHAR(1)
		, @_randomString	VARCHAR(50);

	SET @_asciiLowercase	= 'abcdefghijklmnopqrstuvwxyz';
	SET @_asciiUppercase	= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	SET @_digits			= '0123456789';
	SET @_charPool			= CONCAT(@_asciiLowercase, @_asciiUppercase, @_digits);
	SET @_loopCount			= 0;
	SET @_poolLength		= LEN(@_charPool);
	SET @_randomString		= '';

	WHILE (@_loopCount < @stringLength)
	BEGIN
		-- get a random character from pool
		SET @_randomChar = SUBSTRING(
			  @_charPool
			, CAST(RAND() * @_poolLength AS INT) + 1
			, 1);

		-- add selected char to string
		SET @_randomString = @_randomString + @_randomChar;

		-- increment the loop counter by one
		SET @_loopCount = @_loopCount + 1;
	END

	SET @randomString = ISNULL(@_randomString, '');
END
GO