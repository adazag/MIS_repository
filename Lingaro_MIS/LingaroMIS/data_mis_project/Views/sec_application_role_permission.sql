CREATE view [data_mis_project].[sec_application_role_permission] as
SELECT [id]
      ,[role_name]
      ,[permission_name]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[sec_application_role_permission]
GO

