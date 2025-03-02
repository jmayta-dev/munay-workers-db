IF (OBJECT_ID(N'rawmaterials.usp_GetAllRawMaterials', N'P') IS NULL)
EXECUTE('CREATE PROCEDURE rawmaterials.usp_GetAllRawMaterials AS SELECT 1')
GO


ALTER PROCEDURE rawmaterials.usp_GetAllRawMaterials (
      @pOnlyEnabled bit = 0
    , @pDebug       bit = 0
)
/*
<documentation>
    <object type="P" schema="rawmaterials" name="usp_GetAllRawMaterials" />
    <summary>Retrieve all Raw Materials</summary>
    <author>Jheison J. Mayta C.</author>
    <createdAt>2024.10.31</createdAt>
    <sourceLink></sourceLink>
    <example>
        EXECUTE rawmaterials.usp_GetAllRawMaterials;
    </example>
</documentation>
*/
AS
SET NOCOUNT ON;
BEGIN
    DECLARE
          @vOnlyEnabled bit = COALESCE(@pOnlyEnabled, 0)
        , @vDebug       bit = COALESCE(@pDebug, 0);

    IF(@vDebug = 1)
        PRINT CONCAT_WS('@vOnlyEnabled', '=', @vDebug);

    IF (@vOnlyEnabled = 1)
    BEGIN
        SELECT
            Id, Name, UNSPSC, CreatedAt, UpdatedAt, IsEnabled
        FROM rawmaterials.RawMaterials
        WHERE IsEnabled = 1;
    END
    ELSE
    BEGIN
        SELECT
            Id, Name, UNSPSC, CreatedAt, UpdatedAt, IsEnabled
        FROM rawmaterials.RawMaterials;
    END
END
GO