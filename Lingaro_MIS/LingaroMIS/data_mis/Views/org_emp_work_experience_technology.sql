
CREATE view [data_mis].[org_emp_work_experience_technology] as (
select 
	   [id]
      ,[employee_work_experience_id]
      ,[technology_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_emp_work_experience_technology)
GO

