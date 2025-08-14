CREATE TABLE [data_in].[proj_resource_proposal_row_vw] (
    [id]                      BIGINT          NULL,
    [employee_id]             BIGINT          NULL,
    [employee_name]           NVARCHAR (201)  NULL,
    [competency_id]           BIGINT          NULL,
    [competency_name]         NVARCHAR (100)  NULL,
    [resource_proposal_id]    BIGINT          NULL,
    [resource_row_id]         BIGINT          NULL,
    [capacity_sufficient_ind] BIT             NULL,
    [resource_status]         NVARCHAR (100)  NULL,
    [client_id]               BIGINT          NULL,
    [client_name]             NVARCHAR (300)  NULL,
    [project_id]              BIGINT          NULL,
    [project_name]            NVARCHAR (1000) NULL,
    [status]                  NVARCHAR (100)  NULL,
    [on_hold_ind]             BIT             NULL,
    [creation_at]             DATETIME2 (7)   NULL,
    [modified_at]             DATETIME2 (7)   NULL,
    [created_by]              BIGINT          NULL,
    [created_by_employee]     NVARCHAR (201)  NULL,
    [modified_by]             BIGINT          NULL,
    [modified_by_employee]    NVARCHAR (201)  NULL,
    [overbooking_allowed_ind] BIT             NULL,
    [preference_type]         NVARCHAR (100)  NULL,
    [line_manager_id]         BIGINT          NULL,
    [line_manager]            NVARCHAR (201)  NULL
);
GO

