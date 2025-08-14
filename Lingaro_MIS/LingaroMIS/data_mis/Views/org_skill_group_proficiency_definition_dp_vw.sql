
CREATE view [data_mis].[org_skill_group_proficiency_definition_dp_vw] as
(
select 
	   [definition_id]
      ,[skill_group_id]
      ,[proficiency_level]
      ,[proficiency_name]
      ,[description]
      ,[active_ind]
      ,[condition_set_id]
      ,[condition_type]
      ,[number_of_skills]
      ,[minimum_proficiency_level]
      ,[minimum_proficiency_name]
      ,[condition_set_active_ind]
      ,[condition_set_detail_id]
      ,[skill_detail_id]
      ,[skill_detail_name]
      ,[condition_set_detail_active_ind]
from data_in.org_skill_group_proficiency_definition_dp_vw)
GO

