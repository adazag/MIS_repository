CREATE TABLE [data_mis_project].[fc_report_revenue] (
    [ID]                  FLOAT (53)       NULL,
    [PROJ_ID]             FLOAT (53)       NULL,
    [CRNCY_DAY_DATE]      DATE             NULL,
    [DAY_DATE]            DATE             NULL,
    [CRNCY_CODE]          NVARCHAR (3)     NULL,
    [AMT_BEFORE_DISC]     FLOAT (53)       NULL,
    [AMT_DISC]            FLOAT (53)       NULL,
    [AMT_AFTER_DISC]      FLOAT (53)       NULL,
    [CRNCY_RATE]          DECIMAL (15, 10) NULL,
    [AMT_BEFORE_DISC_PLN] FLOAT (53)       NULL,
    [AMT_DISC_PLN]        FLOAT (53)       NULL,
    [AMT_AFTER_DISC_PLN]  FLOAT (53)       NULL,
    [TYPE]                VARCHAR (19)     NOT NULL
);
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[fc_report_revenue] TO [data_mis_project_fc_report_revenue_read_all]
    AS [dbo];
GO

