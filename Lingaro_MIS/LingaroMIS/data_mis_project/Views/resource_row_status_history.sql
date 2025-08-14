
CREATE view [data_mis_project].[resource_row_status_history] as (
Select [id]
      ,[resource_row_id]
      ,[new_status]
      ,[modified_by]
      ,[modified_at]
      ,[on_hold_ind] from [data_in].[resource_row_status_history])
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[resource_row_status_history] TO [Resourcing_data_read]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[resource_row_status_history] TO [data_mis_project_resource_row_status_history_read_all]
    AS [dbo];
GO

