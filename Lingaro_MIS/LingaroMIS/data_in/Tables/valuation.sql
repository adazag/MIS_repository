CREATE TABLE [data_in].[valuation] (
    [id]                           BIGINT          NULL,
    [name]                         NVARCHAR (500)  NULL,
    [project_id]                   BIGINT          NULL,
    [invoicing_type_code]          NVARCHAR (3)    NULL,
    [owner_id]                     BIGINT          NULL,
    [client_id]                    BIGINT          NULL,
    [offer_currency_code]          NVARCHAR (3)    NULL,
    [creation_at]                  DATETIME2 (7)   NULL,
    [modified_at]                  DATETIME2 (7)   NULL,
    [created_by]                   BIGINT          NULL,
    [modified_by]                  BIGINT          NULL,
    [rate_card_id]                 BIGINT          NULL,
    [custom_exchange_rate]         DECIMAL (19, 4) NULL,
    [custom_exchange_rate_comment] NVARCHAR (1000) NULL,
    [opportunity_id]               BIGINT          NULL,
    [operational_owner_id]         BIGINT          NULL
);
GO

