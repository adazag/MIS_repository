CREATE TABLE [data_in].[timesheet_version_project_bench] (
    [id]                   BIGINT          NULL,
    [timesheet_version_id] BIGINT          NULL,
    [project_id]           BIGINT          NULL,
    [bench_bookings]       DECIMAL (14, 4) NULL,
    [bench_actuals]        DECIMAL (14, 4) NULL,
    [non_bench_actuals]    DECIMAL (14, 4) NULL
);
GO

