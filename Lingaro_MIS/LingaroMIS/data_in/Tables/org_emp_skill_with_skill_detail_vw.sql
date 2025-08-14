CREATE TABLE [data_in].[org_emp_skill_with_skill_detail_vw] (
    [employee_id]        BIGINT         NULL,
    [employee_full_name] NVARCHAR (201) NULL,
    [org_unit_id]        BIGINT         NULL,
    [org_unit_name]      NVARCHAR (100) NULL,
    [skill_id]           BIGINT         NULL,
    [skill_name]         NVARCHAR (100) NULL,
    [skill_detail_id]    BIGINT         NULL,
    [skill_detail_name]  NVARCHAR (300) NULL,
    [skill_level]        NVARCHAR (100) NULL,
    [priority]           NVARCHAR (100) NULL
);
GO

