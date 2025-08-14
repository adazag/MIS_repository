CREATE TABLE [data_in].[proj_internal_employee_rate] (
    [id]              BIGINT          NULL,
    [employee_id]     BIGINT          NULL,
    [project_id]      BIGINT          NULL,
    [currency_code]   NVARCHAR (3)    NULL,
    [rate_start_date] DATE            NULL,
    [rate_end_date]   DATE            NULL,
    [rate]            DECIMAL (12, 2) NULL,
    [comment]         NVARCHAR (4000) NULL,
    [creation_at]     DATETIME2 (7)   NULL,
    [modified_at]     DATETIME2 (7)   NULL,
    [created_by]      BIGINT          NULL,
    [modified_by]     BIGINT          NULL,
    [competency_id]   BIGINT          NULL,
    [role_id]         BIGINT          NULL,
    [seniority_id]    BIGINT          NULL
);
GO

