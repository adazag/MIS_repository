CREATE TABLE [data_in_cxms].[dim_assessor_project] (
    [rdate]                     DATE           NULL,
    [assessor_id]               INT            NULL,
    [project_id]                INT            NULL,
    [alternative_project_score] DECIMAL (3, 1) NULL,
    [assessment_type]           NVARCHAR (50)  NULL,
    [valid_from]                DATETIME2 (7)  NULL,
    [valid_to]                  DATETIME2 (7)  NULL,
    [assessor_role]             VARCHAR (50)   NULL
);
GO

