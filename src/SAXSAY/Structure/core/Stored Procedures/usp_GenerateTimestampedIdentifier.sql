/*
<object type="p" schema="core" name="usp_GenerateTimestampedIdentifier">
	<summary>
		Generates a timestamped identifier with the length provided by each portion
		(timestamp and random string) plus one (+ 1). Default length is fifteen (15) for
		timestamp and eight (8) for random string.
	</summary>
	<author>Jheison J. Mayta C.</author>
	<createdAt>2024.10.14</createdAt>
	<sourceLink></sourceLink>
	<example>
		DECLARE @out VARCHAR(MAX);
		EXEC core.usp_GenerateTimestampedIdentifier
			@timestampedId = @out OUTPUT
		PRINT @out

	</example>
</object>
*/
CREATE PROCEDURE [core].[usp_GenerateTimestampedIdentifier]
	@timestampedLength	INT = 15,
	@randomStringLength	INT = 8,
	@timestampedId		VARCHAR(MAX) OUTPUT
AS
BEGIN
	DECLARE
		@_mstimestamp	BIGINT,
		@_randomString	VARCHAR(MAX);

	-- retrieve random string
	BEGIN TRY
		EXEC [core].[usp_GenerateRandomString]
			  @stringLength = @randomStringLength
			, @randomString = @_randomString OUTPUT;

		IF (@_randomString IS NULL OR @_randomString = '')
		BEGIN
			;THROW 50001, 'The generated random string is empty', 0
		END
	END TRY
	BEGIN CATCH
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		THROW;
	END CATCH;

	-- get miliseconds from UTC timestamp
	SELECT @_mstimestamp =	DATEDIFF_BIG(
								MILLISECOND,
								CAST('1970-01-01 00:00:00.000 +00:0' AS DATETIMEOFFSET),
								SYSDATETIMEOFFSET()
							)

	-- complete and concatenate the strings
	SET @timestampedId =	RIGHT(REPLICATE('0', @timestampedLength) + CONVERT(VARCHAR(15), @_mstimestamp), @timestampedLength) + '-' + @_randomString
END
