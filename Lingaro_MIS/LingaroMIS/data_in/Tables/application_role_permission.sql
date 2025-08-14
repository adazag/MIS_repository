CREATE TABLE [data_in].[application_role_permission] (
    [id]              BIGINT         NULL,
    [role_name]       NVARCHAR (40)  NULL,
    [permission_name] NVARCHAR (200) NULL,
    [creation_at]     DATETIME2 (7)  NULL,
    [modified_at]     DATETIME2 (7)  NULL,
    [created_by]      BIGINT         NULL,
    [modified_by]     BIGINT         NULL
);
GO

