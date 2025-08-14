create view data_mis_project.org_emp_competency_role_new as(
select [id]
      ,[employee_id]
      ,[competency_role_id]
      ,[start_date]
      ,[end_date]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from [data_in].[org_emp_competency_role_new])
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[org_emp_competency_role_new] TO [data_mis_project_org_emp_competency_role_new_read_all]
    AS [dbo];
GO

