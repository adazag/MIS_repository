
CREATE view [data_mis].[employee_language] as (
select 
	   [id]
      ,[employee_id]
      ,[language_id]
      ,[skill_level_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.employee_language)
GO

