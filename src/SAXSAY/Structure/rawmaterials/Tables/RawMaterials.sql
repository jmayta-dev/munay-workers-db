/*
<documentation>
    <object type="U" schema="rawmaterials" name="RawMaterials" />
    <summary>Table for store Raw Materials</summary>
    <author>Jheison J. Mayta C.</author>
    <createdAt>2024.10.27</createdAt>
    <sourceLink></sourceLink>
</documentation>
*/
CREATE TABLE rawmaterials.RawMaterials (
      Id                int IDENTITY(1,1)   NOT NULL
    , Name              nvarchar(255)       NOT NULL
    , UNSPSC            char(11)            NULL
    , CreatedAt         datetimeoffset      NULL
    , UpdatedAt         datetimeoffset      NULL
    , IsEnabled         bit                 NOT NULL
) ON [PRIMARY]
GO
-- // CONSTRAINTS ->
ALTER TABLE rawmaterials.RawMaterials
    ADD CONSTRAINT PK_RawMaterials_Id
        PRIMARY KEY CLUSTERED(Id);
GO
ALTER TABLE rawmaterials.RawMaterials
    ADD CONSTRAINT DF_RawMaterials_CreatedAt
        DEFAULT SYSDATETIMEOFFSET() AT TIME ZONE 'UTC'
            FOR CreatedAt;
GO
-- <- CONSTRAINTS //
-- // INDEXES ->
CREATE NONCLUSTERED INDEX IXC_RawMaterials_Name
    ON rawmaterials.RawMaterials (Name)
        INCLUDE (UNSPSC, CreatedAt, UpdatedAt, IsEnabled);
GO
CREATE NONCLUSTERED INDEX IX_RawMaterials_UNSPSC
    ON rawmaterials.RawMaterials (UNSPSC)
        INCLUDE (Name, CreatedAt, UpdatedAt, IsEnabled);
GO
-- <- INDEXES //
-- // EXTENDER PROPERTIES ->
EXEC sp_addextendedproperty
  @name         = N'MS_Description'
, @value        = 'Raw Materials Table'
, @level0type   = 'SCHEMA'      , @level0name   = N'rawmaterials'
, @level1type   = 'TABLE'       , @level1name   = N'RawMaterials'
GO
EXEC sp_addextendedproperty
  @name         = N'MS_Description'
, @value        = 'Table identifier (PK)'
, @level0type   = 'SCHEMA'      , @level0name   = N'rawmaterials'
, @level1type   = 'TABLE'       , @level1name   = N'RawMaterials'
, @level2type   = 'COLUMN'      , @level2name   = N'Id';
GO
EXEC sp_addextendedproperty
  @name         = N'MS_Description'
, @value        = 'Raw material description'
, @level0type   = 'SCHEMA'      , @level0name   = N'rawmaterials'
, @level1type   = 'TABLE'       , @level1name   = N'RawMaterials'
, @level2type   = 'COLUMN'      , @level2name   = N'Name';
GO
EXEC sp_addextendedproperty
  @name         = N'MS_Description'
, @value        = 'Standard code of ''United Nations Standard Products and Services Codes'''
, @level0type   = 'SCHEMA'      , @level0name   = N'rawmaterials'
, @level1type   = 'TABLE'       , @level1name   = N'RawMaterials'
, @level2type   = 'COLUMN'      , @level2name   = N'UNSPSC';
GO
EXEC sp_addextendedproperty
  @name         = N'MS_Description'
, @value        = 'Registration date and time (contains time zone information)'
, @level0type   = 'SCHEMA'      , @level0name   = N'rawmaterials'
, @level1type   = 'TABLE'       , @level1name   = N'RawMaterials'
, @level2type   = 'COLUMN'      , @level2name   = N'CreatedAt';
GO
EXEC sp_addextendedproperty
  @name         = N'MS_Description'
, @value        = 'Last update date and time (includes time zone information)'
, @level0type   = 'SCHEMA'      , @level0name   = N'rawmaterials'
, @level1type   = 'TABLE'       , @level1name   = N'RawMaterials'
, @level2type   = 'COLUMN'      , @level2name   = N'UpdatedAt';
GO
EXEC sp_addextendedproperty
  @name         = N'MS_Description'
, @value        = 'Enable indicator. Determines if the record is enabled or disabled.'
, @level0type   = 'SCHEMA'      , @level0name   = N'rawmaterials'
, @level1type   = 'TABLE'       , @level1name   = N'RawMaterials'
, @level2type   = 'COLUMN'      , @level2name   = N'IsEnabled';
GO
-- <- EXTENDER PROPERTIES //
