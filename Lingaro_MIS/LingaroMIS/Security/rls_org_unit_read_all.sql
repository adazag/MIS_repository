CREATE ROLE [rls_org_unit_read_all]
    AUTHORIZATION [dbo];
GO

ALTER ROLE [rls_org_unit_read_all] ADD MEMBER [Controling_data_read];
GO

ALTER ROLE [rls_org_unit_read_all] ADD MEMBER [Pricing_data_read];
GO

