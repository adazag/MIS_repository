
CREATE View [data_out_ad].[v_Positions] as
SELECT [PositionId] as [Id]
      ,[PositionName] as [Name]
  FROM [data_out_ad].[dic_positions]
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Positions] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Positions] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Positions] TO [HR365@lingaro.onmicrosoft.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Positions] TO [LEAP]
    AS [dbo];
GO

