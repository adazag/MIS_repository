
CREATE view [data_mis].[org_emp_work_experience] as (




select 
		[id]
      ,[employee_id]
      ,[company_name]
      ,[position_name]
      ,[start_date]
      ,[end_date]
      ,[work_description]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_emp_work_experience)
GO

