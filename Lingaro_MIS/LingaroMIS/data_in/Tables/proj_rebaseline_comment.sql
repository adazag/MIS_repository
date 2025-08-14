CREATE TABLE [data_in].[proj_rebaseline_comment] (
    [id]          BIGINT          NULL,
    [project_id]  BIGINT          NULL,
    [comment]     NVARCHAR (1000) NULL,
    [created_by]  BIGINT          NULL,
    [modified_by] BIGINT          NULL,
    [creation_at] DATETIME2 (7)   NULL,
    [modified_at] DATETIME2 (7)   NULL
);
GO

