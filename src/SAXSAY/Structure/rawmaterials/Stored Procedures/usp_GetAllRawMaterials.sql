/*
<documentation>
	<object type="P" schema="rawmaterials" name="usp_GetAllRawMaterials" />
	<summary></summary>
	<author>Jheison J. Mayta C.</author>
	<createdAt>2024.10.31</createdAt>
	<sourceLink></sourceLink>
	<example>
		EXECUTE rawmaterials.usp_GetAllRawMaterials;
	</example>
</documentation>
*/
CREATE PROCEDURE [rawmaterials].[usp_GetAllRawMaterials]
AS
SET NOCOUNT ON;
BEGIN
	SELECT 
		[Id], [Name], [UNSPSC], [UNSPSCDescription],
		[CreatedAt], [UpdatedAt], [IsEnabled]
	FROM [rawmaterials].[RawMaterials];
END
GO
