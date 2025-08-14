CREATE PROCEDURE [dbo].[removing_inactive_users] AS
DECLARE @Email NVARCHAR(100)

DECLARE EmailCursor CURSOR FOR

SELECT name FROM sysusers
WHERE name IN (
    SELECT email
    FROM [data_in].[org_emp]
    WHERE (1=1
	and id > 0
	and active_ind = 0)
	or leaver_last_day_of_work < GETDATE()
)
AND islogin = 1 AND issqluser = 0

OPEN EmailCursor
FETCH NEXT FROM EmailCursor INTO @Email
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('DROP USER [' + @Email + ']')
    PRINT 'Removed ' + @Email + ' from the database'
    FETCH NEXT FROM EmailCursor INTO @Email
END

CLOSE EmailCursor
DEALLOCATE EmailCursor
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[removing_inactive_users] TO [lingaro-mis-adf]
    AS [dbo];
GO

