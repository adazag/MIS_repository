
CREATE view [data_mis].[org_employee_skill_detail_dp] as
(
select 
	   [id]
      ,[employee_id]
      ,[skill_detail_id]
      ,[proficiency_level]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_employee_skill_detail_dp)
GO

