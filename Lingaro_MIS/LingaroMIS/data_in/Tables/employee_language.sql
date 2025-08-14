CREATE TABLE [data_in].[employee_language] (
    [id]             BIGINT        NOT NULL,
    [employee_id]    BIGINT        NULL,
    [language_id]    BIGINT        NULL,
    [skill_level_id] BIGINT        NULL,
    [creation_at]    DATETIME2 (7) NULL,
    [modified_at]    DATETIME2 (7) NULL,
    [created_by]     BIGINT        NULL,
    [modified_by]    BIGINT        NULL
);
GO

