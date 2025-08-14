
CREATE view [data_mis].[language] as (
select 
	   [id]
      ,[name]
      ,[skill_type_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.language)
GO

