create view data_mis.proj_answer as
SELECT [id]
      ,[form_id]
      ,[question_id]
      ,[type]
      ,[value]
      ,[custom_answer]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[is_optional_ind]
  FROM [data_in].[proj_answer]
GO

