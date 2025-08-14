create view data_mis.org_technology_tag as
SELECT [id]
      ,[technology_id]
      ,[tag_type_id]
      ,[tag_value]
      ,[creation_at]
      ,[modified_at]
      ,[created_by] 
      ,[modified_by]
  FROM [data_in].[org_technology_tag]
GO

