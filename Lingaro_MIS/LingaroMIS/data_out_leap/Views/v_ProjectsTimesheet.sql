

CREATE VIEW [data_out_leap].[v_ProjectsTimesheet] as

SELECT
	 t2.[EmployeeId]
	,t2.[ProjectId]
	,t2.[Actuals_Hours]
	,t2.[Actuals_Days]
	,projectsData.PM_EmployeeId
	,projectsData.DL_EmployeeId
	,projectsData.ProjectName
FROM (
	SELECT
		 t1.[EmployeeId]
		,t1.[ProjectId]
		,SUM(t1.[Actuals_Hours]) as [Actuals_Hours]
		,SUM(t1.[Actuals_Days]) as [Actuals_Days]
	FROM
	(
		SELECT 
			 [EmployeeId]
			,[ProjectId]
			,[Reporting_Period_EOM]
			,[Actuals_Hours]
			,[Actuals_Days]
		FROM [data_out_ad].[v_Timesheet_monthly]
		WHERE Reporting_Period_EOM >= CONVERT(datetime,'2024-04-01')
	) t1

	Group BY  
		 t1.[EmployeeId]
		,t1.[ProjectId]
) t2 inner join [data_out_ad].[v_Projects] projectsData on
	t2.ProjectId = projectsData.ProjectId
GO

