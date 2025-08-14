CREATE TABLE [data_in].[org_working_day_tview] (
    [day_date]          DATE            NULL,
    [month_name]        NVARCHAR (4000) NULL,
    [week_name]         VARCHAR (13)    NULL,
    [split_week_number] VARCHAR (15)    NULL,
    [calendar_id]       BIGINT          NULL,
    [month_cnt]         INT             NULL,
    [week_cnt]          INT             NULL,
    [week_cnt_in_split] INT             NULL
);
GO

