CREATE TABLE [data_in].[proj_blockade] (
    [id]                   BIGINT          NULL,
    [employee_id]          BIGINT          NULL,
    [project_id]           BIGINT          NULL,
    [week_number]          NVARCHAR (10)   NULL,
    [start_date]           DATE            NULL,
    [end_date]             DATE            NULL,
    [percentage]           DECIMAL (12, 4) NULL,
    [man_days]             DECIMAL (12, 2) NULL,
    [hours]                DECIMAL (12, 2) NULL,
    [creation_at]          DATETIME2 (7)   NULL,
    [modified_at]          DATETIME2 (7)   NULL,
    [created_by]           BIGINT          NULL,
    [modified_by]          BIGINT          NULL,
    [competency_id]        BIGINT          NULL,
    [role_id]              BIGINT          NULL,
    [seniority_id]         BIGINT          NULL,
    [resource_proposal_id] BIGINT          NULL,
    [valid_till]           DATETIME2 (7)   NULL
);
GO

