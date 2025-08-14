CREATE TABLE [data_mis_project].[sulu_rebaseline_fct] (
    [REBASELINE_ID]   FLOAT (53)    NULL,
    [PROJ_ID]         FLOAT (53)    NULL,
    [REASON_ID]       FLOAT (53)    NULL,
    [REBASELINE_DATE] DATETIME2 (0) NULL,
    [CREATED_BY]      FLOAT (53)    NULL,
    [CREATION_DATE]   DATETIME2 (6) NULL,
    [MODIFIED_BY]     FLOAT (53)    NULL,
    [MODIFIED_DATE]   DATETIME2 (6) NULL
);
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[sulu_rebaseline_fct] TO [data_mis_project_sulu_rebaseline_fct_read_all]
    AS [dbo];
GO

