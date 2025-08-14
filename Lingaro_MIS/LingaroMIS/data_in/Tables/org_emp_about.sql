CREATE TABLE [data_in].[org_emp_about] (
    [id]          BIGINT          NULL,
    [employee_id] BIGINT          NULL,
    [description] NVARCHAR (4000) NULL,
    [creation_at] DATETIME2 (7)   NULL,
    [modified_at] DATETIME2 (7)   NULL,
    [created_by]  BIGINT          NULL,
    [modified_by] BIGINT          NULL
);
GO

