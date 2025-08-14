CREATE TABLE [data_in].[proj_dictionary_entry] (
    [id]            BIGINT         NULL,
    [dictionary_id] BIGINT         NULL,
    [value]         NVARCHAR (255) NULL,
    [active_ind]    BIT            NULL,
    [creation_at]   DATETIME2 (7)  NULL,
    [modified_at]   DATETIME2 (7)  NULL,
    [created_by]    BIGINT         NULL,
    [modified_by]   BIGINT         NULL
);
GO

