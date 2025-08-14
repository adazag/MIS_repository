CREATE TABLE [data_in].[emp_skill_review] (
    [id]               BIGINT        NULL,
    [employee_id]      BIGINT        NULL,
    [reviewer_id]      BIGINT        NULL,
    [review_date_time] DATETIME2 (7) NULL,
    [creation_at]      DATETIME2 (7) NULL,
    [modified_at]      DATETIME2 (7) NULL,
    [created_by]       BIGINT        NULL,
    [modified_by]      BIGINT        NULL
);
GO

