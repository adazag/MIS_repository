CREATE TABLE [data_in].[org_role_aspect_skill] (
    [id]              BIGINT        NULL,
    [role_aspect_id]  BIGINT        NULL,
    [skill_id]        BIGINT        NULL,
    [skill_detail_id] BIGINT        NULL,
    [skill_level_id]  BIGINT        NULL,
    [required_ind]    BIT           NULL,
    [creation_at]     DATETIME2 (7) NULL,
    [modified_at]     DATETIME2 (7) NULL,
    [created_by]      BIGINT        NULL,
    [modified_by]     BIGINT        NULL
);
GO

