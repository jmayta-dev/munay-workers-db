CREATE TABLE unspsc.Version (
      Id            int IDENTITY(1,1)   NOT NULL
    , Description   varchar(20)         NOT NULL
    , IsLatest      bit                 NOT NULL
) ON [PRIMARY]
GO

-- // H3 SECTION COMMENT ->
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'UNSPSC Loaded Versions Table'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Version';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'Identifier number'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Version'
, @level2type = 'COLUMN'   , @level2name = N'Id';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'Version description'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Version'
, @level2type = 'COLUMN'   , @level2name = N'Description';
GO
EXEC sp_addextendedproperty
  @name = N'MS_Description'
, @value = 'Indicator for latest loaded version | 1:yes | 0:no'
, @level0type = 'SCHEMA'   , @level0name = N'unspsc'
, @level1type = 'TABLE'    , @level1name = N'Version'
, @level2type = 'COLUMN'   , @level2name = N'IsLatest';
GO
-- <- H3 SECTION COMMENT //