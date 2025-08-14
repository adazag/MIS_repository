CREATE TABLE [data_in].[employee_role] (
    [id]            BIGINT        NULL,
    [employee_id]   BIGINT        NULL,
    [role_id]       BIGINT        NULL,
    [priority]      INT           NULL,
    [level]         INT           NULL,
    [competency_id] BIGINT        NULL,
    [creation_at]   DATETIME2 (7) NULL,
    [modified_at]   DATETIME2 (7) NULL,
    [created_by]    BIGINT        NULL,
    [modified_by]   BIGINT        NULL
);
GO

