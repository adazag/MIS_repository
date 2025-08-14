CREATE TRIGGER [TR_PreventTableDrop_Test_SkryptADF]
ON DATABASE
FOR DROP_TABLE
AS
BEGIN
    DECLARE @tableName NVARCHAR(256)
    DECLARE @schemaName NVARCHAR(256)
    DECLARE @eventData XML
    
    SET @eventData = EVENTDATA()
    
    SELECT 
        @tableName = @eventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(256)'),
        @schemaName = @eventData.value('(/EVENT_INSTANCE/SchemaName)[1]', 'NVARCHAR(256)')
    
    -- Blokuj usuwanie tylko tabeli [test].[skrypt_adf]
    IF @tableName = 'skrypt_adf' AND @schemaName = 'test'
    BEGIN
        ROLLBACK
        RAISERROR('ERROR: Deleting table [test].[skrypt_adf] is blocked by the security system!', 16, 1)
        RETURN
    END
END
GO

