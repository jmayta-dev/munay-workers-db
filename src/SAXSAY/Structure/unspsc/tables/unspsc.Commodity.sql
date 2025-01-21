CREATE TABLE unspsc.Commodity (
      Id                  char(10)      NOT NULL
    , VersionId           int           NULL
    , ClassId             char(10)      NOT NULL
    , CommodityTitle      nvarchar(255) NOT NULL
    , CommodityDefinition nvarchar(max) NULL
)
GO

-- // CONSTRAINTS ->
ALTER TABLE unspsc.Commodity
ADD CONSTRAINT PK_Commodity_Id PRIMARY KEY CLUSTERED (Id);
GO
ALTER TABLE unspsc.Commodity
ADD CONSTRAINT AK_Commodity_Id_CommodityTitle UNIQUE (Id, CommodityTitle);
GO
-- <- CONSTRAINTS //

-- // INDEXES ->
CREATE NONCLUSTERED INDEX IX_Commodity_CommodityTitle
    ON unspsc.Commodity (CommodityTitle) INCLUDE (ClassId);
GO
-- <- INDEXES //
