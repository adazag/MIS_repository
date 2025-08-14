CREATE TABLE [data_in].[proj_tmsht_code] (
    [timesheet_code]            NVARCHAR (2000) NULL,
    [timesheet_code_name]       NVARCHAR (1000) NULL,
    [project_id]                BIGINT          NULL,
    [comment_required]          BIT             NULL,
    [valid_from]                DATE            NULL,
    [valid_to]                  DATE            NULL,
    [multiplier]                DECIMAL (6, 3)  NULL,
    [stand_by]                  BIT             NULL,
    [ip_code]                   BIT             NULL,
    [change_timestamp]          DATETIME2 (7)   NULL,
    [timesheet_code_id]         BIGINT          NULL,
    [non_billable_ind]          BIT             NULL,
    [jira_code]                 BIT             NULL,
    [DC_TEAM]                   BIGINT          NULL,
    [creation_at]               DATETIME2 (7)   NULL,
    [modified_at]               DATETIME2 (7)   NULL,
    [created_by]                BIGINT          NULL,
    [modified_by]               BIGINT          NULL,
    [estimated_hours]           DECIMAL (19, 2) NULL,
    [estimated_cost]            DECIMAL (19, 2) NULL,
    [estimated_cost_currency]   NVARCHAR (3)    NULL,
    [visible_to_team_on_budget] BIT             NULL,
    [overtime_approved_ind]     BIT             NULL
);
GO

