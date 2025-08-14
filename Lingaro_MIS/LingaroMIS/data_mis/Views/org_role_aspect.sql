create view data_mis.org_role_aspect as (
select 
		[id]
      ,[name]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from [data_in].[org_role_aspect]
)
GO

