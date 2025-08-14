create view data_mis_project.org_emp_key_talent_program as(
select [id]
      ,[employee_id]
      ,[year]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
from data_in.org_emp_key_talent_program)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[org_emp_key_talent_program] TO [data_mis_project_org_emp_key_talent_program_read_all]
    AS [dbo];
GO

