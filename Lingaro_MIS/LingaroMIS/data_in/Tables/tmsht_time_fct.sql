CREATE TABLE [data_in].[tmsht_time_fct] (
    [timesheet_id]        BIGINT          NULL,
    [employee_id]         BIGINT          NULL,
    [start_date]          DATE            NULL,
    [end_date]            DATE            NULL,
    [timesheet_code_id]   BIGINT          NULL,
    [time_min_amt]        INT             NULL,
    [multiplier]          DECIMAL (6, 3)  NULL,
    [comment]             NVARCHAR (4000) NULL,
    [timesheet_code_name] NVARCHAR (1000) NULL
);
GO

