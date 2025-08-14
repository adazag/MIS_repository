
CREATE view [data_mis].[org_role_proficiency_condition_set_detail_dp] as
(
select 
	   [id]
      ,[role_proficiency_condition_set_id]
      ,[skill_group_id]
      ,[active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_role_proficiency_condition_set_detail_dp)
GO

