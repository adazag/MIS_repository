




CREATE view [data_mis_project].[fc_tracked_time_test_python] as

WITH TIMESHEET_CODE AS (
SELECT  a.id ID
		,a.project_id PROJ_ID
		, a.project_name PROJ_NAME
		, a.parent_project_name PARNT_PROJ_NAME
		, a.employee_id EMPEE_ID
		, a.empee_name EMPEE_NAME
		, CAST(a.day_date as date) as DAY_DATE
		, a.month_name MTH_NAME
		, a.timesheet_code TMSHT_CODE
		, a.timesheet_code_name TMSHT_CODE_NAME
		, a.stand_by STNDBY_IND
		, a.non_billable_ind CODE_NON_BILB_IND
		, ISNULL(a.time_comment,'') as TIME_CMMNT
		, a.final_ind FINAL_IND
		, a.employee_rate_amount EMPEE_RATE_AMT
		, a.employee_rate_currency_code EMPEE_RATE_CRNCY_CODE
		, a.client_employee_rate_amount CLEN_EMPEE_RATE_AMT
		, a.client_employee_rate_currency_code CLEN_EMPEE_RATE_CRNCY_CODE
		, a.project_employee_rate_amount PROJ_EMPEE_RATE_AMT
		, a.project_employee_rate_currency_code PROJ_EMPEE_RATE_CRNCY_CODE
		, a.final_rate_amount FINAL_RATE_AMT
		, a.exchange_rate EXCHG_RATE
		, a.time_minutes TIME_MIN_AMT
		, a.time_days TIME_DAY_AMT
		, a.multiplier MULTR_RATE
		, a.final_rate_currency_code FINAL_RATE_CRNCY_CODE
		, a.final_cost_pln_amount FINAL_COST_PLN_AMT
		, a.final_cost_amount FINAL_COST_AMT
		, a.timesheet_id TMSHT_ID
		, a.ip_code CODE_IP_IND
		, a.standard_employee_rate_amount STD_EMPEE_RATE_AMT
		, a.standard_final_cost_amount STD_FINAL_COST_AMT
		, a.standard_final_cost_pln_amt STD_FINAL_COST_PLN_AMT
		, a.final_client_rate_card_id FINAL_CLEN_RATE_CARD_ID
		, a.final_client_rate_card_name FINAL_CLEN_RATE_CARD_NAME
		, a.final_rate_id FINAL_RATE_ID
		, a.final_rate_country_id FINAL_RATE_COUNTRY_ID
		, a.final_rate_role_name FINAL_RATE_ROLE_NAME
		, a.final_rate_seniority FINAL_RATE_SENIORITY
		, a.final_rate_external_role_id FINAL_RATE_EXTERNAL_ROLE_ID
		, a.standard_final_cost_rate_card_id STD_FINAL_COST_RATE_CARD_ID
		, a.standard_final_cost_rate_card_name STD_FINAL_COST_RATE_CARD_NAME
		, a.standard_final_cost_rate_id STD_FINAL_COST_RATE_ID
		, a.standard_final_cost_country_id STD_FINAL_COST_COUNTRY_ID
		, a.standard_final_cost_role_name STD_FINAL_COST_ROLE_NAME
		, a.standard_final_cost_seniority_name STD_FINAL_COST_SENIORITY
		, b.timesheet_code_id
FROM data_in.fin_actuals_vw AS a 
LEFT OUTER JOIN data_in.tmsht_time_report_vw AS b ON a.employee_id = b.employee_id AND a.project_id = b.project_id AND a.DAY_DATE = b.day_date AND a.timesheet_code = b.timesheet_code AND 
                                                                            a.timesheet_code_name = b.timesheet_code_name
WHERE   (a.DAY_DATE >= '2025-01-01')
),


OTHER_INFORMATION AS (
		SELECT a.ID
		, a.PROJ_ID
		, a.PROJ_NAME
		, a.PARNT_PROJ_NAME
		, b.client_id AS CLIENT_ID
		, b.client_name AS CLIENT_NAME
		, b.invoicing_name AS PROJECT_TYPE
		, b.project_billable_ind PROJ_BLLBL_IND
		, b.investment_ind INVST_IND
		, b.governance_ind ORGNL_MGMT_IND
		, CASE WHEN b.project_billable_ind = 1 THEN 'Billable' WHEN b.investment_ind = 1 THEN 'Investment' WHEN b.governance_ind = 1 THEN 'Governance' WHEN a.PROJ_ID <= 7 THEN 'Time off' ELSE 'Bench' END AS CATEGORY_COST
		, CASE WHEN a.PROJ_NAME LIKE 'Non-working time:%' THEN 'Lingaro' ELSE b.organization_unit_name END AS PROJECT_ORG_UNIT
		, b.work_category_name PROJ_WORK_CATEGORY_NAME
		, b.status_code PROJ_STTUS_CODE
		, b.engagement_type_name PROJ_ENGAG_NAME
		, c.ULTIMATE_PARENT_ID
		, c.ULTIMATE_PARENT_NAME
		, a.EMPEE_ID
		, a.EMPEE_NAME
		, a.DAY_DATE
		, a.MTH_NAME
		, l.competency_id
		, l.new_taxonomy_role_id
		, l.seniority_id
		, m.competency_name AS emp_competency
		, m.role_name AS emp_role
		, m.seniority_name AS emp_seniority
		, m.country_work_location AS location
		, a.TMSHT_CODE
		, a.TMSHT_CODE_NAME
		, a.STNDBY_IND
		, a.CODE_NON_BILB_IND
		, a.TIME_CMMNT
		, a.FINAL_IND
		, a.EMPEE_RATE_AMT
		, a.EMPEE_RATE_CRNCY_CODE
		, a.CLEN_EMPEE_RATE_AMT
		, a.CLEN_EMPEE_RATE_CRNCY_CODE
		, a.PROJ_EMPEE_RATE_AMT
		, a.PROJ_EMPEE_RATE_CRNCY_CODE
		, a.FINAL_RATE_AMT
		, a.EXCHG_RATE
		, a.TIME_MIN_AMT
		, a.TIME_DAY_AMT
		,hours as hours
		, a.MULTR_RATE
		, a.FINAL_RATE_CRNCY_CODE
		, a.FINAL_COST_PLN_AMT
		, a.FINAL_COST_AMT
		, a.TMSHT_ID
		, a.timesheet_code_id
		, null as NEW_TMSHT_ID
		, a.CODE_IP_IND
		, a.STD_EMPEE_RATE_AMT
		, a.STD_FINAL_COST_AMT
		, a.STD_FINAL_COST_PLN_AMT
		, a.FINAL_CLEN_RATE_CARD_ID
		, a.FINAL_CLEN_RATE_CARD_NAME
		, a.FINAL_RATE_ID
		, a.FINAL_RATE_COUNTRY_ID
		, a.FINAL_RATE_ROLE_NAME
		, a.FINAL_RATE_SENIORITY
		, a.FINAL_RATE_EXTERNAL_ROLE_ID
		, a.STD_FINAL_COST_RATE_CARD_ID
		, a.STD_FINAL_COST_RATE_CARD_NAME
		, a.STD_FINAL_COST_RATE_ID
		, a.STD_FINAL_COST_COUNTRY_ID
		, a.STD_FINAL_COST_ROLE_NAME
		, a.STD_FINAL_COST_SENIORITY
FROM TIMESHEET_CODE AS a 
LEFT OUTER JOIN data_mis.proj AS b ON a.PROJ_ID = b.project_id
LEFT OUTER JOIN data_in.proj_clnt AS c ON b.client_id = c.id 
LEFT OUTER JOIN data_in.org_emp_vw AS m ON a.EMPEE_ID = m.id 
--LEFT OUTER JOIN data_in_sulu_v1.sulu_tmsht_lkp AS d ON a.TMSHT_ID = d.TMSHT_ID 
LEFT OUTER JOIN data_in.tmsht AS e ON a.EMPEE_ID = e.employee_id AND a.DAY_DATE >= e.start_date AND a.DAY_DATE <= e.end_date 
LEFT OUTER JOIN (
SELECT id, timesheet_id, version_number, status, close_date, legacy_timesheet_id, changed_date, reopen_reason, last_version, hibernate_version
FROM      data_in.tmsht_ver
WHERE   (last_version = 1)) AS f ON e.id = f.timesheet_id 
LEFT OUTER JOIN [data_in].[tmsht_time_report_vw] AS l ON a.EMPEE_ID = l.employee_id and a.PROJ_ID = l.project_id AND a.DAY_DATE = l.day_date and a.timesheet_code_id = l.timesheet_code_id AND a.TIME_CMMNT = l.comment AND a.MTH_NAME >= '2024-01'
),
					   

CONNECT_ALL AS (
SELECT  a.ID,
		a.PROJ_ID,
		a.PROJ_NAME,
		a.PARNT_PROJ_NAME,
		a.CLIENT_ID,
		a.CLIENT_NAME,
		a.PROJECT_TYPE,
		a.PROJ_BLLBL_IND,
		a.INVST_IND,
		a.ORGNL_MGMT_IND,
		a.CATEGORY_COST,
		a.PROJECT_ORG_UNIT,
		a.PROJ_WORK_CATEGORY_NAME,
		a.PROJ_STTUS_CODE,
		a.PROJ_ENGAG_NAME,
		a.ULTIMATE_PARENT_ID,
		a.ULTIMATE_PARENT_NAME,
		a.EMPEE_ID,
		a.EMPEE_NAME,
		a.DAY_DATE,
		a.MTH_NAME,
		a.competency_id AS COMPETENCY_ID,
		d.name AS COMPETENCY_NAME,
		a.new_taxonomy_role_id AS NEW_TAXONOMY_ROLE_ID,
		b.name AS NEW_TAXONOMY_ROLE_NAME,
		a.seniority_id AS SENIORITY_ID,
		c.name AS SENIORITY_NAME,
		a.emp_competency,
		a.emp_role,
		a.emp_seniority,
		a.location AS LOCATION,
		a.TMSHT_CODE,
		a.TMSHT_CODE_NAME,
		a.STNDBY_IND,
		a.CODE_NON_BILB_IND,
		a.TIME_CMMNT,
		a.FINAL_IND,
		a.EMPEE_RATE_AMT,
		a.EMPEE_RATE_CRNCY_CODE,
		a.CLEN_EMPEE_RATE_AMT,
		a.CLEN_EMPEE_RATE_CRNCY_CODE,
		a.PROJ_EMPEE_RATE_AMT,
		a.PROJ_EMPEE_RATE_CRNCY_CODE,
		a.FINAL_RATE_AMT,
		a.EXCHG_RATE,
		a.TIME_MIN_AMT,
		a.TIME_DAY_AMT,
		hours,
		a.MULTR_RATE,
		a.FINAL_RATE_CRNCY_CODE,
		a.FINAL_COST_PLN_AMT,
		a.FINAL_COST_AMT,
		a.TMSHT_ID,
		a.timesheet_code_id,
		a.NEW_TMSHT_ID,
		a.CODE_IP_IND,
		a.STD_EMPEE_RATE_AMT, 
        a.STD_FINAL_COST_AMT,
		a.STD_FINAL_COST_PLN_AMT,
		a.FINAL_CLEN_RATE_CARD_ID,
		a.FINAL_CLEN_RATE_CARD_NAME,
		a.FINAL_RATE_ID,
		a.FINAL_RATE_COUNTRY_ID,
		a.FINAL_RATE_ROLE_NAME, 
        a.FINAL_RATE_SENIORITY, 
		a.FINAL_RATE_EXTERNAL_ROLE_ID,
		a.STD_FINAL_COST_RATE_CARD_ID,
		a.STD_FINAL_COST_RATE_CARD_NAME,
		a.STD_FINAL_COST_RATE_ID,
		a.STD_FINAL_COST_COUNTRY_ID, 
        a.STD_FINAL_COST_ROLE_NAME, 
		a.STD_FINAL_COST_SENIORITY
FROM OTHER_INFORMATION AS a 
LEFT OUTER JOIN data_in.role AS b ON a.new_taxonomy_role_id = b.id
LEFT OUTER JOIN data_in.seniority AS c ON a.seniority_id = c.id 
LEFT OUTER JOIN data_in.new_taxonomy_competency AS d ON a.competency_id = d.id)

SELECT a.ID
		, PROJ_ID
		, PROJ_NAME
		, PARNT_PROJ_NAME
		, CLIENT_ID
		, CLIENT_NAME
		, PROJECT_TYPE
		, PROJ_BLLBL_IND
		, INVST_IND
		, ORGNL_MGMT_IND
		, CATEGORY_COST
		, PROJECT_ORG_UNIT
		, PROJ_WORK_CATEGORY_NAME
		, PROJ_STTUS_CODE
		, PROJ_ENGAG_NAME
		, ULTIMATE_PARENT_ID
		, ULTIMATE_PARENT_NAME
		, EMPEE_ID, EMPEE_NAME
		,b.sub_bu_name
		,b.delivery_team_name
		, DAY_DATE
		, MTH_NAME
		, CASE WHEN a.COMPETENCY_NAME IS NOT NULL THEN a.COMPETENCY_NAME ELSE emp_competency END AS COMPETENCY_NAME
		, CASE WHEN NEW_TAXONOMY_ROLE_NAME IS NOT NULL THEN NEW_TAXONOMY_ROLE_NAME ELSE emp_role END AS NEW_TAXONOMY_ROLE_NAME
		, CASE WHEN a.SENIORITY_NAME IS NOT NULL THEN a.SENIORITY_NAME ELSE emp_seniority END AS SENIORITY_NAME
		, LOCATION
		, TMSHT_CODE
		, TMSHT_CODE_NAME
		, STNDBY_IND
		, CODE_NON_BILB_IND
		, TIME_CMMNT
		, FINAL_IND
		, EMPEE_RATE_AMT
		, EMPEE_RATE_CRNCY_CODE
		, CLEN_EMPEE_RATE_AMT
		, CLEN_EMPEE_RATE_CRNCY_CODE
		, PROJ_EMPEE_RATE_AMT
		, PROJ_EMPEE_RATE_CRNCY_CODE
		, FINAL_RATE_AMT
		, EXCHG_RATE
		, TIME_MIN_AMT
		, TIME_DAY_AMT
		,hours
		, MULTR_RATE
		, FINAL_RATE_CRNCY_CODE
		, FINAL_COST_PLN_AMT
		, FINAL_COST_AMT
		, TMSHT_ID
		, timesheet_code_id
		, NEW_TMSHT_ID
		, CODE_IP_IND
		, STD_EMPEE_RATE_AMT
		, STD_FINAL_COST_AMT
		, STD_FINAL_COST_PLN_AMT
		, FINAL_CLEN_RATE_CARD_ID
		, FINAL_CLEN_RATE_CARD_NAME
		, FINAL_RATE_ID
		, FINAL_RATE_COUNTRY_ID
		, FINAL_RATE_ROLE_NAME
		, FINAL_RATE_SENIORITY
		, FINAL_RATE_EXTERNAL_ROLE_ID
		, STD_FINAL_COST_RATE_CARD_ID
		, STD_FINAL_COST_RATE_CARD_NAME
		, STD_FINAL_COST_RATE_ID
		, STD_FINAL_COST_COUNTRY_ID
		, STD_FINAL_COST_ROLE_NAME
		, STD_FINAL_COST_SENIORITY
FROM CONNECT_ALL AS a
left join data_mis.org_emp b on a.EMPEE_ID=b.id
where bu_name='CC'
GO

