IF(OBJECT_ID(N'TestRawMaterials.[Test retrieve raw material by its Id using usp_GetRawMaterialById]', N'P') IS NULL)
EXECUTE('CREATE PROCEDURE TestRawMaterials.[Test retrieve raw material by its Id using usp_GetRawMaterialById] AS SELECT 1');
GO


ALTER PROCEDURE TestRawMaterials.[Test retrieve raw material by its Id using usp_GetRawMaterialById]
/*
<documentation>
    <object
        type="P" schema="TestRawMaterials"
        name="Test retrieve raw material by its Id using usp_GetRawMaterialById" />
    <summary>
        Test usp_GetRawMaterialById procedure for retrieve raw material by its Id.
    </summary>
    <author>Jheison J. Mayta C.</author>
    <createdAt>2025-03-01</createdAt>
    <sourceLink></sourceLink>
    <example>
        EXECUTE tSQLt.Run 'TestRawMaterials.Test retrieve raw material by its Id using usp_GetRawMaterialById';
    </example>
</documentation>
*/
AS
SET NOCOUNT ON;
BEGIN
    -- // ARRANGE ->
    DECLARE @vRawMaterialId int = 0;

    CREATE TABLE #Actual(
          Id int
        , Name nvarchar(255)
        , UNSPSC char(11)
        , CreatedAt datetimeoffset
        , UpdatedAt datetimeoffset
        , IsEnabled bit
    )

    CREATE TABLE #Expected(
          Id int
        , Name nvarchar(255)
        , UNSPSC char(11)
        , CreatedAt datetimeoffset
        , UpdatedAt datetimeoffset
        , IsEnabled bit
    )

    -- fill operations
    EXECUTE tSQLt.FakeTable
          @TableName = N'RawMaterials'
        , @SchemaName = N'rawmaterials'
        , @Identity = 1
    -- insert data for the test
    INSERT INTO rawmaterials.RawMaterials(
          Name
        , UNSPSC
        , CreatedAt
        , UpdatedAt
        , IsEnabled
    )
    VALUES
    (
          'maicena'
        , ''
        , SYSDATETIMEOFFSET() AT TIME ZONE 'UTC'
        , SYSDATETIMEOFFSET() AT TIME ZONE 'UTC'
        , 1
    );
    -- get last id inserted
    SET @vRawMaterialId = SCOPE_IDENTITY();
    -- populate table with recently added record
    INSERT INTO #Expected
    SELECT TOP (1)
        Id, Name, UNSPSC, CreatedAt, UpdatedAt, IsEnabled
    FROM rawmaterials.RawMaterials
    WHERE Id = @vRawMaterialId;
    -- <- ARRANGE //


    -- // ACT ->
    INSERT INTO #Actual(
        Id, Name, UNSPSC, CreatedAt, UpdatedAt, IsEnabled)
    EXECUTE rawmaterials.usp_GetRawMaterialById
        @pId = @vRawMaterialId
    -- <- ACT //


    -- // ASSERT ->
    EXEC tSQLt.AssertEqualsTable
          @Expected = N'#Expected'
        , @Actual = N'#Actual'
    -- <- ASSERT //
END