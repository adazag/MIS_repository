CREATE TABLE [data_in].[open_timesheet_report] (
    [employee_id]            BIGINT         NULL,
    [employee_full_name]     NVARCHAR (201) NULL,
    [lm_id]                  BIGINT         NULL,
    [lm_full_name]           NVARCHAR (201) NULL,
    [timesheet_start_date]   DATE           NULL,
    [timesheet_end_date]     DATE           NULL,
    [timesheet_version]      INT            NULL,
    [week_number]            NVARCHAR (100) NULL,
    [organization_unit_name] NVARCHAR (100) NULL,
    [organization_unit_id]   BIGINT         NULL,
    [bu_name]                NVARCHAR (100) NULL,
    [country]                NVARCHAR (200) NULL,
    [city]                   NVARCHAR (200) NULL,
    [contract_type]          NVARCHAR (200) NULL,
    [email]                  NVARCHAR (150) NULL,
    [legal_entity]           NVARCHAR (200) NULL,
    [is_past_timesheet]      BIT            NULL
);
GO

