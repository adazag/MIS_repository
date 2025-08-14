CREATE TABLE [data_out_cornerstone].[cornerstone_employee] (
    [User ID]                              BIGINT         IDENTITY (1, 1) NOT NULL,
    [First Name]                           NVARCHAR (50)  NULL,
    [Last Name]                            NVARCHAR (100) NULL,
    [Manager]                              BIGINT         NULL,
    [Email]                                NVARCHAR (120) NULL,
    [Gender]                               NVARCHAR (13)  NULL,
    [Mobile]                               NVARCHAR (100) NULL,
    [User Type]                            NVARCHAR (8)   NULL,
    [Employment Status]                    NVARCHAR (10)  NULL,
    [Division]                             BIGINT         NULL,
    [Position]                             BIGINT         NULL,
    [Location]                             BIGINT         NULL,
    [Dotted Line Manager/Indirect Manager] BIGINT         NULL,
    [Legal Entity]                         BIGINT         NULL,
    [Modified Date]                        DATETIME       NULL,
    [Creation Date]                        DATETIME       NULL,
    [Is Project Manager]                   BIT            NULL,
    [Termination Date]                     DATE           NULL,
    [Is Line Manager]                      BIT            NULL,
    [Is Team Owner]                        BIT            NULL,
    [Is Service Level Manager]             BIT            NULL,
    [Is MC Member]                         BIT            NULL,
    [Active]                               BIT            NULL,
    [First Employment Date]                DATE           NULL,
    [BU ID]                                BIGINT         NULL,
    [Sub BU ID]                            BIGINT         NULL
);
GO

GRANT UPDATE
    ON OBJECT::[data_out_cornerstone].[cornerstone_employee] TO [cornerstone-integration]
    AS [grzegorz.pawelec@lingarogroup.com];
GO

GRANT SELECT
    ON OBJECT::[data_out_cornerstone].[cornerstone_employee] TO [data_out_cornerstone_read_all]
    AS [grzegorz.pawelec@lingarogroup.com];
GO

ALTER TABLE [data_out_cornerstone].[cornerstone_employee]
    ADD CONSTRAINT [PK_cornerstone_employee_User_Id] PRIMARY KEY CLUSTERED ([User ID] ASC);
GO

