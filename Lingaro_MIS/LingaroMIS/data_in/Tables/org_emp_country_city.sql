CREATE TABLE [data_in].[org_emp_country_city] (
    [id]          BIGINT        NULL,
    [employee_id] BIGINT        NULL,
    [country_id]  BIGINT        NULL,
    [city_id]     BIGINT        NULL,
    [start_date]  DATE          NULL,
    [end_date]    DATE          NULL,
    [creation_at] DATETIME2 (7) NULL,
    [modified_at] DATETIME2 (7) NULL,
    [created_by]  BIGINT        NULL,
    [modified_by] BIGINT        NULL
);
GO

