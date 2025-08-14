
CREATE VIEW [data_mis].[proj_project_status_history]
as select
[project_id]
	,[status]
	,[change_time_stamp]
	,[change_by_employee_id] 
	from data_in.proj_project_status_history
GO

