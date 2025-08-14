
CREATE view [data_mis_project].[resource_row_detail] as (
Select [id]
      ,[resource_row_id]
      ,[month_date]
      ,[fte]
      ,[man_days]
      ,[hours]
      ,[competency_role_rate_per_hour]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[first_day_of_week] from [data_in].[resource_row_detail])
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[resource_row_detail] TO [data_mis_project_resource_row_detail_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[resource_row_detail] TO [Resourcing_data_read]
    AS [dbo];
GO

