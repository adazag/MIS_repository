
create view data_out_ad.proj_emp_actuals as(
SELECT
--  [client_id]
-- ,[client_name]
       [project_id]
      ,[project_name]
      ,[employee_id]
      ,[employee_full_name]
      --,[day_date]
      ,[month_date]
	  ,CAST(LEFT(month_date, 4) as int) as year
	  ,CAST(RIGHT(month_date, 2) as int) as month 
      --,[timesheet_code_id]
      --,[timesheet_version_project_code_type]
      --,[timesheet_code_name]
      --,[timesheet_code]
      --,[multiplier]
      --,[ip_code]
      --,[minutes]
      --,[hours]
      ,sum([days]) as days
      --,[comment]
      --,[timeoff]
      --,[status] 
FROM [data_in].[tmsht_time_report_vw]
  where timeoff=0
  Group by [project_id]
      ,[project_name]
      ,[employee_id]
      ,[employee_full_name]
	  ,[month_date]
 having SUM(days) >0
 
 )
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[proj_emp_actuals] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[proj_emp_actuals] TO [data_out_ad_alter_all]
    AS [dbo];
GO

