CREATE TABLE [rls].[org_unit_emp_full_path] (
    [org_id]                   BIGINT         NULL,
    [start_date]               DATE           NULL,
    [end_date]                 DATE           NULL,
    [leader_id]                BIGINT         NULL,
    [bu_leader_id]             BIGINT         NULL,
    [leader_login]             NVARCHAR (150) NULL,
    [leader_path]              VARCHAR (255)  NULL,
    [leader_path_to_bu_leader] VARCHAR (255)  NULL
);
GO

