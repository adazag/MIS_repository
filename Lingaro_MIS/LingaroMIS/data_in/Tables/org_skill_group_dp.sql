CREATE TABLE [data_in].[org_skill_group_dp] (
    [id]          BIGINT         NULL,
    [name]        NVARCHAR (255) NULL,
    [comment]     NVARCHAR (MAX) NULL,
    [status]      NVARCHAR (50)  NULL,
    [owner_id]    BIGINT         NULL,
    [creation_at] DATETIME2 (7)  NULL,
    [modified_at] DATETIME2 (7)  NULL,
    [created_by]  BIGINT         NULL,
    [modified_by] BIGINT         NULL
);
GO

