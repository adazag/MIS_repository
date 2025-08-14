CREATE TABLE [data_in].[org_role_aspect] (
    [id]            BIGINT         NULL,
    [name]          NVARCHAR (200) NULL,
    [competency_id] BIGINT         NULL,
    [role_id]       BIGINT         NULL,
    [seniority_id]  BIGINT         NULL,
    [active_ind]    BIT            NULL,
    [creation_at]   DATETIME2 (7)  NULL,
    [modified_at]   DATETIME2 (7)  NULL,
    [created_by]    BIGINT         NULL,
    [modified_by]   BIGINT         NULL
);
GO

