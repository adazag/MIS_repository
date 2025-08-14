
CREATE VIEW [data_out_ad].[v_LegalEntity] as
SELECT id as [Id]
      ,name as [Name]
  FROM [data_mis].[sulu_le_lkp]
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_LegalEntity] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_LegalEntity] TO [HR365@lingaro.onmicrosoft.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_LegalEntity] TO [LEAP]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_LegalEntity] TO [data_out_ad_alter_all]
    AS [dbo];
GO

