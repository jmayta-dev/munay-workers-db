IF(OBJECT_ID(N'TestRawMaterials.[Test retrieving raw material passing a non-existent Id to usp_GetRawMaterialById]', N'P') IS NULL)
EXECUTE('CREATE PROCEDURE TestRawMaterials.[Test retrieving raw material passing a non-existent Id to usp_GetRawMaterialById] AS SELECT 1');
GO


ALTER PROCEDURE TestRawMaterials.[Test retrieving raw material passing a non-existent Id to usp_GetRawMaterialById]
/*
<documentation>
    <object
        type="P" schema="TestRawMaterials"
        name="Test retrieving raw material passing a non-existent Id to usp_GetRawMaterialById" />
    <summary>
        Test usp_GetRawMaterialById procedure for retrieve raw material with non-existent Id.
    </summary>
    <author>Jheison J. Mayta C.</author>
    <createdAt>2025-03-01</createdAt>
    <sourceLink></sourceLink>
    <example>
        EXECUTE tSQLt.Run 'TestRawMaterials.Test retrieving raw material passing a non-existent Id to usp_GetRawMaterialById';
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

    EXECUTE tSQLt.FakeTable
          @TableName = N'RawMaterials'
        , @SchemaName = N'rawmaterials';
    -- clear table data
    TRUNCATE TABLE rawmaterials.RawMaterials;
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
    -- #Actual should be empty
    EXECUTE tSQLt.AssertEmptyTable
          @TableName = N'#Actual';
    -- #Actual and #Expected should be equals (I mean, both empty)
    EXECUTE tSQLt.AssertEqualsTable
          @Expected = N'#Expected'
        , @Actual = N'#Actual';
    -- <- ASSERT //
END