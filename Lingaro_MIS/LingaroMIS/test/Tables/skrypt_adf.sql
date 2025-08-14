CREATE TABLE [test].[skrypt_adf] (
    [id]           INT            IDENTITY (1, 1) NOT NULL,
    [src_db]       NVARCHAR (50)  NOT NULL,
    [src_schema]   NVARCHAR (255) NOT NULL,
    [src_table]    NVARCHAR (255) NOT NULL,
    [sink_schema]  NVARCHAR (255) NOT NULL,
    [sink_table]   NVARCHAR (255) NOT NULL,
    [rt_ind]       INT            NOT NULL,
    [LongLoadFlag] BIT            NULL
);
GO

CREATE TRIGGER [test].[TR_AutoLogDeletedRows] ON [test].[skrypt_adf]  AFTER DELETE AS BEGIN   SET NOCOUNT ON;  DECLARE @DeletedRowsInfo NVARCHAR(MAX) = ''  BEGIN TRY                SELECT @DeletedRowsInfo = @DeletedRowsInfo +      'Deleted: ' + src_schema + '.' + src_table + ' - ' + sink_schema + '.' + sink_table + ' ' FROM deleted  IF @DeletedRowsInfo != '' BEGIN  EXEC [test].[SP_AutoLogDeletedRows] @DeletedRowsInfo = @DeletedRowsInfo   END  END TRY  BEGIN CATCH  END CATCH  END
GO


    CREATE TRIGGER [test].[TR_AutoGenerateIndividualInserts]
    ON [test].[skrypt_adf]
    AFTER INSERT, UPDATE
    AS
    BEGIN
        SET NOCOUNT ON;
        BEGIN TRY
            EXEC [test].[update_SP_GenerateIndividualInserts]
        END TRY
        BEGIN CATCH
        END CATCH
    END
GO


CREATE TRIGGER [test].[TR_AutoMarkDeletedTables]
ON [test].[skrypt_adf]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Uruchom procedurę aktualizującą flagi
        EXEC [test].[SP_Mark_DeletedTables]
    END TRY
    BEGIN CATCH
        -- W przypadku błędu, nie przerywamy głównej operacji
    END CATCH
END
GO

CREATE TRIGGER [test].[TR_LimitDelete10Rows]
ON [test].[skrypt_adf]
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @DeletedRowsCount INT
    DECLARE @ErrorMessage NVARCHAR(500)
    
    -- Policz ile wierszy zostało usuniętych
    SELECT @DeletedRowsCount = COUNT(*) FROM deleted
    
    -- Sprawdź czy liczba usuniętych wierszy przekracza limit
    IF @DeletedRowsCount > 10
    BEGIN
        -- Cofnij transakcję
        ROLLBACK TRANSACTION
        
        -- Wyświetl błąd
        SET @ErrorMessage ='ERROR: Cannot delete more than 10 rows at once!' + CHAR(13) + CHAR(10) +
                           'Attempted to delete: ' + CAST(@DeletedRowsCount AS NVARCHAR(10)) + ' rows' + CHAR(13) + CHAR(10) +
                           'Maximum limit: 10 rows per operation' + CHAR(13) + CHAR(10) +
                           'Please split the operation into smaller batches.'
        
        RAISERROR(@ErrorMessage, 16, 1)
        RETURN
    END
    
    -- Jeśli wszystko OK, wyświetl informację
    IF @DeletedRowsCount > 0
    BEGIN
        PRINT 'Successfully deleted ' + CAST(@DeletedRowsCount AS NVARCHAR(10)) + ' rows from table [test].[skrypt_adf]'
    END
END
GO

