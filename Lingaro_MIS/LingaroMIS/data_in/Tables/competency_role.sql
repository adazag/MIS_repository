CREATE TABLE [data_in].[competency_role] (
    [id]               BIGINT          NOT NULL,
    [competency]       NVARCHAR (1000) NULL,
    [family]           NVARCHAR (1000) NULL,
    [role]             NVARCHAR (1000) NULL,
    [seniority]        NVARCHAR (100)  NULL,
    [active_ind]       BIT             NULL,
    [creation_at]      DATETIME2 (7)   NULL,
    [modified_at]      DATETIME2 (7)   NULL,
    [created_by]       BIGINT          NULL,
    [modified_by]      BIGINT          NULL,
    [country_id]       BIGINT          NULL,
    [competency_id]    BIGINT          NULL,
    [role_id]          BIGINT          NULL,
    [seniority_id]     BIGINT          NULL,
    [spoc_employee_id] BIGINT          NULL
);
GO

