create view  data_mis.proj_knowledge_management_form as 
SELECT  [id]
      ,[project_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[proj_knowledge_management_form]
GO

