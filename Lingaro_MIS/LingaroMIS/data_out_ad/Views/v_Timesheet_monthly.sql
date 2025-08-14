








CREATE VIEW [data_out_ad].[v_Timesheet_monthly]
AS
SELECT [project_id] as [ProjectId]
      ,[employee_id] as [EmployeeId]
      ,[year] as [Reporting_Year]
      ,[month] as [Reporting_Month]
	  ,[month_date] as [Reporting_Period]
	  ,EOMONTH(DATEFROMPARTS([year],[month], 1)) as [Reporting_Period_EOM]
      ,[days] as [Actuals_Days]
	  ,[days] * 24 as [Actuals_Hours]
	  ,cast([days] * 24 * 60 as int) as [Actuals_Minutes]
FROM [data_out_ad].[proj_emp_actuals]
WHERE [project_id] > 7
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Timesheet_monthly] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Timesheet_monthly] TO [data_out_ad_alter_all]
    AS [dbo];
GO

