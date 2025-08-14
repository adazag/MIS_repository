CREATE TABLE [data_in].[org_employee_role_proficiency_dp] (
    [id]           BIGINT        NULL,
    [employee_id]  BIGINT        NULL,
    [role_id]      BIGINT        NULL,
    [seniority_id] BIGINT        NULL,
    [creation_at]  DATETIME2 (7) NULL,
    [modified_at]  DATETIME2 (7) NULL,
    [created_by]   BIGINT        NULL,
    [modified_by]  BIGINT        NULL
);
GO

