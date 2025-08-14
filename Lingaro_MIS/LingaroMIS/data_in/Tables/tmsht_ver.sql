CREATE TABLE [data_in].[tmsht_ver] (
    [id]                  BIGINT          NULL,
    [timesheet_id]        BIGINT          NULL,
    [version_number]      INT             NULL,
    [status]              NVARCHAR (100)  NULL,
    [close_date]          DATETIME2 (7)   NULL,
    [legacy_timesheet_id] BIGINT          NULL,
    [changed_date]        DATETIME2 (7)   NULL,
    [reopen_reason]       NVARCHAR (4000) NULL,
    [last_version]        BIT             NULL,
    [hibernate_version]   INT             NULL,
    [last_closed]         BIT             NULL
);
GO

