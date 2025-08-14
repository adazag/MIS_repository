


/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [data_mis_rls].[org_emp_about] 
WITH SCHEMABINDING
as
SELECT a.[id]
      ,a.[employee_id]
	  ,CONCAT(b.first_name,b.last_name) as employee_name
      ,a.[description]
      ,a.[creation_at]
      ,a.[modified_at]
      ,a.[created_by]
      ,a.[modified_by]
  FROM [data_in].[org_emp_about] a
  left join data_in.org_emp b on a.employee_id=b.id;
GO

