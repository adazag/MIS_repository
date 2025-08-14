
CREATE view [data_mis].[org_role_proficiency_condition_set_dp] as
(
select 
	   [id]
      ,[role_proficiency_definition_id]
      ,[condition_type]
      ,[number_of_skills]
      ,[set_number]
      ,[minimum_proficiency_level]
      ,[active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_role_proficiency_condition_set_dp)
GO

