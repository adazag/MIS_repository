CREATE   VIEW data_mis.[nbp_crncy_rates] AS 

SELECT [day_date]
      ,[currency_code]
      ,[rate_date]
      ,[fx_rate] 
FROM [data_in].[nbp_rate]
GO

