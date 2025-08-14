
CREATE view [data_mis].[org_skill_detail_group_association_dp] as
(
select 
	   [id]
      ,[skill_group_id]
      ,[skill_detail_id]
      ,[status]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_skill_detail_group_association_dp)
GO

