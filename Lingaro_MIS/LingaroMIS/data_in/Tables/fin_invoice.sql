CREATE TABLE [data_in].[fin_invoice] (
    [id]              BIGINT         NULL,
    [invoice_code]    NVARCHAR (20)  NULL,
    [invoice_comment] NVARCHAR (500) NULL,
    [issue_date]      DATE           NULL,
    [due_date]        DATE           NULL,
    [payment_id]      BIGINT         NULL,
    [delivery_date]   DATE           NULL,
    [creation_at]     DATETIME2 (7)  NULL,
    [modified_at]     DATETIME2 (7)  NULL,
    [created_by]      BIGINT         NULL,
    [modified_by]     BIGINT         NULL
);
GO

