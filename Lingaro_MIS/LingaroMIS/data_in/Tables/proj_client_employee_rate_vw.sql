CREATE TABLE [data_in].[proj_client_employee_rate_vw] (
    [id]                    BIGINT          NULL,
    [employee_id]           BIGINT          NULL,
    [employee_full_name]    NVARCHAR (201)  NULL,
    [project_id]            BIGINT          NULL,
    [project_name]          NVARCHAR (1000) NULL,
    [client_id]             BIGINT          NULL,
    [client_name]           NVARCHAR (300)  NULL,
    [rate]                  DECIMAL (12, 2) NULL,
    [rate_start_date]       DATE            NULL,
    [rate_end_date]         DATE            NULL,
    [currency_code]         NVARCHAR (3)    NULL,
    [client_rate_id]        BIGINT          NULL,
    [client_rate_card_id]   BIGINT          NULL,
    [client_rate_card_name] NVARCHAR (200)  NULL,
    [comment]               NVARCHAR (4000) NULL,
    [is_manual_override]    BIT             NULL,
    [modified_at]           DATETIME2 (7)   NULL,
    [modified_by]           BIGINT          NULL,
    [creation_at]           DATETIME2 (7)   NULL,
    [created_by]            BIGINT          NULL,
    [modifiedy_by_employee] NVARCHAR (201)  NULL,
    [created_by_employee]   NVARCHAR (201)  NULL,
    [role_full_name]        NVARCHAR (2314) NULL,
    [current_rate_ind]      BIT             NULL
);
GO

