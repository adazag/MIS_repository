
CREATE view [data_mis].[proj_resource_row_industry_knowledge_vw] as
SELECT a.[id]
      ,[resource_row_id]
      ,[industry_knowledge_id]
	  ,name as industry_knowledge_name
      ,[required_ind]
      ,a.[creation_at]
      ,a.[modified_at]
      ,a.[created_by]
      ,a.[modified_by]
FROM [data_in].[proj_resource_row_industry_knowledge] a
LEFT JOIN [data_in].[industry_knowledge] b on a.industry_knowledge_id = b.id
WHERE EXISTS (
	SELECT 1 
	FROM data_mis_project.sec_emp_all_permission 
	WHERE permission_name = 'PERM_RESOURCE_READ' AND email = USER_NAME()) 
OR IS_MEMBER('db_owner') = 1
GO

