CREATE TABLE [data_in].[proj_opportunity_team_member] (
    [salesforce_id]             NVARCHAR (30)  NULL,
    [opportunity_sf_id]         NVARCHAR (30)  NULL,
    [opportunity_id]            BIGINT         NULL,
    [user_sf_id]                NVARCHAR (30)  NULL,
    [user_id]                   BIGINT         NULL,
    [name]                      NVARCHAR (200) NULL,
    [title]                     NVARCHAR (200) NULL,
    [team_member_role]          NVARCHAR (200) NULL,
    [opportunity_access_level]  NVARCHAR (100) NULL,
    [currency_code]             NVARCHAR (3)   NULL,
    [deleted_ind]               BIT            NULL,
    [active_ind]                BIT            NULL,
    [created_by_sf]             BIGINT         NULL,
    [creation_date_sf]          DATETIME2 (7)  NULL,
    [modified_by_sf]            BIGINT         NULL,
    [last_modification_date_sf] DATETIME2 (7)  NULL,
    [creation_at]               DATETIME2 (7)  NULL,
    [modified_at]               DATETIME2 (7)  NULL,
    [created_by]                BIGINT         NULL,
    [modified_by]               BIGINT         NULL,
    [user_mail]                 NVARCHAR (200) NULL
);
GO

