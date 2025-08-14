CREATE TABLE [data_in].[competency_rate] (
    [id]                      BIGINT          NOT NULL,
    [role_id]                 BIGINT          NOT NULL,
    [competency_id]           BIGINT          NOT NULL,
    [currency_code]           NVARCHAR (3)    NOT NULL,
    [rate_start_date]         DATE            NULL,
    [rate_end_date]           DATE            NULL,
    [rate]                    DECIMAL (12, 2) NOT NULL,
    [seniority_id]            BIGINT          NOT NULL,
    [country_id]              BIGINT          NOT NULL,
    [competency_rate_card_id] BIGINT          NOT NULL,
    [creation_at]             DATETIME2 (7)   NULL,
    [modified_at]             DATETIME2 (7)   NULL,
    [created_by]              BIGINT          NULL,
    [modified_by]             BIGINT          NULL,
    [hourly_rate]             DECIMAL (12, 2) NULL
);
GO

