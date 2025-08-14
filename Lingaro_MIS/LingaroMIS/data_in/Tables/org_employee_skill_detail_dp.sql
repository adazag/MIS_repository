CREATE TABLE [data_in].[org_employee_skill_detail_dp] (
    [id]                BIGINT        NULL,
    [employee_id]       BIGINT        NULL,
    [skill_detail_id]   BIGINT        NULL,
    [proficiency_level] INT           NULL,
    [creation_at]       DATETIME2 (7) NULL,
    [modified_at]       DATETIME2 (7) NULL,
    [created_by]        BIGINT        NULL,
    [modified_by]       BIGINT        NULL
);
GO

