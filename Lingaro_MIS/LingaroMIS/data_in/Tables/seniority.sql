CREATE TABLE [data_in].[seniority] (
    [id]            BIGINT         NOT NULL,
    [name]          NVARCHAR (200) NOT NULL,
    [is_active_ind] BIT            DEFAULT ((0)) NULL,
    [creation_at]   DATETIME2 (7)  NULL,
    [modified_at]   DATETIME2 (7)  NULL,
    [created_by]    BIGINT         NULL,
    [modified_by]   BIGINT         NULL,
    [level]         INT            NULL
);
GO

