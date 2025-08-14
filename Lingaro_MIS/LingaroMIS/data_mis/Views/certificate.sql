
CREATE view [data_mis].[certificate] as (
select 
	   [id]
      ,[name]
      ,[code]
      ,[technology_id]
      ,[skill_type_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[parent_id]
      ,[active_ind]
from data_in.certificate)
GO

