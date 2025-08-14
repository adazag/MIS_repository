CREATE ROLE [data_mis_project_empee_cntrt_leaver_read_all]
    AUTHORIZATION [ada.zaglewska@lingarogroup.com];
GO

ALTER ROLE [data_mis_project_empee_cntrt_leaver_read_all] ADD MEMBER [azure-internal];
GO

ALTER ROLE [data_mis_project_empee_cntrt_leaver_read_all] ADD MEMBER [dawid.stylinski@lingarogroup.com];
GO

ALTER ROLE [data_mis_project_empee_cntrt_leaver_read_all] ADD MEMBER [ADF-Automation-Team];
GO

