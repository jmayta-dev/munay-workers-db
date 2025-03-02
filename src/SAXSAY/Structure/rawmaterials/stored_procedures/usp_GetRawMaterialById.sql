IF (OBJECT_ID(N'rawmaterials.usp_GetRawMaterialById', N'P') IS NULL)
EXECUTE('CREATE PROCEDURE rawmaterials.usp_GetRawMaterialById AS SELECT 1');
GO

ALTER PROCEDURE rawmaterials.usp_GetRawMaterialById (
    @pId    int,
    @pDebug bit = 0
)
/*
<documentation>
    <object type="AF" schema="rawmaterials" name="usp_GetRawMaterialById" />
    <summary>Get raw material by its Id</summary>
    <author>Jheison J. Mayta C.</author>
    <createdAt>2025.03.01</createdAt>
    <sourceLink></sourceLink>
    <example>
        EXECUTE rawmaterials.usp_GetRawMaterialById
            @pId = 1;
    </example>
</documentation>
*/
AS
SET NOCOUNT ON;
BEGIN
    DECLARE
          @vId    int = @pId
        , @vDebug bit = @pDebug;

    BEGIN TRY
        IF(@pId IS NULL OR @pId < 0)
        RAISERROR(15600, -1, -1, 'rawmaterials.usp_GetRawMaterialById');

        IF (@pDebug = 1)
        PRINT CONCAT_WS(' ','@pId =', @vId);
    END TRY
    BEGIN CATCH
        EXECUTE core.usp_ErrorLogger;
        IF (@@NESTLEVEL = 1)
            RETURN -1;
        ELSE
            THROW;
    END CATCH

    SELECT
          Id       , Name     , UNSPSC
        , CreatedAt, UpdatedAt, IsEnabled
    FROM rawmaterials.RawMaterials
    WHERE Id = @vId;

    RETURN 0;
END
GO