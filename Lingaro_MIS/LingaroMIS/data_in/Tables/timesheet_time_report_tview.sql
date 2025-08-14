CREATE TABLE [data_in].[timesheet_time_report_tview] (
    [client_id]                           BIGINT          NULL,
    [client_name]                         NVARCHAR (1000) NULL,
    [project_id]                          BIGINT          NULL,
    [project_name]                        NVARCHAR (1000) NULL,
    [employee_id]                         BIGINT          NULL,
    [employee_full_name]                  NVARCHAR (201)  NULL,
    [day_date]                            DATE            NULL,
    [month_date]                          VARCHAR (7)     NULL,
    [timesheet_code_id]                   BIGINT          NULL,
    [timesheet_version_project_code_type] NVARCHAR (100)  NULL,
    [timesheet_code_name]                 NVARCHAR (1000) NULL,
    [timesheet_code]                      NVARCHAR (2000) NULL,
    [multiplier]                          DECIMAL (21, 3) NULL,
    [ip_code]                             BIT             NULL,
    [minutes]                             BIGINT          NULL,
    [hours]                               DECIMAL (13, 5) NULL,
    [days]                                DECIMAL (13, 5) NULL,
    [comment]                             NVARCHAR (4000) NULL,
    [timeoff]                             BIT             NULL,
    [status]                              NVARCHAR (100)  NULL,
    [competency_id]                       BIGINT          NULL,
    [new_taxonomy_role_id]                BIGINT          NULL,
    [seniority_id]                        BIGINT          NULL
);
GO

