CREATE TABLE [data_in].[org_used_time_off_limit_report_vw] (
    [id]                        BIGINT          NULL,
    [employee_full_name]        NVARCHAR (201)  NULL,
    [employee_id]               BIGINT          NULL,
    [start_date]                DATE            NULL,
    [end_date]                  DATE            NULL,
    [time_off_limit]            DECIMAL (10, 2) NULL,
    [used_limit]                DECIMAL (10, 2) NULL,
    [available_limit_hours]     DECIMAL (10, 2) NULL,
    [available_limit_days]      DECIMAL (10, 2) NULL,
    [time_off_type]             NVARCHAR (100)  NULL,
    [lm_id]                     BIGINT          NULL,
    [lm_full_name]              NVARCHAR (201)  NULL,
    [fm_full_name]              NVARCHAR (201)  NULL,
    [old_sulu_ind]              BIT             NULL,
    [org_unit_name]             NVARCHAR (100)  NULL,
    [bu_name]                   NVARCHAR (100)  NULL,
    [legal_entity]              NVARCHAR (100)  NULL,
    [contract_type]             NVARCHAR (100)  NULL,
    [used_up_to_today]          DECIMAL (10, 2) NULL,
    [available_up_to_today]     DECIMAL (10, 2) NULL,
    [used_up_to_previous_month] DECIMAL (10, 2) NULL,
    [country]                   NVARCHAR (200)  NULL,
    [financial_equivalent]      NUMERIC (10, 2) NULL
);
GO

