
CREATE   VIEW [data_mis].[org_emp_language_vw] AS 
SELECT  
		vw.[employee_id]
      ,vw.[employee_full_name]
      ,vw.[org_unit_name]
      ,vw.[language_name]
      ,vw.[skill_level]
FROM [data_in].[org_emp_language_vw] vw
left join [data_in].[org_emp_vw] emp on emp.id = vw.employee_id
where emp.active_ind = 1;
GO

