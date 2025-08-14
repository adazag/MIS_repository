CREATE PROCEDURE ada.update_migrating_table_test(@schema_name nvarchar(100), @table_name nvarchar(100))

AS
BEGIN

DECLARE @SQL nvarchar(MAX)
DECLARE @NewTableName nvarchar(100);
DECLARE @OldTableName nvarchar(100)

-- Tworzenie nazwy nowej tabeli
SET @NewTableName = @schema_name + '.' + 'new_' + @table_name
SET @OldTableName = @schema_name + '.' + 'old_' + @table_name 


--utworzenie nowych tabel 
SET @SQL = 'SELECT * INTO ' + @NewTableName + ' FROM ' + @schema_name + '.' + @table_name + ' WHERE 1=2'
EXEC sp_executesql @SQL 

END
GO

