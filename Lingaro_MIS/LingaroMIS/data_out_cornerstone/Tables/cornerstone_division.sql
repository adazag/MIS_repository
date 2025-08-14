CREATE TABLE [data_out_cornerstone].[cornerstone_division] (
    [OU ID]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [OU Name]       NVARCHAR (100) NULL,
    [Parent ID]     BIGINT         NULL,
    [Active]        BIT            NULL,
    [Modified Date] DATETIME       NULL,
    [Creation Date] DATETIME       NULL
);
GO

GRANT SELECT
    ON OBJECT::[data_out_cornerstone].[cornerstone_division] TO [data_out_cornerstone_read_all]
    AS [grzegorz.pawelec@lingarogroup.com];
GO

ALTER TABLE [data_out_cornerstone].[cornerstone_division]
    ADD CONSTRAINT [PK_cornerstone_division_OU_Id] PRIMARY KEY CLUSTERED ([OU ID] ASC);
GO

