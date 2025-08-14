create view data_mis.new_taxonomy_skill as 
SELECT [id]
      ,[name]
      ,[skill_type_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[new_taxonomy_skill]
GO

