CREATE TABLE [data_in].[org_emp_potential_role_aspect] (
    [id]             BIGINT        NULL,
    [employee_id]    BIGINT        NULL,
    [role_aspect_id] BIGINT        NULL,
    [seniority_id]   BIGINT        NULL,
    [creation_at]    DATETIME2 (7) NULL,
    [modified_at]    DATETIME2 (7) NULL,
    [created_by]     BIGINT        NULL,
    [modified_by]    BIGINT        NULL
);
GO

