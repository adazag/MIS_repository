CREATE TABLE [data_in].[org_emp_education] (
    [id]                BIGINT          NULL,
    [employee_id]       BIGINT          NULL,
    [university_name]   NVARCHAR (1000) NULL,
    [degree_field_name] NVARCHAR (1000) NULL,
    [start_date]        DATE            NULL,
    [end_date]          DATE            NULL,
    [creation_at]       DATETIME2 (7)   NULL,
    [modified_at]       DATETIME2 (7)   NULL,
    [created_by]        BIGINT          NULL,
    [modified_by]       BIGINT          NULL
);
GO

