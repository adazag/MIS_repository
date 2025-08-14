CREATE TABLE [data_in].[certificate] (
    [id]            BIGINT          NOT NULL,
    [name]          NVARCHAR (2000) NULL,
    [code]          NVARCHAR (10)   NULL,
    [technology_id] BIGINT          NULL,
    [skill_type_id] BIGINT          NULL,
    [creation_at]   DATETIME2 (7)   NULL,
    [modified_at]   DATETIME2 (7)   NULL,
    [created_by]    BIGINT          NULL,
    [modified_by]   BIGINT          NULL,
    [parent_id]     BIGINT          NULL,
    [active_ind]    BIT             NULL
);
GO

