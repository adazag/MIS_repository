CREATE TABLE [data_in].[valuation_change_log_history] (
    [id]                   BIGINT          NULL,
    [valuation_id]         BIGINT          NULL,
    [valuation_version_id] BIGINT          NULL,
    [valuation_number]     INT             NULL,
    [comment]              NVARCHAR (2000) NULL,
    [log]                  NVARCHAR (2000) NULL,
    [change_at]            DATETIME2 (7)   NULL,
    [change_by]            BIGINT          NULL
);
GO

