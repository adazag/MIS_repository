
CREATE view [data_mis].[org_employee_potential_role_aspect_dp] as
(
select 
	   [id]
      ,[employee_id]
      ,[role_aspect_id]
      ,[seniority_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_employee_potential_role_aspect_dp)
GO

