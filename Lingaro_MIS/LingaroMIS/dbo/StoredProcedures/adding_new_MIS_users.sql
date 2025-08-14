CREATE PROCEDURE [dbo].[adding_new_MIS_users] AS 

PRINT '***START OF PROCEDURE***'
-- Separating comment
PRINT '------------------ADM/CC----------------------'
-- Section for creating users (Partners, Executives, Directors, Managers, Associate Managers) from ADM/CC 

BEGIN
DECLARE @Email1 NVARCHAR(100)
 
DECLARE EmailCursor CURSOR FOR

SELECT email
FROM [data_mis_project].[org_emp]
WHERe 1=1
AND active_ind = 1 
AND position_name IN ('Partner', 'Executive', 'Director', 'Manager', 'Associate Manager') 
AND bu_name IN ('ADM', 'CC')
AND email NOT IN (SELECT name FROM sysusers WHERE islogin = 1 AND issqluser = 0)
AND (leaver_last_day_of_work > GETDATE() or leaver_last_day_of_work is null)
AND employment_date < GETDATE()
 

OPEN EmailCursor
FETCH NEXT FROM EmailCursor INTO @Email1
WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC('CREATE USER [' + @Email1 + '] FROM EXTERNAL PROVIDER')
	EXEC('ALTER ROLE [ADM_CC_management_data_read]  ADD MEMBER [' + @Email1 + '] ')
    PRINT 'Created user account for ' + @Email1
	PRINT 'User ' + @Email1 + ' has been added to the [ADM_CC_management_data_read] role'
    FETCH NEXT FROM EmailCursor INTO @Email1
END
 
CLOSE EmailCursor
DEALLOCATE EmailCursor
END

-- Separating comment
PRINT '------------------HR----------------------'
-- Section for creating users and adding them to the HR_data_read role

BEGIN
    DECLARE @Email2 NVARCHAR(100)

    DECLARE EmailCursor CURSOR FOR
    SELECT email
	FROM [data_mis_project].[org_emp]
    WHERE 1=1
	AND active_ind = 1 
    AND bu_name = 'HR'
    AND email NOT IN (SELECT name FROM sysusers WHERE islogin = 1 AND issqluser = 0)
	AND email NOT IN ('hubert.matczak@lingarogroup.com','iris.banez@lingarogroup.com','iris.aballe@lingarogroup.com')
	AND (leaver_last_day_of_work > GETDATE() or leaver_last_day_of_work is null)
	AND employment_date < GETDATE()
 
    OPEN EmailCursor
    FETCH NEXT FROM EmailCursor INTO @Email2
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC('CREATE USER [' + @Email2 + '] FROM EXTERNAL PROVIDER')
        EXEC('ALTER ROLE [HR_data_read]  ADD MEMBER [' + @Email2 + '] ')
        PRINT 'Created user account for ' + @Email2
        PRINT 'User ' + @Email2 + ' has been added to the [HR_data_read] role'
        FETCH NEXT FROM EmailCursor INTO @Email2
    END

    CLOSE EmailCursor
    DEALLOCATE EmailCursor
END


-- Separating comment
PRINT '------------------PRICING----------------------'
-- Section for creating users and adding them to the Pricing_data_read role

BEGIN
    DECLARE @Email4 NVARCHAR(100)

    DECLARE EmailCursor CURSOR FOR
	SELECT email 
	FROM [data_mis_project].[org_emp]
	WHERE 1=1 
	AND active_ind = 1 
	AND delivery_team_name  = 'Pricing & Business Insights'
    AND email NOT IN (SELECT name FROM sysusers WHERE islogin = 1 AND issqluser = 0)
	AND (leaver_last_day_of_work > GETDATE() or leaver_last_day_of_work is null)
	AND employment_date < GETDATE()
 
    OPEN EmailCursor
    FETCH NEXT FROM EmailCursor INTO @Email4
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC('CREATE USER [' + @Email4 + '] FROM EXTERNAL PROVIDER')
        EXEC('ALTER ROLE [Pricing_data_read]  ADD MEMBER [' + @Email4 + '] ')
        PRINT 'Created user account for ' + @Email4
        PRINT 'User ' + @Email4 + ' has been added to the [Pricing_data_read] role'
        FETCH NEXT FROM EmailCursor INTO @Email4
    END

    CLOSE EmailCursor
    DEALLOCATE EmailCursor
END

-- Separating comment
PRINT '------------------ACCOUNTING----------------------'
-- Section for creating users and adding them to the Accounting_data_read role

BEGIN
    DECLARE @Email5 NVARCHAR(100)

    DECLARE EmailCursor CURSOR FOR
	SELECT email 
	FROM [data_mis_project].[org_emp]
	WHERE 1=1 
	AND active_ind = 1 
	AND delivery_team_name  = 'Accounting 01'
    AND email NOT IN (SELECT name FROM sysusers WHERE islogin = 1 AND issqluser = 0)
	AND (leaver_last_day_of_work > GETDATE() or leaver_last_day_of_work is null)
	AND employment_date < GETDATE()
 
    OPEN EmailCursor
    FETCH NEXT FROM EmailCursor INTO @Email5
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC('CREATE USER [' + @Email5 + '] FROM EXTERNAL PROVIDER')
        EXEC('ALTER ROLE [Accounting_data_read]  ADD MEMBER [' + @Email5 + '] ')
        PRINT 'Created user account for ' + @Email5
        PRINT 'User ' + @Email5 + ' has been added to the [Accounting_data_read] role'
        FETCH NEXT FROM EmailCursor INTO @Email5
    END

    CLOSE EmailCursor
    DEALLOCATE EmailCursor
END

-- Separating comment
PRINT '------------------CONTROLING----------------------'
-- Section for creating users and adding them to the Controling_data_read role

BEGIN
    DECLARE @Email6 NVARCHAR(100)

    DECLARE EmailCursor CURSOR FOR
	SELECT email 
	FROM [data_mis_project].[org_emp] 
	WHERE 1=1 
	AND active_ind = 1 
	AND (delivery_team_name  = 'Financial Controling')
    AND email NOT IN (SELECT name FROM sysusers WHERE islogin = 1 AND issqluser = 0)
	AND (leaver_last_day_of_work > GETDATE() or leaver_last_day_of_work is null)
	AND employment_date < GETDATE()
     OPEN EmailCursor
    FETCH NEXT FROM EmailCursor INTO @Email6
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC('CREATE USER [' + @Email6 + '] FROM EXTERNAL PROVIDER')
        EXEC('ALTER ROLE [Controling_data_read]  ADD MEMBER [' + @Email6 + '] ')
        PRINT 'Created user account for ' + @Email6
        PRINT 'User ' + @Email6 + ' has been added to the [Controling_data_read] role'
        FETCH NEXT FROM EmailCursor INTO @Email6
    END

    CLOSE EmailCursor
    DEALLOCATE EmailCursor
END

-- Separating comment
PRINT '------------------RESOURCING----------------------'
-- Section for creating users and adding them to the Resourcing_data_read role

BEGIN
    DECLARE @Email7 NVARCHAR(100)

    DECLARE EmailCursor CURSOR FOR
	SELECT email 
	FROM [data_mis_project].[org_emp]
	WHERE 1=1 
	AND active_ind = 1 
	AND bu_name = 'Resourcing Function'
    AND email NOT IN (SELECT name FROM sysusers WHERE islogin = 1 AND issqluser = 0)
	AND (leaver_last_day_of_work > GETDATE() or leaver_last_day_of_work is null)
	AND employment_date < GETDATE()
 
    OPEN EmailCursor
    FETCH NEXT FROM EmailCursor INTO @Email7
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC('CREATE USER [' + @Email7 + '] FROM EXTERNAL PROVIDER')
        EXEC('ALTER ROLE [Resourcing_data_read]  ADD MEMBER [' + @Email7 + '] ')
        PRINT 'Created user account for ' + @Email7
        PRINT 'User ' + @Email7 + ' has been added to the [Resourcing_data_read] role'
        FETCH NEXT FROM EmailCursor INTO @Email7
    END

    CLOSE EmailCursor
    DEALLOCATE EmailCursor
END

-- Separating comment
PRINT '------------------IT & Security Department----------------------'
-- Section for creating users and adding them to the IT_data_read role

BEGIN
    DECLARE @Email8 NVARCHAR(100)

    DECLARE EmailCursor CURSOR FOR
	SELECT email 
	FROM [data_mis_project].[org_emp] 
	WHERE 1=1 
	AND active_ind = 1 
	AND sub_bu_name = 'IT & Security Department'
    AND email NOT IN (SELECT name FROM sysusers WHERE islogin = 1 AND issqluser = 0)
	AND (leaver_last_day_of_work > GETDATE() or leaver_last_day_of_work is null)
	AND employment_date < GETDATE()
 
    OPEN EmailCursor
    FETCH NEXT FROM EmailCursor INTO @Email8
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC('CREATE USER [' + @Email8 + '] FROM EXTERNAL PROVIDER')
        EXEC('ALTER ROLE [IT_data_read]  ADD MEMBER [' + @Email8 + '] ')
        PRINT 'Created user account for ' + @Email8
        PRINT 'User ' + @Email8 + ' has been added to the [IT_data_read] role'
        FETCH NEXT FROM EmailCursor INTO @Email8
    END

    CLOSE EmailCursor
    DEALLOCATE EmailCursor
END

PRINT '***END OF PROCEDURE***'
GO

GRANT EXECUTE
    ON OBJECT::[dbo].[adding_new_MIS_users] TO [lingaro-mis-adf]
    AS [dbo];
GO

