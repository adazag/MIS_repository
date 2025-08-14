
CREATE view [data_mis].[org_skill_owner_dp] as
(
select 
	   [id]
      ,[name]
      ,[description]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_skill_owner_dp)
GO

