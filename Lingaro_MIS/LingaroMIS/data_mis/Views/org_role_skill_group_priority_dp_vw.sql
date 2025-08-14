
CREATE view [data_mis].[org_role_skill_group_priority_dp_vw] as
(
select 
	   [role_id]
      ,[skill_group_id]
      ,[priority_type]
from data_in.org_role_skill_group_priority_dp_vw)
GO

