

--/****** Object:  View [data_mis].[project_status_data]    Script Date: 3.06.2025 11:43:05 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO




CREATE VIEW [data_mis].[proj_status] AS 


with rebaseline_grouping AS (
SELECT 
	project_id
	,MAX(day_date) as Max_rebaseline_date
	,COUNT(id) as rebaseline_count
FROM [data_in].[proj_rebaseline]
GROUP BY project_id
--HAVING project_id = 7854
),

rebaseline AS (
SELECT 
r.project_id 
,rr.reason_text
,rc.comment
,r.modified_at as rebaseline_modify_date
,rg.Max_rebaseline_date
,rg.rebaseline_count
FROM [data_in].[proj_rebaseline] r
LEFT JOIN [data_in].[proj_rebaseline_comment] rc ON r.project_id = rc.project_id
LEFT JOIN [data_in].[proj_rebaseline_reason] rr ON r.reason_id = rr.id
LEFT JOIN rebaseline_grouping rg ON r.project_id = rg.project_id
--where r.project_id = 8755
)


SELECT psr.[id] as status_report_id
      ,psr.[project_id]
	  ,p.[organization_unit_name]
	  ,p.[bu_name] as business_unit
	  ,p.[sub_bu_name] as sub_business_unit
	  ,p.[delivery_team_name] as delivery_team
	  ,p.[team_name] as team_name
	  ,p.[project_name] as engagement_name
	  ,p.[start_date]
	  ,p.[end_date]
	  ,p.[project_priority_name]
	  ,p.[project_scale_name]
	  ,p.[manager_name] as project_manager
	  ,p.[status_code]
	  ,p.[change_date]
	  ,psr.[executive_summary]
	  ,psr.[help_needed]
      ,psr.[help_needed_lingaro]
      --,psr.[status_day_date]
      ,psr.[overall_health_status]
      ,psr.[cost_status]
      --,psr.[cost_status_visibility]
      ,psr.[time_status]
      --,psr.[time_status_visibility]
      ,psr.[scope_status]
      --,psr.[scope_status_visibility]
      ,psr.[resource_status]
     -- ,psr.[resource_status_visibility]
      ,psr.[full_link]
	  ,psr.[current_ind]
	  ,p.[agile_framework_id]
	  ,a.[name] as agile_framework
      ,p.[agile_score]
	  ,p.client_id
	  ,p.client_name
	  ,psr.[created_by]
	  ,e.employee_full_name as created_by_name
	  ,psr.[creation_at]
      ,psr.[modified_at]
	  ,p.[engagement_type_name] as engagement_type
	  ,p.[security_ind] as has_security_flag
	  ,psr.[automatic_generated_report_ind] as is_automatic_generated_report
	  ,p.[is_status_required]
	  ,p.parent_financial_project_id
	  ,p.parent_financial_project_name
	  ,p.[project_group_id]
	  ,p.[project_group_name]
	  ,psr.[project_manager_id_in_creation_moment]
	  ,e2.employee_full_name as project_manager_name_in_creation
	  ,r.Max_rebaseline_date
	  ,r.comment
	  ,r.reason_text
	  ,r.rebaseline_modify_date
	  ,r.rebaseline_count
      --,psr.[project_finance_current]
      --,psr.[project_finance_forecast]
      --,psr.[project_finance_currency]
      --,psr.[activities_planned_next_week]
      --,psr.[completed_activities_past_week]
      --,psr.[identified_risk]
      --,psr.[modified_by]
	  ,p.work_category_name
	  ,CASE WHEN p.engagement_type_name = 'Internal' THEN 1 ELSE 0 END AS is_internal_engagement
  FROM [data_in].[proj_status_report] psr
  LEFT JOIN [data_in].[proj_vw] p ON psr.project_id = p.project_id
  LEFT JOIN [data_in].[org_emp_vw] e ON psr.created_by = e.id
  LEFT JOIN [data_in].[org_emp_vw] e2 ON psr.[project_manager_id_in_creation_moment] = e2.id
  LEFT JOIN rebaseline r ON psr.project_id = r.project_id
  LEFT JOIN [data_in].[proj_agile_framework] a ON p.agile_framework_id = a.id
  WHERE EXISTS (
  	SELECT 1 
  	FROM data_mis_project.sec_emp_all_permission 
  	WHERE permission_name = 'PERM_PROJECT_READ' 
  	  AND email = USER_NAME()
  ) 
  OR IS_MEMBER('db_owner') = 1
GO

