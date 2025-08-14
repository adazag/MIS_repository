

CREATE View [data_out_leap].[v_Positions] as
SELECT [PositionId] as [Id]
      ,[PositionName] as [Name]
  FROM [data_out_ad].[dic_positions]
GO

