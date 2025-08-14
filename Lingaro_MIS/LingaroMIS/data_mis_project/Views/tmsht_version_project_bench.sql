
CREATE view [data_mis_project].[tmsht_version_project_bench] as (
select [id]
      ,[timesheet_version_id]
      ,[project_id]
      ,[bench_bookings]
      ,[bench_actuals]
      ,[non_bench_actuals] from data_in.tmsht_version_project_bench)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[tmsht_version_project_bench] TO [data_mis_project_tmsht_version_project_bench_read_all]
    AS [dbo];
GO

