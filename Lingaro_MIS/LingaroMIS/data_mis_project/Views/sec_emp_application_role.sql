

CREATE view [data_mis_project].[sec_emp_application_role] as

SELECT [id]
      ,[employee_id]
      ,[start_date]
      ,[end_date]
      ,[created_at]
      ,[granted_by_employee_id]
      ,[role_name]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[assignment_type]
  FROM [data_in].[sec_emp_application_role]
GO

