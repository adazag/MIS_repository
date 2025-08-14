CREATE TABLE [data_in].[org_skill_group_proficiency_definition_dp_vw] (
    [definition_id]                   BIGINT         NULL,
    [skill_group_id]                  BIGINT         NULL,
    [proficiency_level]               INT            NULL,
    [proficiency_name]                NVARCHAR (50)  NULL,
    [description]                     NVARCHAR (MAX) NULL,
    [active_ind]                      BIT            NULL,
    [condition_set_id]                BIGINT         NULL,
    [condition_type]                  NVARCHAR (50)  NULL,
    [number_of_skills]                INT            NULL,
    [minimum_proficiency_level]       INT            NULL,
    [minimum_proficiency_name]        VARCHAR (15)   NULL,
    [condition_set_active_ind]        BIT            NULL,
    [condition_set_detail_id]         BIGINT         NULL,
    [skill_detail_id]                 BIGINT         NULL,
    [skill_detail_name]               NVARCHAR (255) NULL,
    [condition_set_detail_active_ind] BIT            NULL
);
GO

