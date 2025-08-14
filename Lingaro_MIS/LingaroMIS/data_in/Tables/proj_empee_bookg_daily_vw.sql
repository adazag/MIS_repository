CREATE TABLE [data_in].[proj_empee_bookg_daily_vw] (
    [employee_id]          BIGINT          NULL,
    [location_id]          BIGINT          NULL,
    [project_id]           BIGINT          NULL,
    [project_name]         NVARCHAR (1000) NULL,
    [first_day_of_week]    DATE            NULL,
    [splitted_week_number] VARCHAR (15)    NULL,
    [day_date]             DATE            NULL,
    [month_name]           NVARCHAR (4000) NULL,
    [booking_percentage]   DECIMAL (13, 5) NULL,
    [booking_man_days]     DECIMAL (16, 8) NULL,
    [booking_hours]        DECIMAL (18, 8) NULL,
    [week_cnt_in_split]    INT             NULL,
    [month_cnt]            INT             NULL,
    [status]               NVARCHAR (20)   NULL,
    [criticality]          NVARCHAR (20)   NULL,
    [comment]              NVARCHAR (4000) NULL,
    [competency_id]        BIGINT          NULL,
    [role_id]              BIGINT          NULL,
    [seniority_id]         BIGINT          NULL,
    [time_off_ind]         BIT             NULL
);
GO

