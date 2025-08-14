CREATE view [data_out_cornerstone].[sulu_cornerstone_division]
as
SELECT [id] as [OU ID]
      ,[name] as [OU Name]
      ,[parent_id] as [Parent ID]

  FROM [data_in].[org_unit]
  where end_date is NULL
GO

