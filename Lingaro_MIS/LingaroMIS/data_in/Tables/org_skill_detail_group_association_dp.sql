CREATE TABLE [data_in].[org_skill_detail_group_association_dp] (
    [id]              BIGINT        NULL,
    [skill_group_id]  BIGINT        NULL,
    [skill_detail_id] BIGINT        NULL,
    [status]          NVARCHAR (50) NULL,
    [creation_at]     DATETIME2 (7) NULL,
    [modified_at]     DATETIME2 (7) NULL,
    [created_by]      BIGINT        NULL,
    [modified_by]     BIGINT        NULL
);
GO

