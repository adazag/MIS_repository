

CREATE view [data_mis].[org_employee_skill_group_proficiency_dp] as
(
select 
	   [id]
      ,[employee_id]
      ,[skill_group_id]
      ,[proficiency_level]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_employee_skill_group_proficiency_dp)
GO

