CREATE ROLE [data_mis_thor_read_all]
    AUTHORIZATION [dbo];
GO

ALTER ROLE [data_mis_thor_read_all] ADD MEMBER [thordbsync];
GO

ALTER ROLE [data_mis_thor_read_all] ADD MEMBER [bartosz.grzesiak@lingarogroup.com];
GO

ALTER ROLE [data_mis_thor_read_all] ADD MEMBER [robert.tomaszek@lingarogroup.com];
GO

ALTER ROLE [data_mis_thor_read_all] ADD MEMBER [jesus.cobian@lingarogroup.com];
GO

