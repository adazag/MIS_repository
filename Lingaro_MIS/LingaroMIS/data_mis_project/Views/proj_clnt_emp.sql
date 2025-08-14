create view [data_mis_project].[proj_clnt_emp] as(
SELECT proj.[id]
      ,proj.[name]
      ,proj.[share_point_name]
      ,proj.[leave_contact_email]
      ,proj.[leave_notification_period_days]
      ,proj.[active_notification_ind]
      ,proj.[account_manager_id]
	  ,emp.employee_full_name as account_manager_name
      ,proj.[salesforce_id]
      ,proj.[ultimate_parent_id]
      ,proj.[ultimate_parent_name]
	  ,emergency.emergency_contact
	  ,emergency.last_verified_at
	  ,emergency.last_verified_by
	  ,proj.emergency_contact_excluded_ind
	  ,proj.emergency_contact_exclusion_reason
	  ,proj.emergency_contact_modified_at 
	  ,proj.emergency_contact_modified_by
FROM [data_in].[proj_clnt] proj
left join [data_in].[org_emp_vw] emp on proj.account_manager_id = emp.id
left join [data_in].[proj_clnt] emergency on proj.id=emergency.id)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_clnt_emp] TO [data_mis_project_proj_clnt_emp_read_all]
    AS [dbo];
GO

