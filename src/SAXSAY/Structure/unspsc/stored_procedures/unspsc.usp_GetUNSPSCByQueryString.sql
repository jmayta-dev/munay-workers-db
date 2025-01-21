IF OBJECT_ID(N'unspsc.usp_GetUNSPSCByQueryString', N'P') IS NULL
    EXECUTE('CREATE PROCEDURE unspsc.usp_GetUNSPSCByQueryString as SELECT 1');
GO


ALTER PROCEDURE unspsc.usp_GetUNSPSCByQueryString(
      @queryString  nvarchar(255)
    , @debug        bit = 0
)
/*
<documentation>
    <object type="P" schema="unspsc" name="usp_GetUNSPSCByFilter" />
    <summary>Get UNSPSC item info by filter</summary>
    <returns>1 data set: </returns>
    <author>Jheison Mayta @jmayta-dev</author>
    <createdAt>2025.01.19</createdAt>
    <updates></updates>
    <sourceLink></sourceLink>
    <example1>
        EXECUTE unspsc.usp_GetUNSPSCByQueryString
              @queryString = 'ARROZ'
            , @debug = 0
    </example1>
</documentation>
*/
AS
SET NOCOUNT ON;
BEGIN
    BEGIN TRY
        IF(@queryString IS NULL)
        BEGIN
            RAISERROR('Not valid data parameter', 16, 1);
        END
        IF (@debug = 1) PRINT @queryString;
    END TRY
    BEGIN CATCH
        EXECUTE core.usp_ErrorLogger;
        RETURN -1;
    END CATCH

    CREATE TABLE #Result (
          Id            char(8)         NOT NULL
        , Title         nvarchar(255)   NOT NULL
        , SectionName   nvarchar(32)    NULL
        , IsSection     BIT             NOT NULL
    )

    -- // BUSCAR SEGMENTO ->
    INSERT INTO #Result (
          Id
        , Title
        , SectionName
        , IsSection)
    SELECT
          seg.Id
        , seg.SegmentTitle
        , 'Segment'
        , 1
    FROM unspsc.Segment seg
    WHERE seg.SegmentTitle LIKE CONCAT('%',@queryString,'%')
        OR Id LIKE CONCAT('%',@queryString,'%')
    -- <- BUSCAR SEGMENTO //
    UNION
    -- // BUSCAR FAMILIA ->
    SELECT
          fam.Id
        , fam.FamilyTitle
        , 'Family'
        , 1
    FROM unspsc.Family fam -- sp_help 'unspsc.Family'
    WHERE fam.FamilyTitle LIKE CONCAT('%',@queryString,'%')
        OR Id LIKE CONCAT('%',@queryString,'%')
    -- <- BUSCAR FAMILIA //
    UNION
    -- // BUSCAR CLASE ->
    SELECT
          cls.Id
        , cls.ClassTitle
        , 'Class'
        , 1
    FROM unspsc.Class cls
    WHERE cls.ClassTitle LIKE CONCAT('%',@queryString,'%')
        OR Id LIKE CONCAT('%',@queryString,'%')
    -- <- BUSCAR CLASE //
    UNION
    -- // BUSCAR PRODUCTO ->
    SELECT
          com.Id
        , com.CommodityTitle
        , NULL
        , 0
    FROM unspsc.Commodity com
    WHERE com.CommodityTitle LIKE CONCAT('%',@queryString,'%')
        OR Id LIKE CONCAT('%',@queryString,'%')
    -- <- BUSCAR PRODUCTO //

    IF(@@ROWCOUNT = 0) RETURN 0;

    CREATE NONCLUSTERED INDEX IX_Result_Id
        ON #Result(Id) INCLUDE (Title)

    -- //// CONSULTA FINAL ->
    SELECT 
        Id, Title, SectionName, IsSection = IIF(SectionName IS NULL, 0, 1)
    FROM #Result
    ORDER BY Id
    -- <- CONSULTA FINAL ////

    DROP TABLE IF EXISTS #Result;

    RETURN 0;
END
GO
