
CREATE view [data_mis].[proj_resource_row_skill_with_skill_detail_vw] as

SELECT a.[id]
      ,[resource_row_skill_id]
      ,[skill_id]
	  ,e.name as skill_name
      ,[skill_detail_id]
	  ,c.name as skill_detail_name
      ,[skill_level_id] as skill_level
      ,[required_ind]
      ,a.[creation_at]
      ,a.[modified_at]
      ,a.[created_by]
	  ,employee_full_name as created_by_name
      ,a.[modified_by]
	  ,employee_full_name as modified_by_name
FROM [data_in].[proj_resource_row_skill_with_skill_detail] a
LEFT JOIN data_in.org_emp_vw b on a.created_by = b.id and a.modified_by = b.id
LEFT JOIN [data_in].[skill_detail] c on a.skill_detail_id = c.id
LEFT JOIN [data_in].[new_taxonomy_skill_level] d on a.skill_level_id = d.id
LEFT JOIN [data_in].[new_taxonomy_skill] e on a.skill_id = e.id
WHERE EXISTS (
	SELECT 1 
	FROM data_mis_project.sec_emp_all_permission 
	WHERE permission_name = 'PERM_RESOURCE_READ' AND email = USER_NAME()) 
OR IS_MEMBER('db_owner') = 1
GO

