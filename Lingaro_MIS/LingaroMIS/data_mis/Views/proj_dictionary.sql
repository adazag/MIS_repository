create view data_mis.proj_dictionary as 
SELECT [id]
      ,[name]
      ,[type]
      ,[existing_dictionary_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[proj_dictionary]
GO

