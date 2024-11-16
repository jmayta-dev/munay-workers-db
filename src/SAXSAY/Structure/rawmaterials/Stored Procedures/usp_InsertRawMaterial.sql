/*
<documentation>
	<object type="P" schema="rawmaterials" name="usp_InsertRawMaterial" />
	<summary>Insert Raw Material</summary>
	<author>Jheison J. Mayta C.</author>
	<createdAt>2024.11.02</createdAt>
	<sourceLink></sourceLink>
	<example></example>
</documentation>
*/
CREATE PROCEDURE [rawmaterials].[usp_InsertRawMaterial] (
	  @id					[CHAR](24)
	, @name					[NVARCHAR](255)
	, @unspsc				[CHAR](11) 			= ''
	, @unspscDescription	[NVARCHAR](400)		= ''
	, @createdAt			[DATETIMEOFFSET]	= NULL
	, @updatedAt			[DATETIMEOFFSET]	= NULL
	, @isEnabled			[BIT] 				= 1
)
AS
SET NOCOUNT ON;
BEGIN
	DECLARE
		  @_createdAt [DATETIMEOFFSET]
		, @_updatedAt [DATETIMEOFFSET];

	IF (@createdAt IS NULL OR @createdAt = '0001-01-01T00:00:00.0000000+00:00')
	BEGIN
		SET @_createdAt = SYSDATETIMEOFFSET() AT TIME ZONE 'UTC';
	END
	ELSE
	BEGIN
		SET @_createdAt = @createdAt;
	END

	SET @_updatedAt = @_createdAt;

	BEGIN TRY
		INSERT INTO [rawmaterials].[RawMaterials] (
			  [Id]					, [Name]		, [UNSPSC]
			, [UNSPSCDescription]	, [CreatedAt]	, [UpdatedAt]
			, [IsEnabled]
		) VALUES (
			  @id					, @name			, @unspsc
			, @unspscDescription	, @_createdAt	, @_updatedAt
			, @isEnabled
		)
	END TRY
	BEGIN CATCH
		EXECUTE [core].[usp_DBErrorLogger];
		THROW;
	END CATCH
	RETURN 0;
END
GO
