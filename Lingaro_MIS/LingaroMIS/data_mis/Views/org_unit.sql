create view data_mis.org_unit
as
SELECT [id] as [org_unit_id]
      ,[name] as [org_unit_name]
      ,[parent_id] as [org_unit_parnt_id]
      ,[start_date]
      ,[end_date]
      ,[unit_level]
      ,[type]
      ,[leader_id] as [leadr_emp_id]
  FROM [data_in].[org_unit]
GO

