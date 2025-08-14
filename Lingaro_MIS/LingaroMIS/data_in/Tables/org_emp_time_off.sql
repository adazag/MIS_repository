CREATE TABLE [data_in].[org_emp_time_off] (
    [id]                                BIGINT          NULL,
    [request_id]                        BIGINT          NULL,
    [employee_id]                       BIGINT          NULL,
    [day_date]                          DATE            NULL,
    [approval_status]                   NVARCHAR (100)  NULL,
    [approver_id]                       BIGINT          NULL,
    [created_at]                        DATETIME2 (7)   NULL,
    [time_off_type]                     NVARCHAR (100)  NULL,
    [time_off_minutes]                  BIGINT          NULL,
    [time_off_comment]                  NVARCHAR (1000) NULL,
    [approver_action_time]              DATETIME2 (7)   NULL,
    [requested_minutes]                 BIGINT          NULL,
    [required_permission_name]          NVARCHAR (300)  NULL,
    [next_action_candidates]            NVARCHAR (1000) NULL,
    [assigned_minutes]                  BIGINT          NULL,
    [creation_at]                       DATETIME2 (7)   NULL,
    [modified_at]                       DATETIME2 (7)   NULL,
    [created_by]                        BIGINT          NULL,
    [modified_by]                       BIGINT          NULL,
    [overtime_compensation_for_month]   DATE            NULL,
    [overtime_compensation_settled_ind] BIT             NULL,
    [start_date_time]                   DATETIME2 (7)   NULL,
    [end_date_time]                     DATETIME2 (7)   NULL
);
GO

