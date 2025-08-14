CREATE TABLE [data_in].[new_taxonomy_employee_skill] (
    [id]          BIGINT        NOT NULL,
    [employee_id] BIGINT        NULL,
    [skill_id]    BIGINT        NULL,
    [priority_id] BIGINT        NULL,
    [creation_at] DATETIME2 (7) NULL,
    [modified_at] DATETIME2 (7) NULL,
    [created_by]  BIGINT        NULL,
    [modified_by] BIGINT        NULL
);
GO

