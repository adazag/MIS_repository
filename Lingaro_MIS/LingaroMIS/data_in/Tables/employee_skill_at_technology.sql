CREATE TABLE [data_in].[employee_skill_at_technology] (
    [id]                BIGINT        NULL,
    [employee_skill_id] BIGINT        NULL,
    [employee_id]       BIGINT        NULL,
    [skill_id]          BIGINT        NULL,
    [technology_id]     BIGINT        NULL,
    [skill_level_id]    BIGINT        NULL,
    [creation_at]       DATETIME2 (7) NULL,
    [modified_at]       DATETIME2 (7) NULL,
    [created_by]        BIGINT        NULL,
    [modified_by]       BIGINT        NULL
);
GO

