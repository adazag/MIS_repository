CREATE TABLE [data_in].[org_role_aspect_proficiency_definition_dp_vw] (
    [role_aspect_id]        BIGINT         NULL,
    [role_aspect_name]      NVARCHAR (255) NULL,
    [role_aspect_status]    NVARCHAR (50)  NULL,
    [role_id]               BIGINT         NULL,
    [role_name]             NVARCHAR (100) NULL,
    [definition_id]         BIGINT         NULL,
    [skill_group_id]        BIGINT         NULL,
    [skill_group_name]      NVARCHAR (255) NULL,
    [skill_detail_id]       BIGINT         NULL,
    [skill_detail_name]     NVARCHAR (255) NULL,
    [seniority_id]          BIGINT         NULL,
    [seniority_name]        NVARCHAR (200) NULL,
    [definition_active_ind] BIT            NULL,
    [proficiency_level]     INT            NULL
);
GO

