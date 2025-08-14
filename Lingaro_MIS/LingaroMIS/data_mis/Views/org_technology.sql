create view data_mis.org_technology as
SELECT [id]
      ,[name]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[active_ind]
  FROM [data_in].[technology]
GO

