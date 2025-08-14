CREATE ROLE [data_out_ad_read_all]
    AUTHORIZATION [dbo];
GO

ALTER ROLE [data_out_ad_read_all] ADD MEMBER [Tomasz.Rebis@lingarogroup.com];
GO

ALTER ROLE [data_out_ad_read_all] ADD MEMBER [ADF-Automation-Team];
GO

ALTER ROLE [data_out_ad_read_all] ADD MEMBER [dawid.stylinski@lingarogroup.com];
GO

ALTER ROLE [data_out_ad_read_all] ADD MEMBER [oleksandr.sen@lingarogroup.com];
GO

ALTER ROLE [data_out_ad_read_all] ADD MEMBER [Sync-MindentoObjects];
GO

ALTER ROLE [data_out_ad_read_all] ADD MEMBER [Grzegorz.Tkaczyk@lingarogroup.com];
GO

ALTER ROLE [data_out_ad_read_all] ADD MEMBER [LNG-App-SyncUserProfiles];
GO

ALTER ROLE [data_out_ad_read_all] ADD MEMBER [azure-internal];
GO

