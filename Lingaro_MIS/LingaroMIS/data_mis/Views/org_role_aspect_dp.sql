
CREATE view [data_mis].[org_role_aspect_dp] as
(
select 
	   [id]
      ,[role_id]
      ,[name]
      ,[status]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_role_aspect_dp)
GO

