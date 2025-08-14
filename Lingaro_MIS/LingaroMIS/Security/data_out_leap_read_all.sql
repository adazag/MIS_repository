CREATE ROLE [data_out_leap_read_all]
    AUTHORIZATION [dbo];
GO

ALTER ROLE [data_out_leap_read_all] ADD MEMBER [LEAP@lingaro.onmicrosoft.com];
GO

