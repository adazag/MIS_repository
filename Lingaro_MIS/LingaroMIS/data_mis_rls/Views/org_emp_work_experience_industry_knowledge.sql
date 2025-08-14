

CREATE view [data_mis_rls].[org_emp_work_experience_industry_knowledge] 
WITH SCHEMABINDING 
as
SELECT a.[id]
      ,a.[employee_work_experience_id]
	  ,c.employee_id
	  ,CONCAT(d.first_name,d.last_name) as employee_name
      ,a.[industry_knowledge_id]
	  ,b.name as [industry_knowledge_name]
      ,a.[creation_at]
      ,a.[modified_at]
      ,a.[created_by]
      ,a.[modified_by]
  FROM [data_in].[org_emp_work_experience_industry_knowledge] a
  left join [data_in].[industry_knowledge] b on a.[industry_knowledge_id]=b.id
  left join [data_in].[org_emp_work_experience]  c on a.employee_work_experience_id=c.id
  left join data_in.org_emp d on c.employee_id=d.id;
GO

