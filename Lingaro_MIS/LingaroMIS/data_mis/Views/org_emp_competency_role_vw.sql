
CREATE view [data_mis].[org_emp_competency_role_vw] as (

SELECT 
		vw.[employee_id]
      ,vw.[employee_full_name]
      ,vw.[org_unit_name]
      ,vw.[competency_name]
      ,vw.[role_name]
      ,vw.[preference]
FROM [data_in].[org_emp_competency_role_vw] vw
left join [data_in].[org_emp_vw] emp on emp.id = vw.employee_id
where emp.active_ind = 1)
GO

