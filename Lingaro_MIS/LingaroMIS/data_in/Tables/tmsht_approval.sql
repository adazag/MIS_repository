CREATE TABLE [data_in].[tmsht_approval] (
    [id]                                BIGINT         NULL,
    [pm_employee_id]                    BIGINT         NULL,
    [timesheet_version_id]              BIGINT         NULL,
    [timesheet_version_project_code_id] BIGINT         NULL,
    [status]                            NVARCHAR (300) NULL,
    [due_time]                          DATETIME2 (7)  NULL,
    [change_time]                       DATETIME2 (7)  NULL,
    [aprover_employee_id]               BIGINT         NULL,
    [approval_level]                    NVARCHAR (300) NULL
);
GO

