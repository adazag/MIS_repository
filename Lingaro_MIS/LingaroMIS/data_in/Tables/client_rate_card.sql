CREATE TABLE [data_in].[client_rate_card] (
    [id]             BIGINT         NULL,
    [client_id]      BIGINT         NULL,
    [name]           NVARCHAR (200) NULL,
    [is_active_ind]  BIT            NULL,
    [creation_at]    DATETIME2 (7)  NULL,
    [modified_at]    DATETIME2 (7)  NULL,
    [created_by]     BIGINT         NULL,
    [modified_by]    BIGINT         NULL,
    [effective_date] DATE           NULL,
    [currency_code]  NVARCHAR (3)   NULL
);
GO

