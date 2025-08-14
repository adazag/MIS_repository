CREATE TABLE [data_in].[org_leaver_reason] (
    [id]            BIGINT         NULL,
    [name]          NVARCHAR (200) NULL,
    [is_active_ind] BIT            NULL,
    [creation_at]   DATETIME2 (7)  NULL,
    [modified_at]   DATETIME2 (7)  NULL,
    [created_by]    BIGINT         NULL,
    [modified_by]   BIGINT         NULL
);
GO

