CREATE TABLE [test].[restore_insert_statements] (
    [id]               INT            IDENTITY (1, 1) NOT NULL,
    [src_schema]       NVARCHAR (100) NOT NULL,
    [src_table]        NVARCHAR (100) NOT NULL,
    [sink_schema]      NVARCHAR (100) NOT NULL,
    [sink_table]       NVARCHAR (100) NOT NULL,
    [insert_statement] NVARCHAR (MAX) NOT NULL,
    [created_date]     DATETIME2 (7)  DEFAULT (getdate()) NOT NULL,
    [updated_date]     DATETIME2 (7)  DEFAULT (getdate()) NOT NULL,
    [is_deleted]       BIT            DEFAULT ((0)) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

