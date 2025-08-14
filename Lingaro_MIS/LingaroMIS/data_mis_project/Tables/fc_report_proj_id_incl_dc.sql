CREATE TABLE [data_mis_project].[fc_report_proj_id_incl_dc] (
    [PROJ_ID]           FLOAT (53)   NULL,
    [PROJ_START_DATE]   DATE         NULL,
    [NEW_PROJ_END_DATE] DATE         NULL,
    [DBL_CNTNG_IND]     NVARCHAR (1) NULL,
    [PARNT_FIN_PROJ_ID] FLOAT (53)   NULL,
    [NEW_PROJ_ID]       FLOAT (53)   NULL
);
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[fc_report_proj_id_incl_dc] TO [data_mis_project_fc_report_proj_id_incl_dc_read_all]
    AS [dbo];
GO

