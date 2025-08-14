CREATE TABLE [data_mis_project].[ContractData] (
    [Id]                  INT             IDENTITY (1, 1) NOT NULL,
    [ProcessedDate]       DATETIME2 (7)   DEFAULT (getutcdate()) NULL,
    [FILE_NAME]           NVARCHAR (500)  NOT NULL,
    [VALUATION_ID]        NVARCHAR (10)   DEFAULT ('') NOT NULL,
    [IS_VALID_DOCUMENT]   BIT             DEFAULT ((0)) NOT NULL,
    [DOCUMENT_TYPE]       NVARCHAR (50)   DEFAULT ('OTHER') NOT NULL,
    [TOTAL_PRICE]         DECIMAL (18, 2) DEFAULT ((0.0)) NOT NULL,
    [CURRENCY]            NVARCHAR (10)   DEFAULT ('') NOT NULL,
    [DISCOUNT_PERCENTAGE] DECIMAL (5, 4)  DEFAULT ((0.0)) NOT NULL,
    [DISCOUNTED_PRICE]    DECIMAL (18, 2) DEFAULT ((0.0)) NOT NULL,
    [IS_CR_AMOUNT_CHANGE] BIT             DEFAULT ((0)) NOT NULL,
    [CR_AMOUNT_CHANGE]    DECIMAL (18, 2) DEFAULT ((0.0)) NOT NULL,
    [START_DATE]          NVARCHAR (20)   DEFAULT ('') NOT NULL,
    [END_DATE]            NVARCHAR (20)   DEFAULT ('') NOT NULL,
    [PARTIES]             NVARCHAR (1000) DEFAULT ('') NOT NULL,
    [IS_SIGNED]           BIT             DEFAULT ((0)) NOT NULL,
    [SIGNATURE_1]         NVARCHAR (200)  DEFAULT ('') NOT NULL,
    [SIGNATURE_DATE_1]    NVARCHAR (20)   DEFAULT ('') NOT NULL,
    [SIGNATURE_2]         NVARCHAR (200)  DEFAULT ('') NOT NULL,
    [SIGNATURE_DATE_2]    NVARCHAR (20)   DEFAULT ('') NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

GRANT UPDATE
    ON OBJECT::[data_mis_project].[ContractData] TO [maksymilian.orczyk@lingarogroup.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[ContractData] TO [usercontractfunction]
    AS [dbo];
GO

GRANT INSERT
    ON OBJECT::[data_mis_project].[ContractData] TO [usercontractfunction]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[ContractData] TO [maksymilian.orczyk@lingarogroup.com]
    AS [dbo];
GO

GRANT INSERT
    ON OBJECT::[data_mis_project].[ContractData] TO [maksymilian.orczyk@lingarogroup.com]
    AS [dbo];
GO

GRANT ALTER
    ON OBJECT::[data_mis_project].[ContractData] TO [usercontractfunction]
    AS [dbo];
GO

