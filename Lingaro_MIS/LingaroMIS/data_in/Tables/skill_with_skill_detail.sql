CREATE TABLE [data_in].[skill_with_skill_detail] (
    [id]              BIGINT        NOT NULL,
    [skill_id]        BIGINT        NULL,
    [skill_detail_id] BIGINT        NULL,
    [creation_at]     DATETIME2 (7) NULL,
    [modified_at]     DATETIME2 (7) NULL,
    [created_by]      BIGINT        NULL,
    [modified_by]     BIGINT        NULL
);
GO

