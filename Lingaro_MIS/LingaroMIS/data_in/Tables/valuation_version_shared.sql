CREATE TABLE [data_in].[valuation_version_shared] (
    [id]                    BIGINT        NOT NULL,
    [valuation_version_id]  BIGINT        NOT NULL,
    [shared_to_employee_id] BIGINT        NOT NULL,
    [creation_at]           DATETIME2 (7) NULL,
    [modified_at]           DATETIME2 (7) NULL,
    [created_by]            BIGINT        NULL,
    [modified_by]           BIGINT        NULL
);
GO

