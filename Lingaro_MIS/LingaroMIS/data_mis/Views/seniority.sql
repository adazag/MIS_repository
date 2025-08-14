
CREATE view [data_mis].[seniority] as (
select [id]
      ,[name]
      ,[is_active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[level] 
from data_in.seniority)
GO

