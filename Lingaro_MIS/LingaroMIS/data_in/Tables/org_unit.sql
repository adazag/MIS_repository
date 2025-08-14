CREATE TABLE [data_in].[org_unit] (
    [id]         BIGINT          NULL,
    [name]       NVARCHAR (100)  NULL,
    [parent_id]  BIGINT          NULL,
    [start_date] DATE            NULL,
    [end_date]   DATE            NULL,
    [unit_level] INT             NULL,
    [type]       NVARCHAR (3)    NULL,
    [leader_id]  BIGINT          NULL,
    [dc_ind]     BIT             NULL,
    [area]       NVARCHAR (1000) NULL,
    [team_level] INT             NULL
);
GO

