
CREATE view [data_mis].[new_taxonomy_skill_composite_vw] as 
select 
	   [competency_id]
      ,[competency_name]
      ,[role_id]
      ,[role_name]
      ,[skill_id]
      ,[skill_name]
      ,[skill_detail_id]
      ,[skill_detail_name]
      ,[skill_priority_id]
      ,[skill_priority_name]
from [data_in].[new_taxonomy_skill_composite_vw]
GO

