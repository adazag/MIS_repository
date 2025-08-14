
CREATE view [data_mis].[role] as (
select 
		[id]
      ,[name]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.role
)
GO

