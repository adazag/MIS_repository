create view data_mis_project.position_history as(
select a.id
	,a.employee_id
	,a.position_id
	,b.name as position_name
	,a.start_date
	,a.end_date
	,a.creation_at
	,a.modified_at
	,a.created_by
	,a.modified_by
	from data_in.org_employee_position a
left join data_in.org_emp_position b  on a.position_id = b.id)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[position_history] TO [data_mis_project_position_history_read_all]
    AS [dbo];
GO

