
CREATE view [data_mis].[org_skill_group_dp] as
( 
select 
	   [id]
      ,[name]
      ,[comment]
      ,[status]
      ,[owner_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_skill_group_dp)
GO

