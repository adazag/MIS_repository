
CREATE view [data_mis].[org_skill_group_proficiency_condition_set_detail_dp] as
(
select 
	   [id]
      ,[skill_group_proficiency_condition_set_id]
      ,[skill_detail_id]
      ,[active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_skill_group_proficiency_condition_set_detail_dp)
GO

