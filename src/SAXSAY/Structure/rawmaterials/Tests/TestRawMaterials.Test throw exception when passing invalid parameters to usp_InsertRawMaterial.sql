IF OBJECT_ID(N'TestRawMaterials.[Test throw exception when passing invalid parameters to usp_InsertRawMaterial]', N'P') IS NULL
EXECUTE('CREATE PROCEDURE TestRawMaterials.[Test throw exception when passing invalid parameters to usp_InsertRawMaterial] AS SELECT 1');
GO


ALTER PROCEDURE TestRawMaterials.[Test throw exception when passing invalid parameters to usp_InsertRawMaterial]
/*
<documentation>
    <object
        type="P" schema="TestRawMaterials"
        name="Test throw exception when passing invalid parameters to usp_InsertRawMaterial" />
    <summary>
        Test throwing exception when pass an invalid parameter to rawmaterials.usp_InsertRawMaterial
    </summary>
    <author>Jheison J. Mayta C.</author>
    <createdAt>2025.02.18</createdAt>
    <sourceLink></sourceLink>
    <example>
        EXECUTE tSQLt.Run 'TestRawMaterials.Test throw exception when passing invalid parameters to usp_InsertRawMaterial';
    </example>
</documentation>
*/
AS
BEGIN
    -- // ARRANGE ->
    DECLARE
          @vMessageError nvarchar(2048)
        , @vMessageId int = 15600
        , @vNewRawMaterialid int

    SET @vMessageError = FORMATMESSAGE(@vMessageId, 'rawmaterials.usp_InsertRawMaterial')
    -- <- ARRANGE //

    -- // ACT ->
    EXECUTE tSQLt.ExpectException
        @ExpectedMessage = @vMessageError;
    -- <- ACT //
    
    -- // ASSERT ->
    EXECUTE rawmaterials.usp_InsertRawMaterial 
          @pName = ''
        , @pId = @vNewRawMaterialid OUTPUT
    -- <- ASSERT //
END;
GO