
CREATE view [data_mis].[org_role_aspect_proficiency_definition_dp] as
(
select 
	   [id]
      ,[role_aspect_id]
      ,[skill_group_id]
      ,[skill_detail_id]
      ,[seniority_id]
      ,[active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[proficiency_level]
from data_in.org_role_aspect_proficiency_definition_dp)
GO

