
CREATE PROCEDURE [test].[update_SP_GenerateIndividualInserts]
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @currentRowCount INT = 0
    
    BEGIN TRY
        -- Sprawdzenie czy tabela źródłowa istnieje
        IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[test].[skrypt_adf]') AND type in (N'U'))
        BEGIN
            RETURN
        END
        
        -- Pobranie aktualnej liczby wierszy
        SELECT @currentRowCount = COUNT(*) FROM [test].[skrypt_adf]
        
        -- WYCZYSZCZENIE TABELI BACKUP
        DELETE FROM [test].[restore_insert_statements]
        
        -- DODANIE WSZYSTKICH AKTUALNYCH WIERSZY
        INSERT INTO [test].[restore_insert_statements] (src_schema, src_table, sink_schema, sink_table, insert_statement)
        SELECT 
            src_schema,
            src_table,
            sink_schema,
            sink_table,
            'INSERT INTO [test].[skrypt_adf] ("src_db", "src_schema", "src_table", "sink_schema", "sink_table", "rt_ind", "LongLoadFlag") VALUES (' +
            '''' + REPLACE(src_db, '''', '''''') + ''', ' +
            '''' + REPLACE(src_schema, '''', '''''') + ''', ' +
            '''' + REPLACE(src_table, '''', '''''') + ''', ' +
            '''' + REPLACE(sink_schema, '''', '''''') + ''', ' +
            '''' + REPLACE(sink_table, '''', '''''') + ''', ' +
            CAST(rt_ind AS NVARCHAR(10)) + ', ' +
            CAST(LongLoadFlag AS NVARCHAR(10)) + ');' as insert_statement
        FROM [test].[skrypt_adf]
        
    END TRY
    BEGIN CATCH
        RETURN
    END CATCH
END
GO

