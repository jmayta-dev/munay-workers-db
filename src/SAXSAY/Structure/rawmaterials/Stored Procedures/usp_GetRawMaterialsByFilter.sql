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
			@queryString = 1;
	</example>
</documentation>
*/
CREATE PROCEDURE [rawmaterials].[usp_GetRawMaterialsByFilter](
	  @queryString	NVARCHAR(25)
	, @filterType	INT 			= 1
	, @onlyActive	BIT				= 0
)
AS
SET NOCOUNT ON;
BEGIN
	/* --------------------------------------
		Filter Types:

		ById				= 1 (default)
		ByName				= 2
		ByUNSPSC			= 3
		ByUNSPSCDescription = 4
	-------------------------------------- */
	DECLARE
		  @sqlMain		NVARCHAR(1000)
		, @sqlActive	NVARCHAR(250)
		, @sqlDynamic	NVARCHAR(250)

	-- set the main statement
	SET @sqlMain = N'
		SELECT [Id], [Name], [UNSPSC], [UNSPSCDescription], [CreatedAt]	, [UpdatedAt], [IsEnabled]
		FROM [rawmaterials].[RawMaterials]
		WHERE';

	-- validate if only enabled records will be considered
	SET @sqlActive = IIF(@onlyActive = 1, N' [IsEnabled] = 1 AND', N'');

	-- evaluate which filter will be applied
	SET @sqlDynamic =
		CASE @filterType
			WHEN 1 THEN N' [Id] = @queryString;'
			WHEN 2 THEN N' [Name] = @queryString;'
			WHEN 3 THEN N' [UNSPSC] = @queryString;'
			WHEN 4 THEN N' [UNSPSCDescription] = @queryString;'
			ELSE N'' -- throw when filter type is not recognized
		END;

	BEGIN TRY
		IF (ISNULL(@sqlDynamic, N'') = N'')
		BEGIN
			DECLARE @msg NVARCHAR(200) = '';
			-- build the message
			SET @msg = FORMATMESSAGE(
				  N'Invalid value for filter type parameter. ' +
				  N'Expected 1, 2, 3 or 4. Actual value %s'
				, @sqlDynamic);
			-- throw
			;THROW 50000, @msg, 1;
		END
	END TRY
	BEGIN CATCH
		EXEC [core].[usp_DBErrorLogger];
	END CATCH

	SET @sqlMain = @sqlMain + @sqlActive + @sqlDynamic;

	EXEC sp_executesql
		@stmt = @sqlMain,
		@params = N'@queryString NVARCHAR(25)',
		@queryString = @queryString;
	
END
GO
