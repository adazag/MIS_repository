
 
CREATE view [data_mis].[org_skill_detail_proficiency_definition_dp] as
( 
select 
	   [id]
      ,[skill_detail_id]
      ,[proficiency_level]
      ,[description]
      ,[active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[proficiency_name]
from data_in.org_skill_detail_proficiency_definition_dp)
GO

