create view [data_mis_project].[sulu_rebaseline_reason_lkp] as(
SELECT
 	id REASON_ID
	,reason_text REASON_TXT
	,active_ind ACTV_IND
FROM data_in.proj_rebaseline_reason

)
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[sulu_rebaseline_reason_lkp] TO [data_mis_project_sulu_rebaseline_reason_lkp_read_all]
    AS [dbo];
GO

