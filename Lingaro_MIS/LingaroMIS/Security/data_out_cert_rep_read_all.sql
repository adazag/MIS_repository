CREATE ROLE [data_out_cert_rep_read_all]
    AUTHORIZATION [dbo];
GO

ALTER ROLE [data_out_cert_rep_read_all] ADD MEMBER [jonriz.parrilla@lingarogroup.com];
GO

ALTER ROLE [data_out_cert_rep_read_all] ADD MEMBER [jofel.ingalla@lingarogroup.com];
GO

ALTER ROLE [data_out_cert_rep_read_all] ADD MEMBER [lingaro.manila.apps@lingarogroup.com];
GO

ALTER ROLE [data_out_cert_rep_read_all] ADD MEMBER [tina.dayon@lingarogroup.com];
GO

