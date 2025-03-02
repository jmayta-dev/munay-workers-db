IF OBJECT_ID(N'rawmaterials.usp_InsertRawMaterial', N'P') IS NULL
EXECUTE('CREATE PROCEDURE rawmaterials.usp_InsertRawMaterial AS SELECT 1');
GO


ALTER PROCEDURE rawmaterials.usp_InsertRawMaterial (
      @pName      nvarchar(255)
    , @pUnspsc    char(8)        = ''
    , @pCreatedAt datetimeoffset = NULL
    , @pUpdatedAt datetimeoffset = NULL
    , @pIsEnabled bit            = 1
    , @pDebug     bit            = 0
    , @pId        int OUTPUT
)
/*
<documentation>
    <object type="P" schema="rawmaterials" name="usp_InsertRawMaterial" />
    <summary>Insert Raw Material</summary>
    <returns></returns>
    <author>Jheison J. Mayta C.</author>
    <createdAt>2024-11-02</createdAt>
    <updatedAt></updatedAt>
    <sourceLink></sourceLink>
    <example>
        DECLARE @newRawMaterialId int;
        EXECUTE rawmaterials.usp_InsertRawMaterial
              @pName      = 'azúcar rubia'
            , @pUnspsc    = '50161509'
            , @pCreatedAt = '2025-02-17T22:38:23.1210970-05:00'
            , @pUpdatedAt = '2025-02-17T22:38:23.1210970-05:00'
            , @pIsEnabled = 1
            , @pDebug     = 0
            , @pId        = @newRawMaterialId OUTPUT
        PRINT @newRawMaterialId;
    </example>
</documentation>
*/
AS
SET NOCOUNT ON;
BEGIN
    DECLARE
          @vTimestamp datetimeoffset = SYSDATETIMEOFFSET() AT TIME ZONE 'UTC'
        , @vName      nvarchar(255)  = @pName
        , @vDebug     bit            = @pDebug;

    BEGIN TRY
        IF (TRIM(@vName) = '')
        RAISERROR(15600, -1, -1, 'rawmaterials.usp_InsertRawMaterial');
        IF (@vDebug = 1)
        PRINT CONCAT_WS(' ','@pName =', @vName);
    END TRY
    BEGIN CATCH
        EXECUTE core.usp_ErrorLogger;
        IF (@@NESTLEVEL = 1)
            RETURN -1;
        ELSE
            THROW;
    END CATCH

    DECLARE
          @vId        int            = 0
        , @vUnspsc    char(8)        = @pUnspsc
        , @vCreatedAt datetimeoffset = COALESCE(@pCreatedAt, @vTimestamp)
        , @vUpdatedAt datetimeoffset = COALESCE(@pUpdatedAt, @vTimestamp)
        , @vIsEnabled bit            = @pIsEnabled

    BEGIN TRY
        INSERT INTO rawmaterials.RawMaterials (
            Name, UNSPSC, CreatedAt, UpdatedAt, IsEnabled
        ) VALUES (
            @vName, @vUnspsc, @vCreatedAt, @vUpdatedAt, @vIsEnabled
        )
        SET @pId = SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        EXECUTE core.usp_ErrorLogger;
        IF (@@NESTLEVEL = 1)
            RETURN -1;
        ELSE
            THROW;
    END CATCH

    RETURN 0;
END
GO
