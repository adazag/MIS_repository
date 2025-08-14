CREATE TABLE [rls].[org_unit_hier_full_path_split] (
    [empee_id]             BIGINT         NULL,
    [empee_email]          NVARCHAR (150) NULL,
    [privilege_user_id]    VARCHAR (255)  NULL,
    [privilege_user_email] NVARCHAR (150) NULL
);
GO

GRANT SELECT
    ON OBJECT::[rls].[org_unit_hier_full_path_split] TO [bartosz.grzesiak@lingarogroup.com]
    AS [dbo];
GO

