CREATE TABLE [data_in].[fin_project_additional_fund] (
    [id]                BIGINT          NULL,
    [group_id]          BIGINT          NULL,
    [fund_type_code]    NVARCHAR (10)   NULL,
    [balance_ind]       BIT             NULL,
    [project_id]        BIGINT          NULL,
    [source_project_id] BIGINT          NULL,
    [description]       NVARCHAR (500)  NULL,
    [day_date]          DATE            NULL,
    [currency_code]     NVARCHAR (3)    NULL,
    [fund_amount]       DECIMAL (19, 2) NULL,
    [fund_gross_amount] DECIMAL (19, 2) NULL,
    [creation_at]       DATETIME2 (7)   NULL,
    [modified_at]       DATETIME2 (7)   NULL,
    [created_by]        BIGINT          NULL,
    [modified_by]       BIGINT          NULL
);
GO

