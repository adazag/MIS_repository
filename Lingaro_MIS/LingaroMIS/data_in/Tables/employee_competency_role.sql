CREATE TABLE [data_in].[employee_competency_role] (
    [id]                 BIGINT         NULL,
    [employee_id]        BIGINT         NULL,
    [priority]           INT            NULL,
    [level]              INT            NULL,
    [creation_at]        DATETIME2 (7)  NULL,
    [modified_at]        DATETIME2 (7)  NULL,
    [created_by]         BIGINT         NULL,
    [modified_by]        BIGINT         NULL,
    [preference]         NVARCHAR (100) NULL,
    [competency_role_id] BIGINT         NULL,
    [seniority_id]       BIGINT         NULL
);
GO

