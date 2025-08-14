CREATE TABLE [data_in].[client_employee_rate] (
    [id]                  BIGINT          NULL,
    [employee_id]         BIGINT          NULL,
    [client_id]           BIGINT          NULL,
    [rate]                DECIMAL (12, 2) NULL,
    [rate_start_date]     DATE            NULL,
    [rate_end_date]       DATE            NULL,
    [currency_code]       NVARCHAR (3)    NULL,
    [client_rate_id]      BIGINT          NULL,
    [creation_at]         DATETIME2 (7)   NULL,
    [modified_at]         DATETIME2 (7)   NULL,
    [created_by]          BIGINT          NULL,
    [modified_by]         BIGINT          NULL,
    [client_rate_card_id] BIGINT          NULL
);
GO

