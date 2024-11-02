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
	</example>
</documentation>
*/
CREATE PROCEDURE [rawmaterials].[usp_GetRawMaterialsByFilter](
	@queryString	NVARCHAR(255)	= ''
)
AS
SET NOCOUNT ON;
BEGIN
	SELECT 
		  [Id]			, [Name]
		, [UNSPSC]		, [UNSPSCDescription]
		, [CreatedAt]	, [UpdatedAt]
		, [IsEnabled]
	FROM [rawmaterials].[RawMaterials]
	WHERE [Name] LIKE '%' + @queryString + '%';
END
GO
