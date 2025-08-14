CREATE TABLE [data_in].[proj_org_unit] (
    [project_organization_unit_id] BIGINT NOT NULL,
    [project_id]                   BIGINT NULL,
    [organization_unit_id]         BIGINT NULL,
    [start_date]                   DATE   NULL,
    [end_date]                     DATE   NULL,
    [current_ind]                  BIT    NULL
);
GO

