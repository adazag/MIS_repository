CREATE TABLE [data_in].[org_soft_skill] (
    [id]               BIGINT          NULL,
    [name]             NVARCHAR (100)  NULL,
    [skill_type_id]    BIGINT          NULL,
    [creation_at]      DATETIME2 (7)   NULL,
    [modified_at]      DATETIME2 (7)   NULL,
    [created_by]       BIGINT          NULL,
    [modified_by]      BIGINT          NULL,
    [description_link] NVARCHAR (2000) NULL,
    [category_id]      BIGINT          NULL
);
GO

