CREATE TABLE [data_in].[org_emp_work_experience_industry_knowledge] (
    [id]                          BIGINT        NULL,
    [employee_work_experience_id] BIGINT        NULL,
    [industry_knowledge_id]       BIGINT        NULL,
    [creation_at]                 DATETIME2 (7) NULL,
    [modified_at]                 DATETIME2 (7) NULL,
    [created_by]                  BIGINT        NULL,
    [modified_by]                 BIGINT        NULL
);
GO

