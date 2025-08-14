
CREATE view [data_mis].[org_skill_group_proficiency_definition_dp] as
(
select 
	   [id]
      ,[skill_group_id]
      ,[proficiency_level]
      ,[proficiency_name]
      ,[description]
      ,[active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_skill_group_proficiency_definition_dp)
GO

