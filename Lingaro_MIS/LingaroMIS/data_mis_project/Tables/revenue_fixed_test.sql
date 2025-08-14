CREATE TABLE [data_mis_project].[revenue_fixed_test] (
    [ID]                  FLOAT (53)      NULL,
    [PROJ_ID]             FLOAT (53)      NULL,
    [CRNCY_DAY_DATE]      DATE            NULL,
    [DAY_DATE]            DATE            NULL,
    [CRNCY_CODE]          NVARCHAR (3)    NULL,
    [AMT_BEFORE_DISC]     FLOAT (53)      NULL,
    [AMT_DISC]            FLOAT (53)      NULL,
    [AMT_AFTER_DISC]      FLOAT (53)      NULL,
    [CRNCY_RATE]          DECIMAL (19, 4) NULL,
    [AMT_BEFORE_DISC_PLN] FLOAT (53)      NULL,
    [AMT_DISC_PLN]        FLOAT (53)      NULL,
    [AMT_AFTER_DISC_PLN]  FLOAT (53)      NULL,
    [TYPE]                VARCHAR (19)    NOT NULL,
    [load_datetime]       DATETIME        NULL
);
GO

