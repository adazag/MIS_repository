



CREATE view [data_mis].[proj_resource_proporsal_row_vw] as
(

SELECT a.id
       ,a.employee_id
       ,a.employee_name
       ,a.competency_id
       ,a.competency_name
       ,a.resource_proposal_id
       ,a.resource_row_id
       ,a.capacity_sufficient_ind
       ,a.resource_status
       ,a.client_id
       ,a.client_name
       ,a.project_id
       ,a.project_name
       ,b.role_id
       ,c.name AS role_name
       ,b.seniority_id
       ,d.name AS seniority_name
       ,a.status AS proposal_status
       ,a.creation_at
       ,a.modified_at
       ,a.created_by
       ,a.created_by_employee
       ,a.modified_by
       ,a.modified_by_employee
       ,a.overbooking_allowed_ind
       ,e.comment AS rejection_comment
	   ,a.line_manager_id
	   ,a.line_manager
FROM data_in.proj_resource_proposal_row_vw AS a
LEFT OUTER JOIN data_in.proj_resource_proposal_row AS b ON a.id = b.id
LEFT OUTER JOIN data_in.role AS c ON b.role_id = c.id
LEFT OUTER JOIN data_in.seniority AS d ON b.seniority_id = d.id
LEFT OUTER JOIN data_in.proj_resource_proposal e ON a.resource_proposal_id = e.id
WHERE EXISTS (
	SELECT 1 
	FROM data_mis_project.sec_emp_all_permission 
	WHERE permission_name = 'PERM_RESOURCE_READ' AND email = USER_NAME()) 
OR IS_MEMBER('db_owner') = 1
)
GO

