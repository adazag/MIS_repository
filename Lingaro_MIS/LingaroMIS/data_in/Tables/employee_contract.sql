CREATE TABLE [data_in].[employee_contract] (
    [id]               BIGINT         NULL,
    [employee_id]      BIGINT         NULL,
    [contract_type_id] BIGINT         NULL,
    [legal_entity_id]  BIGINT         NULL,
    [start_date]       DATE           NULL,
    [end_date]         DATE           NULL,
    [creation_at]      DATETIME2 (7)  NULL,
    [modified_at]      DATETIME2 (7)  NULL,
    [created_by]       BIGINT         NULL,
    [modified_by]      BIGINT         NULL,
    [vendor_name]      NVARCHAR (500) NULL
);
GO

