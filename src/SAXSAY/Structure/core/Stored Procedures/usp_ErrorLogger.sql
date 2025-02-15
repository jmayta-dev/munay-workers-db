IF OBJECT_ID(N'core.usp_ErrorLogger', N'P') IS NULL
    EXECUTE('CREATE PROCEDURE core.usp_ErrorLogger as SELECT 1');
GO


ALTER PROCEDURE core.usp_ErrorLogger(
    @pUserName   nvarchar(128) = NULL
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
    
    DECLARE
          @userName nvarchar(128)
        , @errorId  bigint;

    -- ARRANGE
    SET @userName = IIF(COALESCE(@pUserName, '') = '', SUSER_SNAME(), @pUserName);

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
        , @userName     , GETUTCDATE()
    )
    -- <- ERROR INSERTION //

    -- // SHOW ERROR INFORMATION ->
    SET @errorId = COALESCE(@@IDENTITY, 0)

    SELECT
          Id       , ErrorNumber , ErrorSeverity , ErrorState
        , ErrorLine, ErrorMessage, ErrorProcedure, StackTrace
        , HostName , AppName     , UserName      , CreatedAt
    FROM core.ErrorLog
    WHERE Id = @errorId;
    -- <- SHOW ERROR INFORMATION //
END
GO