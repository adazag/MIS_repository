CREATE TABLE [data_in].[competency_rate_card] (
    [id]             BIGINT         NOT NULL,
    [competency_id]  BIGINT         NULL,
    [name]           NVARCHAR (200) NOT NULL,
    [is_active_ind]  BIT            NULL,
    [creation_at]    DATETIME2 (7)  NULL,
    [modified_at]    DATETIME2 (7)  NULL,
    [created_by]     BIGINT         NULL,
    [modified_by]    BIGINT         NULL,
    [effective_date] DATE           NULL,
    [start_date]     DATE           NULL,
    [end_date]       DATE           NULL
);
GO

