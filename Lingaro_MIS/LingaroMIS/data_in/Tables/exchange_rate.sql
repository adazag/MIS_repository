CREATE TABLE [data_in].[exchange_rate] (
    [id]                  BIGINT          NOT NULL,
    [base_currency_code]  NVARCHAR (3)    NULL,
    [exchange_rate]       DECIMAL (19, 4) NULL,
    [start_date]          DATE            NOT NULL,
    [end_date]            DATE            NULL,
    [creation_at]         DATETIME2 (7)   NULL,
    [modified_at]         DATETIME2 (7)   NULL,
    [created_by]          BIGINT          NULL,
    [modified_by]         BIGINT          NULL,
    [quote_currency_code] NVARCHAR (3)    NULL,
    [inverse_ind]         BIT             NULL
);
GO

