IF OBJECT_ID(N'TestRawMaterials.[Test schema exists]', N'P') IS NULL
EXECUTE('CREATE PROCEDURE TestRawMaterials.[Test schema exists] AS SELECT 1');
GO


ALTER PROCEDURE TestRawMaterials.[Test schema exists]
/*
<documentation>
    <object
        type="P" schema="TestRawMaterials"
        name="Test schema exists" />
    <summary>
        Test schema 'rawmaterials' exists
    </summary>
    <author>Jheison J. Mayta C.</author>
    <createdAt>2025-03-01</createdAt>
    <sourceLink></sourceLink>
    <example>
        EXECUTE tSQLt.Run 'TestRawMaterials.Test schema exists';
    </example>
</documentation>
*/
AS
BEGIN
    -- // ARRANGE ->
    DECLARE @vSchemaName sysname = 'rawmaterials';

    CREATE TABLE #Actual (schema_name sysname);
    CREATE TABLE #Expected (schema_name sysname);

    -- fill Expected
    INSERT INTO #Expected(schema_name)
    VALUES(@vSchemaName);
    -- <- ARRANGE //


    -- // ACT ->
    INSERT INTO #Actual(schema_name)
    SELECT name FROM sys.schemas
    WHERE name = @vSchemaName
    -- <- ACT //


    -- // ASSERT ->
    EXECUTE tSQLt.AssertEqualsTable
         @Expected = N'#Expected'
        ,@Actual = N'#Actual';
    -- <- ASSERT //
END
GO