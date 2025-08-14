
CREATE view [data_mis].[new_taxonomy_competency_role] as (
select 
	   [id]
      ,[competency_id]
      ,[role_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.new_taxonomy_competency_role)
GO

