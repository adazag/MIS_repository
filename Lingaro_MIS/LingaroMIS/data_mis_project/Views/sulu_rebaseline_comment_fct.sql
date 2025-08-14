create view [data_mis_project].[sulu_rebaseline_comment_fct] as (
SELECT 
project_id PROJ_ID
,comment REBASELINE_COMMENT
,created_by CREATED_BY
,creation_at CREATION_DATE
,modified_by MODIFIED_BY
,modified_at MODIFIED_DATE
FROM data_in.proj_rebaseline_comment
)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[sulu_rebaseline_comment_fct] TO [data_mis_project_sulu_rebaseline_comment_fct_read_all]
    AS [dbo];
GO

