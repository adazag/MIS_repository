
CREATE view [data_mis].[org_employee_skill_group_detail_proficiency_dp_vw] as
(
select 
	   [employee_id]
      ,[skill_group_id]
      ,[skill_group_proficiency_level]
      ,[skill_detail_id]
      ,[skill_detail_proficiency_level]
from data_in.org_employee_skill_group_detail_proficiency_dp_vw)
GO

