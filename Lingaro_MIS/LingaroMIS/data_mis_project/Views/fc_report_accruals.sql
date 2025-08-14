create view data_mis_project.fc_report_accruals as
WITH

Employee as (
SELECT 
--[client_id]
--      ,[client_name]
       [employee_id]
	   ,employee_full_name
      ,[day_date]
      ,[month_date]
      ,[project_id]
      ,[project_name]
      --,[timesheet_code_id]
      --,[timesheet_version_project_code_type]
      --,[timesheet_code_name]
      --,[timesheet_code]
      ,[multiplier]
      --,[ip_code]
      ,[minutes]
      ,[hours]
      ,[days]
      --,[comment]
      ,[timeoff]
      ,[status] 
  FROM [data_in].[tmsht_time_report_vw] a
  where  minutes>0 and day_date>='2023-01-01'and day_date<=CAST(GETDATE() AS date)),

Contracts as (
SELECT a.[id]
      ,[employee_id]
      ,[contract_type_id]
	  ,b.name as contract_type
      ,[legal_entity_id]
	  ,c.name as legal_entity
      ,[start_date]
      ,case when end_date is null then CAST(GETDATE() AS date) else end_date end as end_date
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[employee_contract] a
  LEFT JOIN [data_in].[org_contract_type] b  on a.contract_type_id=b.id
  LEFT JOIN [data_in].[org_legal_entity] c on a.legal_entity_id=c.id
),

FULL_TABLE as (
SELECT 
--[client_id]
--      ,[client_name]
       a.[employee_id]
	   ,employee_full_name
	   ,contract_type
	   ,legal_entity
      ,[day_date]
      ,[month_date]
      ,[project_id]
      ,[project_name]
      --,[timesheet_code_id]
      --,[timesheet_version_project_code_type]
      --,[timesheet_code_name]
      --,[timesheet_code]
      ,[multiplier]
      --,[ip_code]
      ,[minutes]
      ,[hours]
      ,[days]
      --,[comment]
      ,[timeoff]
      ,[status] 
	  from Employee a
	  left join Contracts b on a.employee_id=b.employee_id and a.day_date>=b.start_date and a.day_date<=b.end_date)


SELECT *
FROM FULL_TABLE
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[fc_report_accruals] TO [data_mis_project_fc_report_accruals_read_all]
    AS [dbo];
GO

