

CREATE view [data_mis_project].[sec_emp_all_permission] as
  SELECT DISTINCT 
	   r.[employee_id]
	  ,e.employee_full_name
	  ,e.email
	  ,e.role
	  ,e.position
      --,r.role_name
	  ,p.permission_name
  FROM [data_mis_project].[sec_emp_application_role] r
  LEFT JOIN [data_mis_project].[sec_application_role_permission] p ON r.role_name = p.role_name
  LEFT JOIN [data_in].[org_emp_vw] e ON r.employee_id = e.id
  WHERE 1=1
  AND e.active_ind = 1

  UNION

  SELECT DISTINCT
	  p.employee_id
	  ,e.employee_full_name
	  ,e.email
	  ,e.role
	  ,e.position
	  ,p.type as permission_name
  FROM [data_in].[sec_emp_application_permission] p
  LEFT JOIN [data_in].[org_emp_vw] e ON p.employee_id = e.id
  WHERE 1=1
  AND e.active_ind = 1
GO

