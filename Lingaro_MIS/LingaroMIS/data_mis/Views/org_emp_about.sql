


CREATE view [data_mis].[org_emp_about] as (




select [id]
      ,[employee_id]
      ,[description]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
	  from data_in.org_emp_about
WHERE EXISTS (
SELECT 1 
FROM data_mis_project.sec_emp_all_permission
WHERE permission_name = 'PERM_EMPLOYEE_ABOUT_READ_ALL' AND email = USER_NAME()
) 
OR IS_MEMBER('db_owner') = 1	  
	  
	  )
GO

