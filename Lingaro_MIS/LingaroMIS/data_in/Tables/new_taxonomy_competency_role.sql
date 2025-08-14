CREATE TABLE [data_in].[new_taxonomy_competency_role] (
    [id]            BIGINT        NOT NULL,
    [competency_id] BIGINT        NULL,
    [role_id]       BIGINT        NULL,
    [creation_at]   DATETIME2 (7) NULL,
    [modified_at]   DATETIME2 (7) NULL,
    [created_by]    BIGINT        NULL,
    [modified_by]   BIGINT        NULL
);
GO

