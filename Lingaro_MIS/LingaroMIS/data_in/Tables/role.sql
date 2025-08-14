CREATE TABLE [data_in].[role] (
    [id]          BIGINT         NOT NULL,
    [name]        NVARCHAR (100) NULL,
    [creation_at] DATETIME2 (7)  NULL,
    [modified_at] DATETIME2 (7)  NULL,
    [created_by]  BIGINT         NULL,
    [modified_by] BIGINT         NULL
);
GO

