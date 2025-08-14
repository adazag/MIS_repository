CREATE TABLE [data_out_cornerstone].[cornerstone_position] (
    [Pos ID]        BIGINT        IDENTITY (1, 1) NOT NULL,
    [Pos Name]      NVARCHAR (50) NULL,
    [Active]        BIT           NULL,
    [Modified Date] DATETIME      NULL,
    [Creation Date] DATETIME      NULL
);
GO

ALTER TABLE [data_out_cornerstone].[cornerstone_position]
    ADD CONSTRAINT [PK_cornerstone_position_Pos_Id] PRIMARY KEY CLUSTERED ([Pos ID] ASC);
GO

GRANT SELECT
    ON OBJECT::[data_out_cornerstone].[cornerstone_position] TO [data_out_cornerstone_read_all]
    AS [grzegorz.pawelec@lingarogroup.com];
GO

