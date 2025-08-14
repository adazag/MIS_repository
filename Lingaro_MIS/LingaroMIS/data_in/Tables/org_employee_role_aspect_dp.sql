CREATE TABLE [data_in].[org_employee_role_aspect_dp] (
    [id]             BIGINT        NULL,
    [employee_id]    BIGINT        NULL,
    [role_aspect_id] BIGINT        NULL,
    [seniority_id]   BIGINT        NULL,
    [creation_at]    DATETIME2 (7) NULL,
    [modified_at]    DATETIME2 (7) NULL,
    [created_by]     BIGINT        NULL,
    [modified_by]    BIGINT        NULL,
    [start_date]     DATE          NULL,
    [end_date]       DATE          NULL
);
GO

