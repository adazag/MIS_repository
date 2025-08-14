CREATE TABLE [data_in].[list_src_sink_adf] (
    [id]           INT            IDENTITY (1, 1) NOT NULL,
    [src_db]       NVARCHAR (50)  NOT NULL,
    [src_schema]   NVARCHAR (255) NOT NULL,
    [src_table]    NVARCHAR (255) NOT NULL,
    [sink_schema]  NVARCHAR (255) NOT NULL,
    [sink_table]   NVARCHAR (255) NOT NULL,
    [rt_ind]       INT            NOT NULL,
    [LongLoadFlag] BIT            NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

ALTER TABLE [data_in].[list_src_sink_adf]
    ADD CONSTRAINT [DF_list_src_sink_adf_rt_ind] DEFAULT ((0)) FOR [rt_ind];
GO

