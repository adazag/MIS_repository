CREATE TABLE [data_in].[org_role_skill_group_priority_dp] (
    [id]             BIGINT        NULL,
    [role_id]        BIGINT        NULL,
    [skill_group_id] BIGINT        NULL,
    [priority_type]  NVARCHAR (50) NULL,
    [active_ind]     BIT           NULL,
    [creation_at]    DATETIME2 (7) NULL,
    [modified_at]    DATETIME2 (7) NULL,
    [created_by]     BIGINT        NULL,
    [modified_by]    BIGINT        NULL
);
GO

