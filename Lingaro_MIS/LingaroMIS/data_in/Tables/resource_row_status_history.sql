CREATE TABLE [data_in].[resource_row_status_history] (
    [id]              BIGINT         NULL,
    [resource_row_id] BIGINT         NULL,
    [new_status]      NVARCHAR (200) NULL,
    [modified_by]     BIGINT         NULL,
    [modified_at]     DATETIME2 (7)  NULL,
    [on_hold_ind]     BIT            NULL
);
GO

