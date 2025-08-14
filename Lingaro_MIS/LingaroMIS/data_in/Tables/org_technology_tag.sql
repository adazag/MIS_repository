CREATE TABLE [data_in].[org_technology_tag] (
    [id]            BIGINT         NULL,
    [technology_id] BIGINT         NULL,
    [tag_type_id]   BIGINT         NULL,
    [tag_value]     NVARCHAR (100) NULL,
    [creation_at]   DATETIME2 (7)  NULL,
    [modified_at]   DATETIME2 (7)  NULL,
    [created_by]    BIGINT         NULL,
    [modified_by]   BIGINT         NULL
);
GO

