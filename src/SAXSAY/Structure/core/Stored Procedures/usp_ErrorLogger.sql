IF OBJECT_ID(N'core.usp_ErrorLogger', N'P') IS NULL
    EXECUTE('CREATE PROCEDURE core.usp_ErrorLogger as SELECT 1');
GO


ALTER PROCEDURE core.usp_ErrorLogger(
      @pUserName          nvarchar(128) = NULL
    , @pShowMessageReport bit           = 0
    , @pShowTableReport   bit           = 0
)
/*
<documentation>
    <object type="P" schema="core" name="usp_ErrorLogger" />
    <summary>
        Alters how the error is displayed and stores its information in the
        error log table.
    </summary>
    <returns>1 data set: </returns>
    <author>Jheison J. Mayta C.</author>
    <createdAt>2024.10.26</createdAt>
    <updates></updates>
    <sourceLink></sourceLink>
    <example>
        -- ... more code above
        END TRY
        BEGIN CATCH
            EXEC core.usp_ErrorLogger;
        END CATCH
        -- and more code below ...
    </example>
</documentation>
*/
AS
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN
    -- IF NO ERROR, RETURN
    IF(ERROR_NUMBER() IS NULL) RETURN;

    -- // ARRANGE ->
    DECLARE
          @vUserName nvarchar(128)
        , @vShowMessageReport bit = @pShowMessageReport
        , @vShowTableReport bit   = @pShowTableReport
        , @vErrorId  bigint;

    SET @vUserName = IIF(COALESCE(@pUserName, '') = '', SUSER_SNAME(), @pUserName);
    -- <- ARRANGE //

    -- // ERROR INSERTION ->
    INSERT INTO core.ErrorLog (
          ErrorNumber, ErrorSeverity, ErrorState
        , ErrorLine  , ErrorMessage , ErrorProcedure
        , StackTrace , HostName     , AppName
        , UserName   , CreatedAt
    ) VALUES (
          ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE()
        , ERROR_LINE()  , ERROR_MESSAGE() , COALESCE(ERROR_PROCEDURE(), 'Not within procedure')
        , ''            , HOST_NAME()     , APP_NAME()
        , @vUserName    , GETUTCDATE()
    )
    -- <- ERROR INSERTION //

    -- // SHOW ERROR INFORMATION ->
    SET @vErrorId = COALESCE(SCOPE_IDENTITY(), 0)
    IF(@vShowTableReport = 1)
    BEGIN
        SELECT
              Id       , ErrorNumber , ErrorSeverity , ErrorState
            , ErrorLine, ErrorMessage, ErrorProcedure, StackTrace
            , HostName , AppName     , UserName      , CreatedAt
        FROM core.ErrorLog
        WHERE Id = @vErrorId;
    END

    IF(@vShowMessageReport = 1)
    BEGIN
        PRINT CONCAT_WS(' | ',ERROR_MESSAGE(),GETUTCDATE());
    END
    -- <- SHOW ERROR INFORMATION //
END
GO