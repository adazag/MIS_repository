CREATE TABLE [data_in].[list_sp] (
    [id]      INT            IDENTITY (1, 1) NOT NULL,
    [sp_name] NVARCHAR (255) NOT NULL,
    [rt_ind]  INT            NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

