CREATE TABLE unspsc.Segment (
      Id            char(8)         NOT NULL
    , VersionId     int             NULL
    , SegmentTitle         nvarchar(255)   NOT NULL
    , SegmentDefinition    nvarchar(500)   NULL
)
GO
-- // CONSTRAINTS ->
ALTER TABLE unspsc.Segment
ADD CONSTRAINT PK_Segment_Id PRIMARY KEY CLUSTERED (Id);
GO
ALTER TABLE unspsc.Segment
ADD CONSTRAINT AK_Segment_SegmentTitle UNIQUE (SegmentTitle);
GO
-- <- CONSTRAINTS //

-- // EXTENDED PROPERTIES ->
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'UNSPSC Segments Table'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Segment';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'Segment Identifier'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Segment'
, @level2type = 'COLUMN'   , @level2name = N'Id';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'UNSPSC version that it belongs to'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Segment'
, @level2type = 'COLUMN'   , @level2name = N'VersionId';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'Segment title'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Segment'
, @level2type = 'COLUMN'   , @level2name = N'SegmentTitle';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'Segment definition'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Segment'
, @level2type = 'COLUMN'   , @level2name = N'SegmentDefinition';
GO
-- <- EXTENDED PROPERTIES //


