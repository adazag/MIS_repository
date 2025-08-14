
CREATE view [data_mis].[org_emp_competency_role_potential_vw]  as
SELECT 
		vw.[employee_id]
      ,vw.[employee_full_name]
      ,vw.[org_unit_name]
      ,vw.[competency_name]
	  ,r.id as role_id
      ,vw.[role_name]
      ,vw.[preference]
	  ,ecr.seniority_id
	  ,s.name as seniority_name
FROM [data_in].[org_emp_competency_role_vw] vw
left join [data_in].[org_emp_vw] emp on emp.id = vw.employee_id
left join. data_in.role r on vw.role_name = r.name
left join data_in.employee_competency_role ecr on vw.employee_id = ecr.employee_id and r.id = ecr.competency_role_id
left join data_in.seniority s on ecr.seniority_id = s.id
where emp.active_ind = 1 and vw.preference = 'POTENTIAL'
--GO
GO

