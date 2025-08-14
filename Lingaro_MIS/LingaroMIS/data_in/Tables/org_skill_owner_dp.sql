CREATE TABLE [data_in].[org_skill_owner_dp] (
    [id]          BIGINT         NULL,
    [name]        NVARCHAR (255) NULL,
    [description] NVARCHAR (MAX) NULL,
    [creation_at] DATETIME2 (7)  NULL,
    [modified_at] DATETIME2 (7)  NULL,
    [created_by]  BIGINT         NULL,
    [modified_by] BIGINT         NULL
);
GO

