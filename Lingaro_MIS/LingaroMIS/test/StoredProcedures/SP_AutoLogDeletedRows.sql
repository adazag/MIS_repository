
CREATE PROCEDURE [test].[SP_AutoLogDeletedRows]
    @DeletedRowsInfo NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @currentRowCount INT = 0
    
    BEGIN TRY
        -- Pobranie aktualnej liczby wierszy
        IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[test].[skrypt_adf]') AND type in (N'U'))
        BEGIN
            SELECT @currentRowCount = COUNT(*) FROM [test].[skrypt_adf]
        END
        
        -- DODANIE NOWEGO WPISU O USUNIĘCIU
        IF EXISTS (SELECT 1 FROM [test].[restore_system_status] WHERE system_name = 'skrypt_adf')
        BEGIN
            INSERT INTO [test].[restore_system_status] (
                system_name, current_rows, backup_rows, last_operation, 
                deleted_row_info, delete_date
            )
            VALUES (
                'skrypt_adf_delete_' + FORMAT(GETDATE(), 'yyyyMMdd_HHmmss'), 
                @currentRowCount, 
                (SELECT backup_rows FROM [test].[restore_system_status] WHERE system_name = 'skrypt_adf'), 
                'DELETE', 
                @DeletedRowsInfo, 
                GETDATE()
            )
            
            UPDATE [test].[restore_system_status] 
            SET current_rows = @currentRowCount,
                last_operation = 'DELETE'
            WHERE system_name = 'skrypt_adf'
        END
        ELSE
        BEGIN
            INSERT INTO [test].[restore_system_status] (
                system_name, current_rows, backup_rows, last_operation, 
                deleted_row_info, delete_date
            )
            VALUES (
                'skrypt_adf', @currentRowCount, 0, 'DELETE', 
                @DeletedRowsInfo, GETDATE()
            )
        END
        
    END TRY
    BEGIN CATCH
        RETURN
    END CATCH
END
GO

