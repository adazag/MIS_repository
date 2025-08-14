CREATE TABLE [data_in].[proj_contract_vw] (
    [id]                       BIGINT          NULL,
    [name]                     NVARCHAR (1000) NULL,
    [project_id]               BIGINT          NULL,
    [type]                     NVARCHAR (100)  NULL,
    [client_contract_number]   NVARCHAR (200)  NULL,
    [internal_contract_number] NVARCHAR (200)  NULL,
    [sign_date]                DATE            NULL,
    [estimated_revenue]        DECIMAL (19, 2) NULL,
    [estimated_margin]         DECIMAL (14, 4) NULL,
    [estimated_cost]           DECIMAL (19, 2) NULL,
    [storage_link]             NVARCHAR (2000) NULL,
    [currency_code]            NVARCHAR (3)    NULL,
    [modified_at]              DATETIME2 (7)   NULL,
    [modified_by]              BIGINT          NULL,
    [creation_at]              DATETIME2 (7)   NULL,
    [created_by]               BIGINT          NULL,
    [modifiedy_by_employee]    NVARCHAR (201)  NULL,
    [created_by_employee]      NVARCHAR (201)  NULL,
    [valuation_id]             BIGINT          NULL,
    [version_number]           INT             NULL,
    [valuation_name]           NVARCHAR (500)  NULL,
    [delta_total_price]        DECIMAL (19, 2) NULL
);
GO

