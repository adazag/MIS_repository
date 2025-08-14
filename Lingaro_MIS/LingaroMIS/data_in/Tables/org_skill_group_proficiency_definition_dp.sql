CREATE TABLE [data_in].[org_skill_group_proficiency_definition_dp] (
    [id]                BIGINT         NULL,
    [skill_group_id]    BIGINT         NULL,
    [proficiency_level] INT            NULL,
    [proficiency_name]  NVARCHAR (50)  NULL,
    [description]       NVARCHAR (MAX) NULL,
    [active_ind]        BIT            NULL,
    [creation_at]       DATETIME2 (7)  NULL,
    [modified_at]       DATETIME2 (7)  NULL,
    [created_by]        BIGINT         NULL,
    [modified_by]       BIGINT         NULL
);
GO

