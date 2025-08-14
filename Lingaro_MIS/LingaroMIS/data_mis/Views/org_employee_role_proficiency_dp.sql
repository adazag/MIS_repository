
CREATE view [data_mis].[org_employee_role_proficiency_dp] as
(
select 
	   [id]
      ,[employee_id]
      ,[role_id]
      ,[seniority_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_employee_role_proficiency_dp)
GO

