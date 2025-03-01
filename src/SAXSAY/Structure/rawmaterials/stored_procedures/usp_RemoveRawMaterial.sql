/*
<documentation>
	<object type="P" schema="rawmaterials" name="usp_RemoveRawMaterial" />
	<summary>Remove Raw Material</summary>
	<author>Jheison J. Mayta C.</author>
	<createdAt>2024.11.02</createdAt>
	<sourceLink></sourceLink>
	<example></example>
</documentation>
*/
CREATE PROCEDURE [rawmaterials].[usp_RemoveRawMaterial](
	@id	[CHAR](24)
)
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		DELETE FROM [rawmaterials].[RawMaterials]
		WHERE Id = @id;
	END TRY
	BEGIN CATCH
		EXECUTE [core].[usp_DBErrorLogger];
		THROW;
	END CATCH
	RETURN 0;
END
GO
