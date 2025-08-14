
CREATE PROCEDURE [test].[SP_Mark_DeletedTables]
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Ustaw is_deleted = 1 dla wierszy które nie istnieją w tabeli głównej
    UPDATE [test].[restore_insert_statements]
    SET is_deleted = 1,
        updated_date = GETDATE()
    WHERE NOT EXISTS (
        SELECT 1 
        FROM [test].[skrypt_adf] main
        WHERE main.src_schema = [test].[restore_insert_statements].src_schema
          AND main.src_table = [test].[restore_insert_statements].src_table
          AND main.sink_schema = [test].[restore_insert_statements].sink_schema
          AND main.sink_table = [test].[restore_insert_statements].sink_table
    )
    
    -- Ustaw is_deleted = 0 dla wierszy które istnieją w tabeli głównej
    UPDATE [test].[restore_insert_statements]
    SET is_deleted = 0,
        updated_date = GETDATE()
    WHERE EXISTS (
        SELECT 1 
        FROM [test].[skrypt_adf] main
        WHERE main.src_schema = [test].[restore_insert_statements].src_schema
          AND main.src_table = [test].[restore_insert_statements].src_table
          AND main.sink_schema = [test].[restore_insert_statements].sink_schema
          AND main.sink_table = [test].[restore_insert_statements].sink_table
    )
END
GO

