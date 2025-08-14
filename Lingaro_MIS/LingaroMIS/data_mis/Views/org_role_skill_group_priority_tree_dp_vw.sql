
CREATE view [data_mis].[org_role_skill_group_priority_tree_dp_vw] as
(
select 
	   [role_id]
      ,[skill_group_id]
      ,[skill_group_name]
      ,[priority_type]
      ,[skill_detail_id]
      ,[skill_detail_name]
from data_in.org_role_skill_group_priority_tree_dp_vw)
GO

