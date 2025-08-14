
CREATE view [data_mis].[org_role_proficiency_definition_dp] as
(
select 
	   [id]
      ,[role_id]
      ,[seniority_id]
      ,[description]
      ,[active_ind]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_role_proficiency_definition_dp)
GO

