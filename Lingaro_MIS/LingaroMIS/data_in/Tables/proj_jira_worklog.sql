CREATE TABLE [data_in].[proj_jira_worklog] (
    [jira_tenant_id]     BIGINT          NULL,
    [jira_project_id]    BIGINT          NULL,
    [jira_project_name]  NVARCHAR (1000) NULL,
    [employee_id]        BIGINT          NULL,
    [start_date]         DATE            NULL,
    [update_date]        DATE            NULL,
    [time_spent]         NVARCHAR (200)  NULL,
    [time_spent_seconds] BIGINT          NULL,
    [jira_worklog_id]    NVARCHAR (200)  NULL,
    [jira_issue_id]      NVARCHAR (200)  NULL,
    [jira_issue_key]     NVARCHAR (200)  NULL,
    [jira_comment]       NVARCHAR (2000) NULL,
    [stale]              BIT             NULL,
    [hibernate_version]  INT             NULL,
    [jira_issue_name]    NVARCHAR (1000) NULL
);
GO

