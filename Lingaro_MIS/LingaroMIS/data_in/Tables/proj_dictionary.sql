CREATE TABLE [data_in].[proj_dictionary] (
    [id]                      BIGINT         NULL,
    [name]                    NVARCHAR (255) NULL,
    [type]                    NVARCHAR (255) NULL,
    [existing_dictionary_ind] BIT            NULL,
    [creation_at]             DATETIME2 (7)  NULL,
    [modified_at]             DATETIME2 (7)  NULL,
    [created_by]              BIGINT         NULL,
    [modified_by]             BIGINT         NULL
);
GO

