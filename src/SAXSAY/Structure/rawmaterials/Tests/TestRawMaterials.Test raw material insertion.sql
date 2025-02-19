IF OBJECT_ID(N'TestRawMaterials.Test raw material insertion', N'P') IS NULL
EXECUTE('CREATE PROCEDURE TestRawMaterials.[Test raw material insertion] AS SELECT 1');
GO


ALTER PROCEDURE TestRawMaterials.[Test raw material insertion]
/*
<documentation>
    <object type="P" schema="TestRawMaterials" name="Test raw material insertion" />
    <summary>Test inserting raw material through a stored procedure</summary>
    <author>Jheison J. Mayta C.</author>
    <createdAt>2025.02.18</createdAt>
    <sourceLink></sourceLink>
    <example>
        EXECUTE tSQLt.Run 'TestRawMaterials.Test raw material insertion';
    </example>
</documentation>
*/
AS
BEGIN
    -- // ARRANGE ->
    DECLARE
          @vNewRawMaterialId int = 0
        , @vExpectedRawMaterialId int
        , @vActualRawMaterialId int;

    SET @vExpectedRawMaterialId = 0;

    SELECT TOP (0) Name, UNSPSC, IsEnabled
    INTO #Actual
    FROM rawmaterials.RawMaterials

    SELECT TOP (0) Name, UNSPSC, IsEnabled
    INTO #Expected
    FROM rawmaterials.RawMaterials

    INSERT INTO #Expected(Name, UNSPSC, IsEnabled)
    VALUES ('azúcar rubia', '50161509', 1)
    -- <- ARRANGE //


    -- // ACT ->
    EXECUTE rawmaterials.usp_InsertRawMaterial
          @pName      = 'azúcar rubia'
        , @pUnspsc    = '50161509'
        , @pCreatedAt = '2025-02-19T00:03:23.1210970-05:00'
        , @pIsEnabled = 1
        , @pId = @vNewRawMaterialId OUTPUT

    -- get raw material id generated
    SET @vActualRawMaterialId = COALESCE(@vNewRawMaterialId, 0);

    -- get record inserted
    INSERT INTO #Actual
    (   Name, UNSPSC, IsEnabled )
    SELECT
        Name, UNSPSC, IsEnabled
    FROM rawmaterials.RawMaterials
    WHERE Id = @vNewRawMaterialId;
    -- <- ACT //


    -- // ASSERT ->
    EXECUTE tSQLt.AssertNotEquals
          @Expected = @vExpectedRawMaterialId
        , @Actual   = @vActualRawMaterialId;

    EXECUTE tSQLt.AssertEqualsTable
          @Expected = #Expected
        , @Actual   = #Actual
    -- <- ASSERT //
END;
GO