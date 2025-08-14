CREATE VIEW  data_mis_project.proj_permission as
SELECT [id]
      ,[project_id]
      ,[delegate_employee_id]
      ,[start_date]
      ,[end_date]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by] 
	  FROM [data_in].proj_permission
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_permission] TO [data_mis_project_proj_permission_read_all]
    AS [dbo];
GO

