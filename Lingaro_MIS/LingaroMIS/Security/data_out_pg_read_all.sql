CREATE ROLE [data_out_pg_read_all]
    AUTHORIZATION [dbo];
GO

ALTER ROLE [data_out_pg_read_all] ADD MEMBER [Tomasz.Rebis@lingarogroup.com];
GO

ALTER ROLE [data_out_pg_read_all] ADD MEMBER [ADF-Automation-Team];
GO

ALTER ROLE [data_out_pg_read_all] ADD MEMBER [michal.jablonski3@lingarogroup.com];
GO

