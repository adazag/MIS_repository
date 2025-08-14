CREATE TABLE [data_mis_project].[revenue] (
    [ID]                  BIGINT           NULL,
    [PROJ_ID]             BIGINT           NULL,
    [CRNCY_DAY_DATE]      DATE             NULL,
    [DAY_DATE]            DATE             NULL,
    [CRNCY_CODE]          NVARCHAR (3)     NULL,
    [AMT_BEFORE_DISC]     DECIMAL (19, 2)  NULL,
    [AMT_DISC]            DECIMAL (38, 6)  NULL,
    [AMT_AFTER_DISC]      DECIMAL (38, 6)  NULL,
    [CRNCY_RATE]          DECIMAL (15, 10) NULL,
    [AMT_BEFORE_DISC_PLN] DECIMAL (35, 12) NULL,
    [AMT_DISC_PLN]        DECIMAL (38, 6)  NULL,
    [AMT_AFTER_DISC_PLN]  DECIMAL (38, 6)  NULL,
    [TYPE]                VARCHAR (19)     NOT NULL
);
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[revenue] TO [data_mis_project_revenue_read_all]
    AS [dbo];
GO

