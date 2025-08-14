CREATE TABLE [data_in].[proj_resource_row_comment] (
    [id]              BIGINT          NULL,
    [resource_row_id] BIGINT          NULL,
    [employee_id]     BIGINT          NULL,
    [text]            NVARCHAR (2000) NULL,
    [creation_at]     DATETIME2 (7)   NULL,
    [modified_at]     DATETIME2 (7)   NULL,
    [created_by]      BIGINT          NULL,
    [modified_by]     BIGINT          NULL,
    [log]             NVARCHAR (2000) NULL
);
GO

