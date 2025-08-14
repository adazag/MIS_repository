create view data_mis.proj_dictionary_entry as 
SELECT  [id]
      ,[dictionary_id]
      ,[value]
      ,[active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[proj_dictionary_entry]
GO

