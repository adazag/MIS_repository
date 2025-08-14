CREATE TABLE [data_in].[fin_purchase_order_project_mapping] (
    [id]              BIGINT          NULL,
    [po_id]           BIGINT          NULL,
    [project_id]      BIGINT          NULL,
    [assigned_amount] DECIMAL (19, 2) NULL,
    [creation_at]     DATETIME2 (7)   NULL,
    [modified_at]     DATETIME2 (7)   NULL,
    [created_by]      BIGINT          NULL,
    [modified_by]     BIGINT          NULL
);
GO

