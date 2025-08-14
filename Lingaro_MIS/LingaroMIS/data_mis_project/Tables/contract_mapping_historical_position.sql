CREATE TABLE [data_mis_project].[contract_mapping_historical_position] (
    [EMPLOYEE_ID]               BIGINT          NULL,
    [FIRST_CONTRACT_START_DATE] DATE            NULL,
    [LAST_CONTRACT_END_DATE]    DATE            NULL,
    [MONTH]                     NVARCHAR (4000) NULL,
    [START_OF_MONTH]            DATE            NULL,
    [END_OF_MONTH]              DATE            NULL,
    [CONTRACT_TYPE_NAME]        NVARCHAR (100)  NULL,
    [EMPLOYEE_NAME]             NVARCHAR (201)  NULL,
    [LINE_MANAGER_NAME]         NVARCHAR (201)  NULL,
    [POSITION]                  NVARCHAR (150)  NULL,
    [PRIMARY_PROFILE]           NVARCHAR (50)   NULL,
    [CITY]                      NVARCHAR (200)  NULL,
    [COUNTRY]                   NVARCHAR (200)  NULL,
    [STATUS]                    VARCHAR (8)     NOT NULL,
    [LE_NAME]                   NVARCHAR (100)  NULL,
    [FTE_PCT]                   DECIMAL (6, 3)  NULL,
    [ORG_NAME]                  NVARCHAR (100)  NULL,
    [T_NAME]                    NVARCHAR (100)  NULL,
    [DT_NAME]                   NVARCHAR (100)  NULL,
    [SDT_NAME]                  NVARCHAR (100)  NULL,
    [SBU_NAME]                  NVARCHAR (100)  NULL,
    [BU_NAME]                   NVARCHAR (100)  NULL,
    [PARENT_ORG_UNIT_NAME]      NVARCHAR (100)  NULL,
    [NOTICE_LAST_MONTH]         VARCHAR (1)     NOT NULL
);
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[contract_mapping_historical_position] TO [data_mis_project_contract_mapping_historical_position_read_all]
    AS [dbo];
GO

