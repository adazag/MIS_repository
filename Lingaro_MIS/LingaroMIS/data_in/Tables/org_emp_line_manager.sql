CREATE TABLE [data_in].[org_emp_line_manager] (
    [id]              BIGINT        NULL,
    [employee_id]     BIGINT        NULL,
    [line_manager_id] BIGINT        NULL,
    [start_date]      DATE          NULL,
    [end_date]        DATE          NULL,
    [creation_at]     DATETIME2 (7) NULL,
    [modified_at]     DATETIME2 (7) NULL,
    [created_by]      BIGINT        NULL,
    [modified_by]     BIGINT        NULL
);
GO

