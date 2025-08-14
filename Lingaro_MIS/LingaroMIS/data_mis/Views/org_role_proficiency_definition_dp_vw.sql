
CREATE view [data_mis].[org_role_proficiency_definition_dp_vw] as (
select 
	   [definition_id]
      ,[role_id]
      ,[seniority_id]
      ,[seniority_name]
      ,[description]
      ,[active_ind]
      ,[condition_set_id]
      ,[condition_type]
      ,[number_of_skills]
      ,[minimum_proficiency_level]
      ,[minimum_proficiency_name]
      ,[condition_set_active_ind]
      ,[condition_set_detail_id]
      ,[skill_group_id]
      ,[skill_group_name]
      ,[condition_set_detail_active_ind]
from data_in.org_role_proficiency_definition_dp_vw)
GO

