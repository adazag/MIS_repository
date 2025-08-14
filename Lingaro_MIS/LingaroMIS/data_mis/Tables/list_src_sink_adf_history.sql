CREATE TABLE [data_mis].[list_src_sink_adf_history] (
    [id]           INT            NOT NULL,
    [src_db]       NVARCHAR (50)  NOT NULL,
    [src_schema]   NVARCHAR (255) NOT NULL,
    [src_table]    NVARCHAR (255) NOT NULL,
    [sink_schema]  NVARCHAR (255) NOT NULL,
    [sink_table]   NVARCHAR (255) NOT NULL,
    [rt_ind]       INT            NOT NULL,
    [LongLoadFlag] BIT            NULL,
    [data_copy]    DATETIME       NULL
);
GO

