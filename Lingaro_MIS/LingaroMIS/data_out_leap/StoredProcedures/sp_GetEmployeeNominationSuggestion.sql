

-- =============================================
-- Author:        Alex Sen
-- Create date:   2024-09-02
-- Description:   Stored Procedure version of fn_GetEmployeeNominationSuggestion
-- =============================================

CREATE PROCEDURE [data_out_leap].[sp_GetEmployeeNominationSuggestion]
(
    @EmployeeId INT,
    @ProjectReportingStartFrom DATE
)
AS
BEGIN
    -- Declare a temporary table to hold intermediate results
    DECLARE @TempTable TABLE
    (
        EmployeeId BIGINT,
        ProjectId BIGINT,
        Actuals_Hours DECIMAL(38, 5),
        Actuals_Days DECIMAL(38, 5)
    );

    -- Insert data into the temporary table
    INSERT INTO @TempTable
    SELECT 
        t1.[EmployeeId], 
        t1.[ProjectId], 
        SUM(t1.[Actuals_Hours]) AS [Actuals_Hours], 
        SUM(t1.[Actuals_Days]) AS [Actuals_Days]
    FROM 
    (
        SELECT 
            timesheets.[employee_id] AS [EmployeeId], 
            timesheets.[project_id] AS [ProjectId], 
            timesheets.[days] * 24 AS [Actuals_Hours], 
            timesheets.[days] AS [Actuals_Days]
        FROM 
            [data_out_ad].[proj_emp_actuals] timesheets
        WHERE 
            [project_id] > 7 
            AND [employee_id] = @EmployeeId 
            AND EOMONTH(DATEFROMPARTS([year], [month], 1)) >= @ProjectReportingStartFrom
    ) t1
    GROUP BY  
        t1.[EmployeeId],
        t1.[ProjectId];

    -- Declare another temporary table to hold the final result set
    DECLARE @ResultTable TABLE
    (
        [EmployeeId] BIGINT,
        [ProjectId] BIGINT,
        [Actuals_Hours] DECIMAL(38, 5),
        [Actuals_Days] DECIMAL(38, 5),
        [PMDL_EmployeeId] BIGINT,
        [Role] NVARCHAR(50),
        [ProjectName] NVARCHAR(500)
    );

    -- Insert PM data into the result table
    INSERT INTO @ResultTable
    SELECT 
        t.EmployeeId,
        t.ProjectId,
        t.Actuals_Hours,
        t.Actuals_Days,
        [PM_EmployeeId] AS [PMDL_EmployeeId],
        'PM' AS [Role],
        [ProjectName]
    FROM 
        @TempTable t 
    INNER JOIN 
        [data_out_ad].[v_Projects] projectsData 
    ON 
        t.ProjectId = projectsData.ProjectId;

    -- Insert DL data into the result table
    INSERT INTO @ResultTable
    SELECT 
        t.EmployeeId,
        t.ProjectId,
        t.Actuals_Hours,
        t.Actuals_Days,
        [DL_EmployeeId] AS [PMDL_EmployeeId],
        'DL' AS [Role],
        [ProjectName]
    FROM 
        @TempTable t 
    INNER JOIN 
        [data_out_ad].[v_Projects] projectsData 
    ON 
        t.ProjectId = projectsData.ProjectId;

    -- Return the final result set
    SELECT 
        [EmployeeId], 
        [ProjectId], 
        [Actuals_Hours], 
        [Actuals_Days], 
        [PMDL_EmployeeId], 
        [Role], 
        [ProjectName]
    FROM 
        @ResultTable;

END
GO

GRANT EXECUTE
    ON OBJECT::[data_out_leap].[sp_GetEmployeeNominationSuggestion] TO [LEAP@lingaro.onmicrosoft.com]
    AS [dbo];
GO

