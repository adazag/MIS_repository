CREATE TABLE [data_mis_project].[fc_report_proj_id_billable_type] (
    [PROJ_ID]           FLOAT (53)     NULL,
    [PROJ_NAME]         NVARCHAR (500) NULL,
    [PROJ_START_DATE]   DATE           NULL,
    [NEW_PROJ_END_DATE] DATE           NULL,
    [DBL_CNTNG_IND]     NVARCHAR (1)   NULL,
    [PARNT_DC_PROJ_ID]  FLOAT (53)     NULL,
    [ORGNL_MGMT_IND]    NVARCHAR (4)   NULL,
    [INVST_IND]         NVARCHAR (4)   NULL,
    [PROJ_BLLBL_IND]    NVARCHAR (1)   NULL,
    [BILLABLE_TYPE]     VARCHAR (25)   NOT NULL,
    [NEW_PROJ_ID_NAME]  NVARCHAR (500) NULL
);
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[fc_report_proj_id_billable_type] TO [data_mis_project_fc_report_proj_id_billable_type_read_all]
    AS [dbo];
GO

