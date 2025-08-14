




CREATE view [data_mis].[proj_resource_row_vw] as (

SELECT  [id]
      ,[name]
      ,[source]
      ,[version_number]
      ,[project_id]
      ,[project_name]
      ,[client_id]
      ,[client_name]
      ,[owner_id]
      ,[owner_name]
      ,[cc_owner_id]
      ,[cc_owner_name]
      ,[competency_id]
      ,[competency_name]
      ,[role_id]
      ,[role_name]
      ,[seniority_id]
      ,[seniority_name]
      ,[start_date]
      ,[end_date]
      ,[country_id]
      ,[country_name]
      ,[country_code]
      ,[status]
      ,[comment]
      ,[on_hold_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[created_by_employee]
      ,[modified_by]
      ,[modified_by_employee]
      ,[any_location_ind]
      ,[demand_type]
      ,[hiring_id]
      ,[starting_required_capacity]
      ,[proposed_talent]
      ,[invoicing_code]
      ,[project_cost_category]
      ,[role_aspect_id]
      ,[role_aspect_name]
	  ,[original_start_date]
	  ,[previous_owner_id]
	  ,[previous_owner_name]
      ,[ultimate_parent_client_id]
      ,[ultimate_parent_client_name]
FROM     data_in.proj_resource_row_vw AS a 
WHERE EXISTS (
	SELECT 1 
	FROM data_mis_project.sec_emp_all_permission 
	WHERE permission_name = 'PERM_RESOURCE_READ' AND email = USER_NAME()) 
OR IS_MEMBER('db_owner') = 1
)
GO

