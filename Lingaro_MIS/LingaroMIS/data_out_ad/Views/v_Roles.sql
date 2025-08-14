


CREATE View [data_out_ad].[v_Roles] as
SELECT [Id] as [Id]
      ,[Name] as [Name]
  FROM [data_mis].[role]
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Roles] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Roles] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Roles] TO [HR365@lingaro.onmicrosoft.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Roles] TO [LEAP]
    AS [dbo];
GO

