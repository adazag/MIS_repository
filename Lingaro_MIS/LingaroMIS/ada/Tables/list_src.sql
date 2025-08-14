CREATE TABLE [ada].[list_src] (
    [id]          INT            IDENTITY (1, 1) NOT NULL,
    [src_schema]  NVARCHAR (100) NULL,
    [src_table]   NVARCHAR (100) NULL,
    [sink_schema] NVARCHAR (100) NULL,
    [sink_table]  NVARCHAR (100) NULL
);
GO

