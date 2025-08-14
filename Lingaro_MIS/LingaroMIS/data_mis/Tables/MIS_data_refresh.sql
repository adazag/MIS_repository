CREATE TABLE [data_mis].[MIS_data_refresh] (
    [id]                    INT          IDENTITY (1, 1) NOT NULL,
    [ADF_pipeline_name]     VARCHAR (50) NULL,
    [Pipeline_trigger_time] DATETIME     NULL,
    [Pipeline_status]       VARCHAR (50) NULL
);
GO

