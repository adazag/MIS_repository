CREATE ROLE [data_out_cxms_read_all]
    AUTHORIZATION [dbo];
GO

ALTER ROLE [data_out_cxms_read_all] ADD MEMBER [grzegorz.pawelec@lingarogroup.com];
GO

ALTER ROLE [data_out_cxms_read_all] ADD MEMBER [cxms-adf-dev];
GO

