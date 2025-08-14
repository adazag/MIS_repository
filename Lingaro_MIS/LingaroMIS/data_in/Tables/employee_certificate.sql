CREATE TABLE [data_in].[employee_certificate] (
    [id]             BIGINT          NULL,
    [employee_id]    BIGINT          NULL,
    [certificate_id] BIGINT          NULL,
    [expiry_date]    DATE            NULL,
    [creation_at]    DATETIME2 (7)   NULL,
    [modified_at]    DATETIME2 (7)   NULL,
    [created_by]     BIGINT          NULL,
    [modified_by]    BIGINT          NULL,
    [start_date]     DATE            NULL,
    [end_date]       DATE            NULL,
    [url]            NVARCHAR (3000) NULL
);
GO

