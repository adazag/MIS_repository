
CREATE view [data_mis].[employee_competency_role] as (
select 
		[id]
      ,[employee_id]
      ,[priority]
      ,[level]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[preference]
      ,[competency_role_id]
      ,[seniority_id]
from data_in.employee_competency_role )
GO

