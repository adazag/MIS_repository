CREATE TABLE [data_in].[tmsht] (
    [id]          BIGINT        NULL,
    [employee_id] BIGINT        NULL,
    [start_date]  DATE          NULL,
    [end_date]    DATE          NULL,
    [due_date]    DATETIME2 (7) NULL,
    [week_number] NVARCHAR (5)  NULL
);
GO

