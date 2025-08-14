CREATE TABLE [data_in].[proj_resource_row_industry_knowledge] (
    [id]                    BIGINT        NULL,
    [resource_row_id]       BIGINT        NULL,
    [industry_knowledge_id] BIGINT        NULL,
    [required_ind]          BIT           NULL,
    [creation_at]           DATETIME2 (7) NULL,
    [modified_at]           DATETIME2 (7) NULL,
    [created_by]            BIGINT        NULL,
    [modified_by]           BIGINT        NULL
);
GO

