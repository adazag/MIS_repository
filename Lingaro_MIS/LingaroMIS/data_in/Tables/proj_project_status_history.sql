CREATE TABLE [data_in].[proj_project_status_history] (
    [project_id]            BIGINT         NULL,
    [status]                NVARCHAR (100) NULL,
    [change_time_stamp]     DATETIME2 (7)  NULL,
    [change_by_employee_id] BIGINT         NULL
);
GO

