CREATE TABLE [data_out_cornerstone].[cornerstone_location] (
    [OU ID]         BIGINT        IDENTITY (1, 1) NOT NULL,
    [OU Name]       NVARCHAR (11) NULL,
    [Time Zone]     NVARCHAR (2)  NULL,
    [Active]        BIT           NULL,
    [Modified Date] DATETIME      NULL,
    [Creation Date] DATETIME      NULL
);
GO

ALTER TABLE [data_out_cornerstone].[cornerstone_location]
    ADD CONSTRAINT [PK_cornerstone_location_OU_ID] PRIMARY KEY CLUSTERED ([OU ID] ASC);
GO

GRANT SELECT
    ON OBJECT::[data_out_cornerstone].[cornerstone_location] TO [data_out_cornerstone_read_all]
    AS [grzegorz.pawelec@lingarogroup.com];
GO

