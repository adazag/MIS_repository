CREATE TABLE [data_in].[proj_permission] (
    [id]                   BIGINT        NULL,
    [project_id]           BIGINT        NULL,
    [delegate_employee_id] BIGINT        NULL,
    [start_date]           DATE          NULL,
    [end_date]             DATE          NULL,
    [creation_at]          DATETIME2 (7) NULL,
    [modified_at]          DATETIME2 (7) NULL,
    [created_by]           BIGINT        NULL,
    [modified_by]          BIGINT        NULL
);
GO

