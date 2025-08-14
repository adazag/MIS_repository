
CREATE view [data_mis_project].[proj_blockade_audit_log] as (
select [id]
      ,[employee_id]
      ,[project_id]
      ,[week_number]
      ,[start_date]
      ,[end_date]
      ,[percentage]
      ,[man_days]
      ,[hours]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[rev]
      ,[revtype]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[resource_proposal_id]
      ,[valid_till] from data_in.proj_blockade_audit_log)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_blockade_audit_log] TO [data_mis_project_proj_blockade_audit_log_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[proj_blockade_audit_log] TO [Resourcing_data_read]
    AS [dbo];
GO

