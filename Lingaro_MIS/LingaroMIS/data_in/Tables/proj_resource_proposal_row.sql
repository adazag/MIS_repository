CREATE TABLE [data_in].[proj_resource_proposal_row] (
    [id]                          BIGINT          NULL,
    [resource_proposal_id]        BIGINT          NULL,
    [employee_id]                 BIGINT          NULL,
    [role_id]                     BIGINT          NULL,
    [seniority_id]                BIGINT          NULL,
    [cost]                        DECIMAL (19, 2) NULL,
    [creation_at]                 DATETIME2 (7)   NULL,
    [modified_at]                 DATETIME2 (7)   NULL,
    [created_by]                  BIGINT          NULL,
    [modified_by]                 BIGINT          NULL,
    [competency_id]               BIGINT          NULL,
    [work_for_client_allowed_ind] BIT             NULL
);
GO

