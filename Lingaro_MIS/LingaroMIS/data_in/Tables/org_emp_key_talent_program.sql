CREATE TABLE [data_in].[org_emp_key_talent_program] (
    [id]           BIGINT         NULL,
    [employee_id]  BIGINT         NULL,
    [year]         INT            NULL,
    [creation_at]  DATETIME2 (7)  NULL,
    [modified_at]  DATETIME2 (7)  NULL,
    [created_by]   BIGINT         NULL,
    [modified_by]  BIGINT         NULL,
    [leave_reason] NVARCHAR (100) NULL
);
GO

