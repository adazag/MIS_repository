CREATE TABLE [data_in].[emp_reviewed_skill_history_dp] (
    [id]                             BIGINT        NULL,
    [review_id]                      BIGINT        NULL,
    [skill_detail_id]                BIGINT        NULL,
    [skill_detail_proficiency_level] INT           NULL,
    [creation_at]                    DATETIME2 (7) NULL,
    [modified_at]                    DATETIME2 (7) NULL,
    [created_by]                     BIGINT        NULL,
    [modified_by]                    BIGINT        NULL,
    [skill_group_id]                 BIGINT        NULL,
    [skill_group_proficiency_level]  INT           NULL
);
GO

