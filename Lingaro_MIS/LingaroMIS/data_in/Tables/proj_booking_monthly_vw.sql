CREATE TABLE [data_in].[proj_booking_monthly_vw] (
    [employee_id]        BIGINT          NULL,
    [location_id]        BIGINT          NULL,
    [project_id]         BIGINT          NULL,
    [project_name]       NVARCHAR (1000) NULL,
    [time_off_ind]       BIT             NULL,
    [month_name]         NVARCHAR (4000) NULL,
    [first_day_of_month] DATE            NULL,
    [status]             NVARCHAR (20)   NULL,
    [criticality]        NVARCHAR (20)   NULL,
    [competency_id]      BIGINT          NULL,
    [role_id]            BIGINT          NULL,
    [seniority_id]       BIGINT          NULL,
    [comment]            NVARCHAR (4000) NULL,
    [booking_man_days]   DECIMAL (38, 8) NULL,
    [working_days_cnt]   INT             NULL,
    [booking_percentage] DECIMAL (38, 6) NULL,
    [booking_hours]      DECIMAL (38, 6) NULL
);
GO

