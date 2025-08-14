
CREATE view [data_mis_project].[tmsht_time_report_vw] as (
select [client_id]
      ,[client_name]
      ,[project_id]
      ,[project_name]
      ,[employee_id]
      ,[employee_full_name]
      ,[day_date]
      ,[month_date]
      ,[timesheet_code_id]
      ,[timesheet_version_project_code_type]
      ,[timesheet_code_name]
      ,[timesheet_code]
      ,[multiplier]
      ,[ip_code]
      ,[minutes]
      ,[hours]
      ,[days]
      ,[comment]
      ,[timeoff]
      ,[status]
      ,[competency_id]
      ,[new_taxonomy_role_id]
      ,[seniority_id] from data_in.tmsht_time_report_vw)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[tmsht_time_report_vw] TO [michal.jablonski3@lingarogroup.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[tmsht_time_report_vw] TO [Tomasz.Rebis@lingarogroup.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[tmsht_time_report_vw] TO [ADF-Automation-Team]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[tmsht_time_report_vw] TO [Resourcing_data_read]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[tmsht_time_report_vw] TO [data_mis_project_tmsht_time_report_vw_read_all]
    AS [dbo];
GO

