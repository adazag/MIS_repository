CREATE TABLE [data_in].[proj_account_assignment_bucket_details] (
    [id]          BIGINT        NULL,
    [bucket_id]   BIGINT        NULL,
    [client_id]   BIGINT        NULL,
    [creation_at] DATETIME2 (7) NULL,
    [modified_at] DATETIME2 (7) NULL,
    [created_by]  BIGINT        NULL,
    [modified_by] BIGINT        NULL,
    [unit_id]     BIGINT        NULL
);
GO

