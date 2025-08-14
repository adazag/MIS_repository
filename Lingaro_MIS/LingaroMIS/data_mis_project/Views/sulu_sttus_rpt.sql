create view data_mis_project.sulu_sttus_rpt as(
select 
p.BUSINESS_UNIT_NAME BU_NAME,
p.SUB_BUSINESS_UNIT_NAME SUB_BU_NAME,
p.SENIOR_DELIVERY_TEAM_NAME,
p.DELIVERY_TEAM_NAME,
p.TEAM_NAME,
p.project_id PROJ_ID, 
pg.project_id AS PARNT_PROJ_ID, 
pg.name AS GROUP_NAME, 
p.organization_unit_name ORG_UNIT_NAME,
p.project_name  AS PROJ_NAME,
p.proj_manager_id PROJ_MGR_EMPEE_ID,
e.employee_full_name EMPEE_FULL_NAME,
ps.status_day_date STTUS_DATE,
ps.overall_health_status OVRAL_HLTH_STTUS,
ps.cost_status COST_STTUS,
ps.time_status TIME_STTUS,
ps.scope_status SCOPE_STTUS,
ps.FULL_LINK,
ps.modified_at CHNG_TIME_STAMP,
ps.modified_by CHNG_EMPEE_ID,
ps.current_ind CURR_IND,
ps.project_finance_current PROJ_FIN_CURR,
ps.project_finance_forecast PROJ_FIN_FRCST_END,
ps.project_finance_currency PROJ_FIN_CRNCY,
ps.automatic_generated_report_ind AUTO_GEN_RPT_IND,
ps.executive_summary EXEC_SUMRY,
ps.completed_activities_past_week COMPL_ACTV_PAST_WEEK,
ps.activities_planned_next_week ACTV_PLND_NEXT_WEEK,
ps.help_needed HELP_NEED_TXT,
ps.identified_risk IDTFD_RISK_TXT,
ps.full_link STTUS_HTML,
NULL as TMPL_ID,
ps.LAST_MODIFIED_BY,
ps.help_needed_lingaro HELP_NEED_LINGARO_TXT,
ps.resource_status RESOURCE_STTUS,
ps.resource_status_visibility RESOURCE_STTUS_VISIBILITY,
ps.cost_status_visibility COST_STTUS_VISIBILITY,
ps.time_status_visibility TIME_STTUS_VISIBILITY,
ps.scope_status_visibility SCOPE_STTUS_VISIBILITY



FROM (
SELECT 
		spsl.*,
		CONCAT(sel.first_name,' ',sel.last_name)  as "LAST_MODIFIED_BY"
	
FROM data_in.proj_status_report spsl 
--JOIN data_in_sulu_v1.SULU_PROJ_LKP spl ON spsl.PROJ_ID = spl.PROJ_ID 
JOIN data_in.org_emp sel ON spsl.modified_by  = sel.id ) ps 
RIGHT JOIN data_mis.proj p ON ps.project_id = p.project_id
LEFT JOIN data_in.proj pg ON p.parent_project_id = pg.project_id
JOIN data_in.org_emp_vw e ON p.proj_manager_id = e.id
LEFT JOIN data_in.proj_clnt c  ON c.id = p.client_id
LEFT JOIN data_in.org_emp mod_empee ON mod_empee.id = ps.modified_by
LEFT JOIN (select left(max(change_time_stamp),10) as status_change_date, project_id PROJ_ID  
FROM data_in.proj_project_status_history group by project_id) s ON s.proj_id = ps.project_id
WHERE p.parent_project_ind = 0  AND ps.status_day_date >= '2022-01-01')
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[sulu_sttus_rpt] TO [data_mis_project_sulu_sttus_rpt_read_all]
    AS [dbo];
GO

