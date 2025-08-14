CREATE TABLE [data_in].[proj_resource_proposal_row_detail] (
    [id]                       BIGINT          NULL,
    [resource_proposal_row_id] BIGINT          NULL,
    [month_date]               DATE            NULL,
    [fte]                      DECIMAL (12, 4) NULL,
    [man_days]                 DECIMAL (12, 4) NULL,
    [creation_at]              DATETIME2 (7)   NULL,
    [modified_at]              DATETIME2 (7)   NULL,
    [created_by]               BIGINT          NULL,
    [modified_by]              BIGINT          NULL,
    [first_day_of_week]        DATE            NULL
);
GO

