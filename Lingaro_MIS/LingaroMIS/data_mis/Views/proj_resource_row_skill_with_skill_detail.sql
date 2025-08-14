

CREATE view [data_mis].[proj_resource_row_skill_with_skill_detail] as 
SELECT 
		[id]
      ,[resource_row_skill_id]
      ,[skill_id]
      ,[skill_detail_id]
      ,[skill_level_id]
      ,[required_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
FROM [data_in].[proj_resource_row_skill_with_skill_detail]
WHERE EXISTS (
	SELECT 1 
	FROM data_mis_project.sec_emp_all_permission 
	WHERE permission_name = 'PERM_RESOURCE_READ' AND email = USER_NAME()) 
OR IS_MEMBER('db_owner') = 1
GO

