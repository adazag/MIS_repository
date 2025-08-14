
CREATE view [data_mis].[org_emp_seniority] as (
select 
	   [id]
      ,[employee_id]
      ,[seniority_id]
      ,[start_date]
      ,[end_date]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_emp_seniority)
GO

