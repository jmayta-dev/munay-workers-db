/*
<documentation>
	<object type="P" schema="rawmaterials" name="usp_UpdateRawMaterial" />
	<summary>Update Raw Material information</summary>
	<author>Jheison J. Mayta C.</author>
	<createdAt>2024.11.02</createdAt>
	<sourceLink></sourceLink>
	<example></example>
</documentation>
*/
CREATE PROCEDURE [rawmaterials].[usp_UpdateRawMaterial](
	  @id					[CHAR](24)
	, @name					[NVARCHAR](255)
	, @unspsc				[CHAR](11) 			= ''
	, @unspscDescription	[NVARCHAR](400)		= ''
	, @updatedAt			[DATETIMEOFFSET]	= NULL
	, @isEnabled			[BIT] 				= 1
)
AS
SET NOCOUNT ON;
BEGIN
	DECLARE
		@_updatedAt [DATETIMEOFFSET];

	SET @_updatedAt = ISNULL(@updatedAt, SYSDATETIMEOFFSET() AT TIME ZONE 'UTC');

	BEGIN TRY
		UPDATE [rawmaterials].[RawMaterials]
		SET
			 [Name]					= @name
			,[UNSPSC]				= @unspsc
			,[UNSPSCDescription]	= @unspscDescription
			,[UpdatedAt]			= @_updatedAt
			,[IsEnabled]			= @isEnabled
		WHERE [Id] = @id;
	END TRY
	BEGIN CATCH
		EXECUTE [core].[usp_DBErrorLogger];
		THROW;
	END CATCH
	RETURN 0;
END
GO
