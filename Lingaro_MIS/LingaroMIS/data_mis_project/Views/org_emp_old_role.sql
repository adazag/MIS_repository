create view data_mis_project.org_emp_old_role as (
select id
		,employee_id
		,role_name
		,start_date
		,end_date
		,creation_at
		,modified_at
		,created_by
		,modified_by
from data_in.org_emp_old_role
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[org_emp_old_role] TO [data_mis_project_org_emp_old_role_read_all]
    AS [dbo];
GO

