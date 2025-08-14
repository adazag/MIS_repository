CREATE TABLE [data_out_cornerstone].[cornerstone_legal_entity] (
    [LE ID]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [LE Name]       NVARCHAR (100) NULL,
    [Active]        BIT            NULL,
    [Modified Date] DATETIME       NULL,
    [Creation Date] DATETIME       NULL
);
GO

GRANT SELECT
    ON OBJECT::[data_out_cornerstone].[cornerstone_legal_entity] TO [data_out_cornerstone_read_all]
    AS [grzegorz.pawelec@lingarogroup.com];
GO

ALTER TABLE [data_out_cornerstone].[cornerstone_legal_entity]
    ADD CONSTRAINT [PK_cornerstone_legal_entity_LE_Id] PRIMARY KEY CLUSTERED ([LE ID] ASC);
GO

