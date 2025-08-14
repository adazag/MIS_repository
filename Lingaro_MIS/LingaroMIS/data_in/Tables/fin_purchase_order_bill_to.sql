CREATE TABLE [data_in].[fin_purchase_order_bill_to] (
    [id]                BIGINT         NULL,
    [bill_to]           NVARCHAR (100) NULL,
    [payment_terms]     NVARCHAR (100) NULL,
    [invoicing_address] NVARCHAR (300) NULL,
    [delivery_address]  NVARCHAR (300) NULL,
    [country_name]      NVARCHAR (300) NULL,
    [creation_at]       DATETIME2 (7)  NULL,
    [modified_at]       DATETIME2 (7)  NULL,
    [created_by]        BIGINT         NULL,
    [modified_by]       BIGINT         NULL
);
GO

