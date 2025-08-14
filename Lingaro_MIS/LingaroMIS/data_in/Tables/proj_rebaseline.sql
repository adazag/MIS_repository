CREATE TABLE [data_in].[proj_rebaseline] (
    [id]          BIGINT        NULL,
    [project_id]  BIGINT        NULL,
    [reason_id]   BIGINT        NULL,
    [day_date]    DATE          NULL,
    [created_by]  BIGINT        NULL,
    [modified_by] BIGINT        NULL,
    [creation_at] DATETIME2 (7) NULL,
    [modified_at] DATETIME2 (7) NULL
);
GO

