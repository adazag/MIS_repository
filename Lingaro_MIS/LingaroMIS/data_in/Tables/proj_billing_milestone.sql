CREATE TABLE [data_in].[proj_billing_milestone] (
    [id]                                 BIGINT          NULL,
    [project_id]                         BIGINT          NULL,
    [billing_date]                       DATE            NULL,
    [delivery_date]                      DATE            NULL,
    [bm_name]                            NVARCHAR (500)  NULL,
    [po_id]                              BIGINT          NULL,
    [amount_before_discount]             DECIMAL (19, 2) NULL,
    [additional_discount_amount]         DECIMAL (19, 2) NULL,
    [amount_to_invoice]                  DECIMAL (19, 2) NULL,
    [can_be_billed_ind]                  BIT             NULL,
    [wont_be_billed_ind]                 BIT             NULL,
    [currency_code]                      NVARCHAR (3)    NULL,
    [comment]                            NVARCHAR (4000) NULL,
    [crr_bm_unique_code]                 NVARCHAR (50)   NULL,
    [crr_invoice_id]                     BIGINT          NULL,
    [cancel_billing_reason]              NVARCHAR (4000) NULL,
    [reinvoice_ind]                      BIT             NULL,
    [change_request_ind]                 BIT             NULL,
    [bm_not_contracted_ind]              BIT             NULL,
    [bm_contracted_in_ongoing_month_ind] BIT             NULL,
    [creation_at]                        DATETIME2 (7)   NULL,
    [modified_at]                        DATETIME2 (7)   NULL,
    [created_by]                         BIGINT          NULL,
    [modified_by]                        BIGINT          NULL,
    [approval_date]                      DATE            NULL
);
GO

