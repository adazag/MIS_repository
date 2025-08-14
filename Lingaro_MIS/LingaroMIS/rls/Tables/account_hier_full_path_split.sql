CREATE TABLE [rls].[account_hier_full_path_split] (
    [id]                                 BIGINT          NOT NULL,
    [name]                               NVARCHAR (300)  NULL,
    [account_manager_id]                 BIGINT          NULL,
    [employee]                           NVARCHAR (201)  NULL,
    [account_manager_email]              NVARCHAR (150)  NULL,
    [last_verified_by]                   NVARCHAR (201)  NULL,
    [last_verified_by_email]             NVARCHAR (150)  NULL,
    [last_verified_at]                   DATETIME2 (7)   NULL,
    [emergency_contact]                  NVARCHAR (2000) NULL,
    [is_active_ind]                      BIT             NULL,
    [ultimate_parent_id]                 BIGINT          NULL,
    [ultimate_parent_name]               NVARCHAR (100)  NULL,
    [share_point_group_id]               NVARCHAR (2000) NULL,
    [share_point_url]                    NVARCHAR (2000) NULL,
    [delivery_owner_id]                  BIGINT          NULL,
    [delivery_owner]                     NVARCHAR (201)  NULL,
    [emergency_contact_excluded_ind]     BIT             NULL,
    [emergency_contact_exclusion_reason] NVARCHAR (1000) NULL,
    [emergency_contact_modified_at]      DATETIME2 (7)   NULL,
    [emergency_contact_modified_by]      NVARCHAR (201)  NULL
);
GO

