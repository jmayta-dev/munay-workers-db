/*
<documentation>
	<object type="P" schema="rawmaterials" name="usp_GetRawMaterialsByFilter" />
	<summary>
		Retrieves a list of raw materials filtered by type and parameter value
	</summary>
	<author>Jheison J. Mayta C.</author>
	<createdAt>2024.10.27</createdAt>
	<sourceLink></sourceLink>
	<example>
		EXEC rawmaterials.usp_GetRawMaterialsByFilter
			@queryString = ''
			@filterType = 0
	</example>
</documentation>
*/
CREATE PROCEDURE [rawmaterials].[usp_GetRawMaterialsByFilter](
	  @queryString	NVARCHAR(25)	= NULL
	, @filterType	INT 			= 0
	, @onlyActive	BIT				= 0
)
AS
SET NOCOUNT ON;
BEGIN
	/* --------------------------------------
		Filter Types:

		All					= 0 (default)
		ById				= 1
		ByName				= 2
		ByUNSPSC			= 3
		ByUNSPSCDescription = 4
	-------------------------------------- */
	DECLARE
		  @sqlMain		NVARCHAR(1000)
		, @sqlActive	NVARCHAR(250)
		, @sqlDynamic	NVARCHAR(250)
		, @errorMsg		NVARCHAR(250)

	-- set the main sql statement
	SET @sqlMain =
		N'SELECT ' +
			N'[Id], [Name], [UNSPSC], [UNSPSCDescription], ' +
			N'[CreatedAt], [UpdatedAt], [IsEnabled] ' +
		N'FROM [rawmaterials].[RawMaterials]';

	-- validate if only enabled records will be considered
	SET @sqlActive = IIF(@onlyActive = 1, N' [IsEnabled] = 1 AND', N'');

	-- evaluate which filter will be applied
	SET @sqlDynamic =
		CASE @filterType
			WHEN 0 THEN N' -- ALL'
			WHEN 1 THEN N' [Id] = @queryString;'
			WHEN 2 THEN N' [Name] = ''%''+@queryString+''%'';'
			WHEN 3 THEN N' [UNSPSC] = @queryString+''%'';'
			WHEN 4 THEN N' [UNSPSCDescription] = ''%''+@queryString+''%'';'
			ELSE N'' -- throw when filter type is not recognized
		END;

	BEGIN TRY
		IF (ISNULL(@sqlDynamic, N'') = N'')
		BEGIN
			-- build the error message
			SET @errorMsg = FORMATMESSAGE(
				  N'Invalid value for filter type parameter. ' +
				  N'Expected 1, 2, 3 or 4. Actual value %s'
				, CAST(@filterType AS NVARCHAR(50)));
			-- throw passing message
			;THROW 50000, @errorMsg, 1;
		END
	END TRY
	BEGIN CATCH
		EXEC [core].[usp_DBErrorLogger];
		THROW;
	END CATCH

	BEGIN TRY
		IF(@filterType BETWEEN 1 AND 4)
		BEGIN
			IF(ISNULL(TRIM(@queryString), N'') = N'')
			BEGIN
				-- build the error message
				SET @errorMsg = FORMATMESSAGE(
					  N'Query string has not been provided.'
					, @sqlDynamic);
				-- throw passing message
				;THROW 50000, @errorMsg, 1;
			END
			ELSE
			BEGIN
				SET @sqlMain += N' WHERE ';
			END
		END
	END TRY
	BEGIN CATCH
		EXEC [core].[usp_DBErrorLogger];
		THROW;
	END CATCH


	SET @sqlMain = @sqlMain + @sqlActive + @sqlDynamic;

	-- execute the concatenated sql statement
	EXEC sp_executesql
		@stmt = @sqlMain,
		@params = N'@queryString NVARCHAR(25)',
		@queryString = @queryString;
END
GO
