CREATE TABLE [data_in].[org_employee_position] (
    [id]                     BIGINT        NULL,
    [employee_id]            BIGINT        NULL,
    [position_id]            BIGINT        NULL,
    [start_date]             DATE          NULL,
    [end_date]               DATE          NULL,
    [creation_at]            DATETIME2 (7) NULL,
    [modified_at]            DATETIME2 (7) NULL,
    [created_by]             BIGINT        NULL,
    [modified_by]            BIGINT        NULL,
    [level_change_reason_id] BIGINT        NULL
);
GO

