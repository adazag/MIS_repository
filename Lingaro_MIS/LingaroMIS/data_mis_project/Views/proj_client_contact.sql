  create view data_mis_project.proj_client_contact
  as
  SELECT [id]
      ,[first_name]
      ,[last_name]
      ,[client_id]
      ,[email_text]
      ,[active_ind]
      ,[created_by]
      ,[modified_by]
      ,[creation_at]
      ,[modified_at]
  FROM [data_in].[proj_client_contact]
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_client_contact] TO [data_mis_project_proj_client_contact_read_all]
    AS [dbo];
GO

