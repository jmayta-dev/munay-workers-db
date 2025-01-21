CREATE TABLE unspsc.Class (
      Id              char(10)      NOT NULL
    , VersionId       int           NULL
    , FamilyId        char(10)      NOT NULL
    , ClassTitle      nvarchar(255) NOT NULL
    , ClassDefinition nvarchar(500) NULL
)
GO
-- // CONSTRAINTS ->
ALTER TABLE unspsc.Class
ADD CONSTRAINT PK_Class_Id PRIMARY KEY CLUSTERED (Id);
GO
ALTER TABLE unspsc.Class
ADD CONSTRAINT AK_Class_Id_ClassTitle UNIQUE (Id, VersionId, ClassTitle);
GO
-- <- CONSTRAINTS //

-- // INDEXES ->
CREATE NONCLUSTERED INDEX IX_Class_ClassTitle
    ON unspsc.Class (ClassTitle) INCLUDE (FamilyId);
GO
-- <- INDEXES //
