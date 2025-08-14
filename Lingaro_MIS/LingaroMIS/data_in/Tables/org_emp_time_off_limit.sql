CREATE TABLE [data_in].[org_emp_time_off_limit] (
    [id]                           BIGINT         NULL,
    [employee_id]                  BIGINT         NULL,
    [contract_id]                  BIGINT         NULL,
    [start_date]                   DATE           NULL,
    [end_date]                     DATE           NULL,
    [limit_minutes]                BIGINT         NULL,
    [used_minutes]                 BIGINT         NULL,
    [time_off_type]                NVARCHAR (100) NULL,
    [canceled]                     BIT            NULL,
    [creation_at]                  DATETIME2 (7)  NULL,
    [modified_at]                  DATETIME2 (7)  NULL,
    [old_sulu_ind]                 BIT            NULL,
    [created_by]                   BIGINT         NULL,
    [modified_by]                  BIGINT         NULL,
    [auto_generated]               BIT            NULL,
    [financial_equivalent_minutes] BIGINT         NULL
);
GO

