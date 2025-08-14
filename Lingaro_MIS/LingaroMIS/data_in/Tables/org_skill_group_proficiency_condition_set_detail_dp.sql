CREATE TABLE [data_in].[org_skill_group_proficiency_condition_set_detail_dp] (
    [id]                                       BIGINT        NULL,
    [skill_group_proficiency_condition_set_id] BIGINT        NULL,
    [skill_detail_id]                          BIGINT        NULL,
    [active_ind]                               BIT           NULL,
    [creation_at]                              DATETIME2 (7) NULL,
    [modified_at]                              DATETIME2 (7) NULL,
    [created_by]                               BIGINT        NULL,
    [modified_by]                              BIGINT        NULL
);
GO

