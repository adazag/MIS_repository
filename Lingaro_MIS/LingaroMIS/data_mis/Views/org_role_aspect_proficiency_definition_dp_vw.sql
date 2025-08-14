

CREATE view [data_mis].[org_role_aspect_proficiency_definition_dp_vw] as
(
select 
	   [role_aspect_id]
      ,[role_aspect_name]
      ,[role_aspect_status]
      ,[role_id]
      ,[role_name]
      ,[definition_id]
      ,[skill_group_id]
      ,[skill_group_name]
      ,[skill_detail_id]
      ,[skill_detail_name]
      ,[seniority_id]
      ,[seniority_name]
      ,[definition_active_ind]
	  ,[proficiency_level]
from data_in.org_role_aspect_proficiency_definition_dp_vw)
GO

