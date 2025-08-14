create view data_mis.org_role_aspect_skill as (
select 
		[id]
      ,[role_aspect_id]
      ,[skill_id]
      ,[skill_detail_id]
      ,[skill_level_id]
      ,[required_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from [data_in].[org_role_aspect_skill]
)
GO

