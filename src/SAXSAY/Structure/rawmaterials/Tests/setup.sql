IF(SCHEMA_ID('TestRawMaterials') IS NULL)
EXECUTE tSQLt.NewTestClass 'TestRawMaterials';
GO
IF(OBJECT_ID(N'TestRawMaterials.SetUp') IS NULL)
EXECUTE('CREATE PROCEDURE TestRawMaterials.SetUp AS SELECT 1;')
GO


ALTER PROCEDURE TestRawMaterials.SetUp
/*
<documentation>
    <object type="P" schema="TestRawMaterials" name="SetUp" />
</documentation>
*/
AS
BEGIN
    EXECUTE tSQLt.FakeTable
          @TableName = N'RawMaterials'
        , @SchemaName = N'rawmaterials'
        , @Identity = 1;
END;
GO
