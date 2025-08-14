
CREATE view [data_mis].[org_emp_education] as (




select 
		[id]
      ,[employee_id]
      ,[university_name]
      ,[degree_field_name]
      ,[start_date]
      ,[end_date]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_emp_education)
GO

