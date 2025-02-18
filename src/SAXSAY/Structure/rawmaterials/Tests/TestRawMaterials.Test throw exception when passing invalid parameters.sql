IF OBJECT_ID(N'TestRawMaterials.Test throw exception when passing invalid parameters', N'P') IS NULL
EXECUTE('CREATE PROCEDURE TestRawMaterials.[Test throw exception when passing invalid parameters] AS SELECT 1');
GO


ALTER PROCEDURE TestRawMaterials.[Test throw exception when passing invalid parameters]
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