CREATE TABLE [data_in].[proj_resource_proposal] (
    [id]                      BIGINT          NULL,
    [resource_row_id]         BIGINT          NULL,
    [name]                    NVARCHAR (200)  NULL,
    [status]                  NVARCHAR (100)  NULL,
    [creation_at]             DATETIME2 (7)   NULL,
    [modified_at]             DATETIME2 (7)   NULL,
    [created_by]              BIGINT          NULL,
    [modified_by]             BIGINT          NULL,
    [comment]                 NVARCHAR (2000) NULL,
    [overbooking_allowed_ind] BIT             NULL,
    [preference_type]         NVARCHAR (100)  NULL
);
GO

