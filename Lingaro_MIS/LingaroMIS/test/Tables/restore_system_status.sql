CREATE TABLE [test].[restore_system_status] (
    [system_name]      NVARCHAR (100) NOT NULL,
    [last_updated]     DATETIME2 (7)  DEFAULT (getdate()) NOT NULL,
    [current_rows]     INT            DEFAULT ((0)) NOT NULL,
    [backup_rows]      INT            DEFAULT ((0)) NOT NULL,
    [last_operation]   NVARCHAR (20)  NULL,
    [deleted_row_info] NVARCHAR (MAX) NULL,
    [delete_date]      DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([system_name] ASC)
);
GO

