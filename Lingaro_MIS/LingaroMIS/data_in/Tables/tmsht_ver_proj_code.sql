CREATE TABLE [data_in].[tmsht_ver_proj_code] (
    [id]                                  BIGINT         NOT NULL,
    [timesheet_version_project_id]        BIGINT         NULL,
    [timesheet_code_id]                   BIGINT         NULL,
    [timesheet_version_project_code_type] NVARCHAR (100) NULL,
    [ip_ind]                              BIT            NULL
);
GO

ALTER TABLE [data_in].[tmsht_ver_proj_code]
    ADD CONSTRAINT [timesheet_version_project_code_pk] PRIMARY KEY CLUSTERED ([id] ASC);
GO

