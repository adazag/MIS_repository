CREATE PROCEDURE ada.update_delete_table_test(@schema_name nvarchar(100), @table_name nvarchar(100))

AS
BEGIN

DECLARE @SQL nvarchar(MAX)
DECLARE @NewTableName nvarchar(100);
DECLARE @OldTableName nvarchar(100)

SET @NewTableName = @schema_name + '.' + 'new_' + @table_name
SET @OldTableName = @schema_name + '.' + 'old_' + @table_name 

-- zmiana nazwy oryginalnej tabeli NA NAZWE Z dopiskiem old
SET @SQL = 'EXEC sp_rename ''' + @schema_name + '.' + @table_name + ''', '''  + 'old_' + @table_name + '''';
EXEC sp_executesql @SQL

--Zmiana nazwy nowych tabel, usuniecie dopisku new
SET @SQL = 'EXEC sp_rename ''' + @NewTableName + ''', ''' + @table_name + '''';
EXEC sp_executesql @SQL

-- usuniecie tabel z dopiskiem old
SET @SQL = 'DROP TABLE ' + @OldTableName 
EXEC sp_executesql @SQL

END
GO

