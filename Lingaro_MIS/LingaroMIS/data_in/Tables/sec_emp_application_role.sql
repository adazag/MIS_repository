CREATE TABLE [data_in].[sec_emp_application_role] (
    [id]                     BIGINT        NULL,
    [employee_id]            BIGINT        NULL,
    [start_date]             DATE          NULL,
    [end_date]               DATE          NULL,
    [created_at]             DATETIME2 (7) NULL,
    [granted_by_employee_id] BIGINT        NULL,
    [role_name]              NVARCHAR (40) NULL,
    [creation_at]            DATETIME2 (7) NULL,
    [modified_at]            DATETIME2 (7) NULL,
    [created_by]             BIGINT        NULL,
    [modified_by]            BIGINT        NULL,
    [assignment_type]        NVARCHAR (20) NULL
);
GO

