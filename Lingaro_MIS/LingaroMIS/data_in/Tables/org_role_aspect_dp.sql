CREATE TABLE [data_in].[org_role_aspect_dp] (
    [id]          BIGINT         NULL,
    [role_id]     BIGINT         NULL,
    [name]        NVARCHAR (255) NULL,
    [status]      NVARCHAR (50)  NULL,
    [creation_at] DATETIME2 (7)  NULL,
    [modified_at] DATETIME2 (7)  NULL,
    [created_by]  BIGINT         NULL,
    [modified_by] BIGINT         NULL
);
GO

