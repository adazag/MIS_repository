CREATE TABLE [data_mis_project].[capacity_vs_demand_report] (
    [EMPEE_ID]               BIGINT           NULL,
    [DAY_DATE]               DATE             NULL,
    [DAYS]                   DECIMAL (38, 19) NULL,
    [TYPE]                   VARCHAR (8)      NOT NULL,
    [STATUS]                 NVARCHAR (20)    NULL,
    [PROJ_ID]                BIGINT           NULL,
    [BOOKG_START_DATE]       DATE             NULL,
    [BOOKG_END_DATE]         DATE             NULL,
    [BOOKG_COMMENT]          NVARCHAR (4000)  NULL,
    [NEW_TAXONOMY_ROLE_NAME] NVARCHAR (100)   NULL,
    [SENIORITY_NAME]         NVARCHAR (200)   NULL,
    [ALLOCATION%]            DECIMAL (38, 17) NULL,
    [ALLOCATION_WEEK%]       DECIMAL (38, 17) NULL
);
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[capacity_vs_demand_report] TO [Resourcing_data_read]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[capacity_vs_demand_report] TO [data_mis_project_capacity_vs_demand_read_all]
    AS [dbo];
GO

