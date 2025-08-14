CREATE TABLE [data_in].[org_emp_fte] (
    [id]           BIGINT         NULL,
    [employee_id]  BIGINT         NULL,
    [start_date]   DATE           NULL,
    [end_date]     DATE           NULL,
    [fte]          DECIMAL (6, 3) NULL,
    [created_by2]  NVARCHAR (300) NULL,
    [creation_at]  DATETIME2 (7)  NULL,
    [modified_by2] NVARCHAR (300) NULL,
    [modified_at]  DATETIME2 (7)  NULL,
    [created_by]   BIGINT         NULL,
    [modified_by]  BIGINT         NULL
);
GO

