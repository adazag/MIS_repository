create view [data_mis_project].[tmsht_ver] as(
SELECT [id]
      ,[timesheet_id]
      ,[version_number]
      ,[status]
      ,[close_date]
      ,[legacy_timesheet_id]
      ,[changed_date]
      ,[reopen_reason]
      ,[last_version]
      ,[hibernate_version]  
  FROM [data_in].[tmsht_ver]
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[tmsht_ver] TO [data_mis_project_tmsht_ver_read_all]
    AS [dbo];
GO

