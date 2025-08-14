




create VIEW [data_mis_rls].[timesheet_data] 
with schemabinding
as 
SELECT t.[client_id]
      ,t.[client_name]
      ,t.[project_id]
      ,t.[project_name]
	  ,p.[project_billable_ind]
	  ,p.[governance_ind]
	  ,p.[investment_ind]
      ,t.[employee_id]
      ,t.[employee_full_name]
	  ,e.org_unit_id
      ,t.[day_date]
      ,t.[month_date]
      ,t.[timesheet_code_id]
      ,t.[timesheet_version_project_code_type]
      ,t.[timesheet_code_name]
      ,t.[timesheet_code]
      ,t.[multiplier]
      ,t.[ip_code]
      ,t.[minutes]
      ,t.[hours]
      ,t.[days]
      ,t.[comment]
      ,t.[timeoff]
      ,t.[status]
      ,t.[competency_id]
	  ,nt.[name] as competency_name
      ,t.[new_taxonomy_role_id]
	  ,r.name as role_name
      ,t.[seniority_id]
	  ,s.[name] as seniority_name
  FROM [data_in].[tmsht_time_report_vw] t
  LEFT JOIN [data_in].[proj_vw] p ON t.project_id = p.project_id
  LEFT JOIN [data_in].[org_seniority] s ON t.seniority_id = s.id
  LEFT JOIN [data_in].[new_taxonomy_competency] nt ON t.competency_id =nt.id
  LEFT JOIN [data_in].[role] r ON t.new_taxonomy_role_id = r.id
  LEFT JOIN [data_in].[org_emp_vw] e ON t.employee_id = e.id
  --where employee_id = 223338
 -- where t.day_date > '2024-01-01' --and t.project_id is not null
GO

