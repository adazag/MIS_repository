
CREATE view  [data_mis].[proj_client_contact] as

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
  WHERE EXISTS (
  SELECT 1 
  FROM data_mis_project.sec_emp_all_permission
  WHERE permission_name = 'PERM_CLIENT_CONTACT_READ' 
    AND email = USER_NAME()
) 
OR IS_MEMBER('db_owner') = 1;
GO

