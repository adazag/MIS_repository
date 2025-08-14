CREATE TABLE [data_in].[proj_project_schedule] (
    [id]            BIGINT          NULL,
    [project_id]    BIGINT          NULL,
    [name]          NVARCHAR (4000) NULL,
    [start_date]    DATE            NULL,
    [end_date]      DATE            NULL,
    [task_type]     NVARCHAR (50)   NULL,
    [task_status]   NVARCHAR (50)   NULL,
    [display_order] INT             NULL,
    [created_by]    BIGINT          NULL,
    [modified_by]   BIGINT          NULL,
    [creation_at]   DATETIME2 (7)   NULL,
    [modified_at]   DATETIME2 (7)   NULL
);
GO

