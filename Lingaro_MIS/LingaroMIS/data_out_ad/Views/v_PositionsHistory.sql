
CREATE VIEW [data_out_ad].[v_PositionsHistory] AS

-- ===============================================
-- View:       v_PositionsHistory
-- Purpose:    Provides a history of employee positions with context about
--             past, current, and future roles, and key employee info.
-- Notes:      Optimized to compute GETDATE() once and improve readability.
-- ===============================================

-- Common table expression to get the current date once
WITH currDate AS (
    SELECT GETDATE() AS NowDate, CAST(GETDATE() AS DATE) AS Today
)

SELECT
    final.ChangeId,
    final.EmployeeId,
    final.EntraId,
    final.Email,
    final.FullName,
    final.FirstName,
    final.RoleName,
    final.PositionId,
    final.PositionName,
    final.PreviousPositionId,
    final.PreviousPositionName,
    final.LineManagerId,
    final.IsJoiner,
    final.IsLeaver,
    final.EventDate,
    DATEDIFF(DAY, currDate.NowDate, final.EventDate) AS EventDateDaysSpan

FROM currDate

CROSS APPLY (
    SELECT
        enriched.ChangeId,
        enriched.EmployeeId,
        emp.AzADObjectId                      AS EntraId,
        emp.Email                             AS Email,
        emp.FullName                          AS FullName,
        emp.FirstName                         AS FirstName,
        ISNULL(emp.RoleName, emp.RoleInternal) AS RoleName,
        enriched.PositionId,
        enriched.PositionName,
        enriched.PreviousPositionId,
        enriched.PreviousPositionName,
        emp.LineManagerId                     AS LineManagerId,
        emp.IsJoiner                          AS IsJoiner,
        emp.IsLeaver                          AS IsLeaver,

        -- Determine relevant event date: JoinDate, LeaveDate or Position StartDate
        IIF(emp.IsJoiner = 1, emp.JoinDate,
			IIF(emp.IsLeaver = 1 AND enriched.RowNum = 1, emp.LeaveDate, enriched.StartDate)
		) AS EventDate

    FROM (
        -- Enrich history records with position names
        SELECT
            hist.ChangeId,
            hist.EmployeeId,
            hist.PositionId,
            posCurrent.Name                    AS PositionName,
            hist.PreviousPositionId,
            posPrevious.Name                   AS PreviousPositionName,
            hist.StartDate,
            hist.EndDate,
			hist.RowNum,
            hist.IsPast,
            hist.IsCurrent,
            hist.IsFuture

        FROM (
            -- Base history: get previous position using LAG window function
            SELECT 
				ph.[id]                         AS ChangeId,
				ph.[employee_id]               AS EmployeeId,
				ph.[position_id]               AS PositionId,
				LAG(ph.[position_id]) OVER (PARTITION BY ph.[employee_id] ORDER BY ph.[start_date]) AS PreviousPositionId,
				ph.[start_date]                AS StartDate,
				ph.[end_date]                  AS EndDate,

				ROW_NUMBER() OVER (PARTITION BY ph.[employee_id] ORDER BY ph.[start_date] DESC) AS RowNum,

				-- Classify historical periods
				IIF(ph.[start_date] < cd.Today AND ph.[end_date] < cd.Today, 1, 0) AS IsPast,
				IIF(ph.[start_date] <= cd.Today AND ph.[end_date] IS NULL, 1, 0)   AS IsCurrent,
				IIF(ph.[start_date] > cd.Today, 1, 0)                              AS IsFuture

            FROM [data_out_ad].[dic_positions_history] ph
            CROSS JOIN currDate cd
            WHERE ph.[employee_id] > 0

        ) hist
        LEFT JOIN [data_out_ad].[v_Positions] posCurrent
            ON hist.PositionId = posCurrent.Id
        LEFT JOIN [data_out_ad].[v_Positions] posPrevious
            ON hist.PreviousPositionId = posPrevious.Id

    ) enriched
    LEFT JOIN [data_out_ad].[v_Az_Employees] emp
        ON enriched.EmployeeId = emp.EmployeeId


) final
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_PositionsHistory] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_PositionsHistory] TO [data_out_ad_read_all]
    AS [dbo];
GO

