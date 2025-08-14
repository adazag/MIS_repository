CREATE TABLE [data_in].[new_taxonomy_competency] (
    [id]                    BIGINT         NULL,
    [name]                  NVARCHAR (100) NULL,
    [competency_manager_id] BIGINT         NULL,
    [creation_at]           DATETIME2 (7)  NULL,
    [modified_at]           DATETIME2 (7)  NULL,
    [created_by]            BIGINT         NULL,
    [modified_by]           BIGINT         NULL,
    [team_id]               BIGINT         NULL
);
GO

