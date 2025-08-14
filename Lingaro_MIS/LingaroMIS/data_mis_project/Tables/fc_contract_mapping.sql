CREATE TABLE [data_mis_project].[fc_contract_mapping] (
    [EMPLOYEE_ID]                 BIGINT          NULL,
    [FIRST_CONTRACT_START_DATE]   DATE            NULL,
    [LAST_CONTRACT_END_DATE]      DATE            NULL,
    [MONTH]                       NVARCHAR (4000) NULL,
    [START_OF_MONTH]              DATE            NULL,
    [END_OF_MONTH]                DATE            NULL,
    [CONTRACT_TYPE_NAME]          NVARCHAR (100)  NULL,
    [EMPLOYEE_NAME]               NVARCHAR (201)  NULL,
    [EMAIL]                       NVARCHAR (150)  NULL,
    [LINE_MANAGER_NAME]           NVARCHAR (201)  NULL,
    [FUNCTIONAL_MANAGER]          NVARCHAR (201)  NULL,
    [COMPETENCY]                  NVARCHAR (100)  NULL,
    [NEW_TAXONOMY_ROLE]           NVARCHAR (100)  NULL,
    [ROLE]                        NVARCHAR (4000) NULL,
    [CLIENT_ENGAGEMENT_SENIORITY] NVARCHAR (200)  NULL,
    [POSITION]                    NVARCHAR (150)  NULL,
    [CITY]                        NVARCHAR (200)  NULL,
    [STATUS]                      VARCHAR (8)     NOT NULL,
    [LE_NAME]                     NVARCHAR (100)  NULL,
    [FTE_PCT]                     DECIMAL (6, 3)  NULL,
    [ORG_ID]                      BIGINT          NULL,
    [ORG_NAME]                    NVARCHAR (100)  NULL,
    [TEAM_ID]                     BIGINT          NULL,
    [TEAM_NAME]                   NVARCHAR (100)  NULL,
    [SUB_DIVISION_ID]             BIGINT          NULL,
    [SUB_DIVISION]                NVARCHAR (100)  NULL,
    [DIVISION_ID]                 BIGINT          NULL,
    [DIVISION]                    NVARCHAR (100)  NULL,
    [DEPARTMENT_ID]               BIGINT          NULL,
    [DEPARTMENT]                  NVARCHAR (100)  NULL,
    [ORGANIZATION_ID]             BIGINT          NULL,
    [ORGANIZATION]                NVARCHAR (100)  NULL
);
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[fc_contract_mapping] TO [data_mis_project_fc_contract_mapping_read_all]
    AS [dbo];
GO

