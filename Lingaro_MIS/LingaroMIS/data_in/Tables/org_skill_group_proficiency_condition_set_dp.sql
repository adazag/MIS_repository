CREATE TABLE [data_in].[org_skill_group_proficiency_condition_set_dp] (
    [id]                                    BIGINT        NULL,
    [skill_group_proficiency_definition_id] BIGINT        NULL,
    [condition_type]                        NVARCHAR (50) NULL,
    [number_of_skills]                      INT           NULL,
    [set_number]                            INT           NULL,
    [minimum_proficiency_level]             INT           NULL,
    [active_ind]                            BIT           NULL,
    [creation_at]                           DATETIME2 (7) NULL,
    [modified_at]                           DATETIME2 (7) NULL,
    [created_by]                            BIGINT        NULL,
    [modified_by]                           BIGINT        NULL
);
GO

