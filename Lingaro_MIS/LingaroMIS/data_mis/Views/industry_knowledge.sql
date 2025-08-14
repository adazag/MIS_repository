
CREATE view [data_mis].[industry_knowledge] as (
select 
	   [id]
      ,[name]
      ,[skill_type_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.industry_knowledge)
GO

