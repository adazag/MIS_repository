CREATE TABLE [data_in].[timesheet_utilization_report_tview] (
    [employee_id]            BIGINT          NULL,
    [employee_full_name]     NVARCHAR (201)  NULL,
    [line_manager_id]        BIGINT          NULL,
    [line_manager_full_name] NVARCHAR (201)  NULL,
    [organization_unit_id]   BIGINT          NULL,
    [organization_unit_name] NVARCHAR (100)  NULL,
    [start_date]             DATE            NULL,
    [version_number]         INT             NULL,
    [status]                 NVARCHAR (100)  NULL,
    [due_date]               DATETIME2 (7)   NULL,
    [close_date]             DATETIME2 (7)   NULL,
    [total_hours]            DECIMAL (10, 2) NULL,
    [client_work_hours]      DECIMAL (10, 2) NULL,
    [utilization]            DECIMAL (10, 2) NULL,
    [country]                NVARCHAR (200)  NULL,
    [city]                   NVARCHAR (200)  NULL,
    [bu_name]                NVARCHAR (100)  NULL
);
GO

