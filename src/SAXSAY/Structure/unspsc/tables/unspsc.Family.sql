CREATE TABLE unspsc.Family (
      Id                char(10)        NOT NULL
    , VersionId         int             NULL
    , SegmentId         char(10)        NOT NULL
    , FamilyTitle       nvarchar(255)   NOT NULL
    , FamilyDefinition  nvarchar(max)   NULL
)
GO
-- // CONSTRAINTS ->
ALTER TABLE unspsc.Family
ADD CONSTRAINT PK_Family_Id PRIMARY KEY CLUSTERED (Id);
GO
ALTER TABLE unspsc.Family
ADD CONSTRAINT AK_Family_Id_FamilyTitle UNIQUE (Id, FamilyTitle);
GO
-- <- CONSTRAINTS //

-- // INDEXES ->
CREATE NONCLUSTERED INDEX IX_Family_FamilyTitle
    ON unspsc.Family (FamilyTitle) INCLUDE (SegmentId);
GO
-- <- INDEXES //

-- // EXTENDED PROPERTIES ->
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'UNSPSC Families table'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Family';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'Record identifier'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Family'
, @level2type = 'COLUMN'   , @level2name = N'Id';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'UNSPSC version that it belongs to'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Family'
, @level2type = 'COLUMN'   , @level2name = N'VersionId';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'Segment to which it belongs'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Family'
, @level2type = 'COLUMN'   , @level2name = N'SegmentId';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'Family title'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Family'
, @level2type = 'COLUMN'   , @level2name = N'FamilyTitle';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'Family definition'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Family'
, @level2type = 'COLUMN'   , @level2name = N'FamilyDefinition';
GO
-- <- EXTENDED PROPERTIES //
