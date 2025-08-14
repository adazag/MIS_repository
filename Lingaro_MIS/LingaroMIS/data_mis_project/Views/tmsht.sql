create view data_mis_project.tmsht as(
SELECT [id]
      ,[employee_id]
      ,[start_date]
      ,[end_date]
      ,[due_date]
      ,[week_number]
  FROM [data_in].[tmsht]
)
GO

