CREATE TABLE [data_in].[proj_resource_row_soft_skill] (
    [id]              BIGINT        NULL,
    [resource_row_id] BIGINT        NULL,
    [soft_skill_id]   BIGINT        NULL,
    [priority_id]     BIGINT        NULL,
    [skill_level_id]  BIGINT        NULL,
    [required_ind]    BIT           NULL,
    [creation_at]     DATETIME2 (7) NULL,
    [modified_at]     DATETIME2 (7) NULL,
    [created_by]      BIGINT        NULL,
    [modified_by]     BIGINT        NULL
);
GO

