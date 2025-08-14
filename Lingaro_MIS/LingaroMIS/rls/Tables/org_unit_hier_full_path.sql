CREATE TABLE [rls].[org_unit_hier_full_path] (
    [EMPEE_ID]          BIGINT         NULL,
    [EMPEE_LOGIN_NAME]  NVARCHAR (150) NULL,
    [LINE_MGR_EMPEE_ID] BIGINT         NULL,
    [LEVEL]             INT            NULL,
    [PATH]              VARCHAR (255)  NULL
);
GO

