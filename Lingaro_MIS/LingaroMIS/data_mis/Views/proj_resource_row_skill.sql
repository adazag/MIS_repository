

CREATE view [data_mis].[proj_resource_row_skill] as 
SELECT 
		[id]
      ,[resource_row_id]
      ,[skill_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
FROM [data_in].[proj_resource_row_skill]
WHERE EXISTS (
	SELECT 1 
	FROM data_mis_project.sec_emp_all_permission 
	WHERE permission_name = 'PERM_RESOURCE_READ' AND email = USER_NAME()) 
OR IS_MEMBER('db_owner') = 1
GO

