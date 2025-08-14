CREATE ROLE [data_out_cornerstone_read_all]
    AUTHORIZATION [dbo];
GO

ALTER ROLE [data_out_cornerstone_read_all] ADD MEMBER [cornerstone-integration];
GO

