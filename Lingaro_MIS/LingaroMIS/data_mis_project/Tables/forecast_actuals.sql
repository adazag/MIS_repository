CREATE TABLE [data_mis_project].[forecast_actuals] (
    [Project ID]                BIGINT         NULL,
    [Day Date]                  DATETIME2 (0)  NULL,
    [Currency]                  NVARCHAR (MAX) NULL,
    [Data type]                 NVARCHAR (MAX) NULL,
    [Revenue - Actuals]         FLOAT (53)     NULL,
    [Cost - Actuals]            FLOAT (53)     NULL,
    [FTE - Actuals]             FLOAT (53)     NULL,
    [Presales - Actuals]        FLOAT (53)     NULL,
    [AdditionalCosts - Actuals] FLOAT (53)     NULL
);
GO

