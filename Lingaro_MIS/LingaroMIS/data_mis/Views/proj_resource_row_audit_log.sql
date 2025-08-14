


CREATE view [data_mis].[proj_resource_row_audit_log] as
(
SELECT [id]
      ,[project_id]
      ,[name]
      ,[version_number]
      ,[source]
      ,[status]
      ,[start_date]
      ,[end_date]
      ,[country_id]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[owner_id]
      ,[valuation_version_id]
      ,[total_man_days]
      ,[competency_role_rate_per_hour]
      ,[total_cost]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[rev]
      ,[revtype]
      ,[on_hold_ind]
      ,[comment]
      ,[cc_owner_id]
      ,[any_location_ind]
      ,[valuation_version_row_id]
      ,[demand_type]
      ,[cancel_reason]
      ,[hiring_id]
      ,[recommended_employee_id]
      ,[accepted_at]
      ,[last_clarification_at]
      ,[allowed_alternative_date_ind]
      ,[role_aspect_id]
      ,[previous_owner_id]
  FROM [data_in].[proj_resource_row_audit_log]
  WHERE EXISTS (
	SELECT 1 
	FROM data_mis_project.sec_emp_all_permission 
	WHERE permission_name = 'PERM_RESOURCE_READ' AND email = USER_NAME()) 
OR IS_MEMBER('db_owner') = 1
)
GO

