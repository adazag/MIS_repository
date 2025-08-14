CREATE TABLE [data_in].[org_emp_old_role] (
    [id]          BIGINT          NULL,
    [employee_id] BIGINT          NULL,
    [role_name]   NVARCHAR (4000) NULL,
    [start_date]  DATE            NULL,
    [end_date]    DATE            NULL,
    [creation_at] DATETIME2 (7)   NULL,
    [modified_at] DATETIME2 (7)   NULL,
    [created_by]  BIGINT          NULL,
    [modified_by] BIGINT          NULL
);
GO

