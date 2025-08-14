CREATE TABLE [data_in].[fin_purchase_order] (
    [id]                  BIGINT          NULL,
    [client_id]           BIGINT          NULL,
    [client_po_code]      NVARCHAR (30)   NULL,
    [po_name]             NVARCHAR (200)  NULL,
    [comment]             NVARCHAR (500)  NULL,
    [currency_code]       NVARCHAR (3)    NULL,
    [available_amount]    DECIMAL (19, 2) NULL,
    [old_po_bill_to_text] NVARCHAR (100)  NULL,
    [valid_through_date]  DATE            NULL,
    [bill_to_id]          BIGINT          NULL,
    [group_po_ind]        BIT             NULL,
    [legal_entity_id]     BIGINT          NULL,
    [creation_at]         DATETIME2 (7)   NULL,
    [modified_at]         DATETIME2 (7)   NULL,
    [created_by]          BIGINT          NULL,
    [modified_by]         BIGINT          NULL
);
GO

