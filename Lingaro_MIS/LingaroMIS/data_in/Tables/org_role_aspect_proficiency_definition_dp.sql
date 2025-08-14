CREATE TABLE [data_in].[org_role_aspect_proficiency_definition_dp] (
    [id]                BIGINT        NULL,
    [role_aspect_id]    BIGINT        NULL,
    [skill_group_id]    BIGINT        NULL,
    [skill_detail_id]   BIGINT        NULL,
    [seniority_id]      BIGINT        NULL,
    [active_ind]        BIT           NULL,
    [creation_at]       DATETIME2 (7) NULL,
    [modified_at]       DATETIME2 (7) NULL,
    [created_by]        BIGINT        NULL,
    [modified_by]       BIGINT        NULL,
    [proficiency_level] INT           NULL
);
GO

