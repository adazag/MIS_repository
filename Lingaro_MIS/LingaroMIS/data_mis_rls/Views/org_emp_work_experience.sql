

CREATE   view [data_mis_rls].[org_emp_work_experience] 
WITH SCHEMABINDING 
as
SELECT a.[id]
      ,[employee_id]
	  ,CONCAT(b.first_name,b.last_name) as employee_name
      ,a.[company_name]
      ,a.[position_name]
      ,a.[start_date]
      ,a.[end_date]
      ,a.[work_description]
      ,a.[creation_at]
      ,a.[modified_at]
      ,a.[created_by]
      ,a.[modified_by]
  FROM [data_in].[org_emp_work_experience] a
  left join data_in.org_emp b on a.employee_id=b.id
GO

