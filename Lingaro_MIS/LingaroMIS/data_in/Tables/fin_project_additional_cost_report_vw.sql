CREATE TABLE [data_in].[fin_project_additional_cost_report_vw] (
    [id]                       BIGINT          NULL,
    [project_id]               BIGINT          NULL,
    [project_name]             NVARCHAR (1000) NULL,
    [description]              NVARCHAR (500)  NULL,
    [comment]                  NVARCHAR (500)  NULL,
    [cost_type_code]           NVARCHAR (10)   NULL,
    [cost_type_name]           NVARCHAR (100)  NULL,
    [currency_code]            NVARCHAR (3)    NULL,
    [day_date]                 DATE            NULL,
    [month_name]               NVARCHAR (4000) NULL,
    [funding_type_id]          BIGINT          NULL,
    [funding_type_name]        NVARCHAR (100)  NULL,
    [cost_source_id]           BIGINT          NULL,
    [cost_source_name]         NVARCHAR (100)  NULL,
    [cost_amount]              DECIMAL (19, 2) NULL,
    [cost_classification_id]   BIGINT          NULL,
    [cost_classification_name] NVARCHAR (200)  NULL,
    [modified_at]              DATETIME2 (7)   NULL,
    [modified_by]              BIGINT          NULL,
    [creation_at]              DATETIME2 (7)   NULL,
    [created_by]               BIGINT          NULL,
    [modifiedy_by_employee]    NVARCHAR (201)  NULL,
    [created_by_employee]      NVARCHAR (201)  NULL
);
GO

