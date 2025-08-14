create view  data_mis_project.org_emp_time_off as
SELECT [id]
      ,[request_id]
      ,[employee_id]
      ,[day_date]
      ,[approval_status]
      ,[approver_id]
      ,[created_at]
      ,[time_off_type]
      ,[time_off_minutes]
      ,[time_off_comment]
      ,[approver_action_time]
      ,[requested_minutes]
      ,[required_permission_name]
      ,[next_action_candidates]
      ,[assigned_minutes]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[overtime_compensation_for_month]
      ,[overtime_compensation_settled_ind]
      ,[start_date_time]
      ,[end_date_time]
  FROM [data_in].[org_emp_time_off]
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[org_emp_time_off] TO [Resourcing_data_read]
    AS [dbo];
GO

