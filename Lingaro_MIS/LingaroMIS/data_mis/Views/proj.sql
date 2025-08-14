







CREATE view [data_mis].[proj] as 

SELECT   a.project_id
		,a.name AS project_name
		,a.code
		,a.parent_project_id
		,pr.name AS parent_project_name
		,pr.manager_id as parent_project_manager_employee_id
		,a.parent_project_ind
		,a.client_id
		,i.name AS client_name
		,a.start_date
		,a.end_date
		,a.manager_id AS proj_manager_id
		,j.employee_full_name AS proj_manager_name
		,a.time_off_ind
		,a.project_billable_ind
		,a.governance_ind
		,a.investment_ind
		,a.change_date
		,a.status_code
		,a.client_rate_card_id
		,a.invoicing_code
		,b.name AS invoicing_name
		,a.change_by
		,a.project_invoicing_info_old
		,a.overtime_compensation_ind
		,a.holiday_ind
		,a.obs_client_project_manager_name_old
		,a.sick_leave_ind
		,a.personal_leave_ind
		,a.other_time_off_ind
		,a.share_point_link
		,a.bm_confirmation_alert_ind
		,a.svn_link
		,a.engagement_type_id
		,d.name AS engagement_type_name
		,a.management_tool_id
		,c.name AS management_tool_name
		,a.obs_client_project_manager_mail_old
		,a.wiki_link
		,a.default_currency
		,a.description
		,a.information_classification_code
		,a.cheetah_project_ind
		,a.client_contact_id
		,CONCAT (m.FIRST_NAME,' ',m.LAST_NAME) client_contact_name
		,m.email_text AS client_contact_email
		,a.creation_date
		,a.engagement_scope
		,a.assumptions_constraints
		,a.high_level_risks
		,a.engagement_rules
		,a.department_id
		,a.share_point_auto_link
		,a.region_id
		,e.name AS region_name
		,a.share_point_status_code
		,a.is_status_required
		,a.share_point_group_name
		,a.share_point_account_name
		,a.service_area_id
		,f.name AS service_area_name
		,h.organization_unit_id
		,a.business_unit_id_deprecated as business_unit_id
		,o.org_unit_name AS organization_unit_name
		,o.organization_name as business_unit_name
		,o.department_name as sub_business_unit_name
		,o.division_name as senior_delivery_team_name
		,o.sub_division_name as delivery_team_name
		,o.TEAM_NAME as team_name
		,a.it_client_project_manager_id
		,a.business_client_project_manager_id
		,a.new_cheetah_ind
		,a.double_counting_ind
		,a.new_sales_ind
		,a.cloud_project_ind
		,a.sow_sign_date
		,a.coupa_number
		,a.coupa_cr_number
		,a.parent_financial_project_id
		,pfr.name as parent_financial_project_name
		,parent_fin_proj_ind as parent_financial_project_ind
		,a.pg_band_three_id_deprecated as pg_band_three_id
		,a.security_leader_id
		,a.sales_force_opportunity_id
		,a.jira_tenant_id
		,a.jira_integration_ind
		,a.first_start_date
		,a.first_end_date
		,a.project_scale
		,a.project_risk
		,a.business_criticality
		,a.project_priority
		,a.development_by_lingaro_ind
		,a.technical_leader_id
		,l.employee_full_name AS technical_leader_name
		,a.sonar_link
		,a.revenue_type
		,a.share_point_status_link
		,a.share_point_group_id
		,a.share_point_error_message
		,a.parent_dc_project_id
		,a.manual_revenue_recognition_ind
		,a.internal_code_repository
		,a.work_category_id
		,g.name AS work_category_name
		,a.agile_framework_id
		,a.agile_score
		,a.program_id
		,a.is_health_check_required
		,CASE WHEN a.start_date > GETDATE() THEN 'future' 
		 WHEN a.end_date < GETDATE() THEN 'finished' ELSE 'in progress' END AS active
		,a.engagement_manager_id
		,em.employee_full_name as engagement_manager_name
		,pvw. predecessor_id
		,pvw.predecessor_name
		,a.project_id_used_for_share_point_creation as repo_project_id
FROM data_in.proj AS a
LEFT OUTER JOIN data_in.proj AS pr ON pr.project_id = a.parent_project_id
LEFT OUTER JOIN data_in.proj AS pfr ON pfr.project_id = a.parent_financial_project_id
LEFT OUTER JOIN data_in.invoicing_type AS b ON a.invoicing_code = b.code 
LEFT OUTER JOIN data_in.proj_management_tool AS c ON a.management_tool_id = c.id
LEFT OUTER JOIN data_in.proj_engagement_type AS d ON a.engagement_type_id = d.id 
LEFT OUTER JOIN data_in.proj_region AS e ON a.region_id = e.id 
LEFT OUTER JOIN data_in.proj_service_area AS f ON a.service_area_id = f.id
LEFT OUTER JOIN data_in.proj_work_category AS g ON a.work_category_id = g.id
LEFT OUTER JOIN data_in.proj_organization_unit AS h ON a.project_id = h.project_id AND h.current_ind = 1
LEFT OUTER JOIN data_in.proj_clnt AS i ON a.client_id = i.id 
LEFT OUTER JOIN data_in.org_emp_vw AS j ON a.manager_id = j.id
LEFT OUTER JOIN data_in.org_emp_vw AS l ON a.technical_leader_id = l.id
LEFT OUTER JOIN data_in.org_emp_vw AS em ON a.engagement_manager_id = em.id
LEFT OUTER JOIN data_in.proj_client_contact AS m ON a.client_contact_id = m.id
LEFT OUTER JOIN data_mis.org_structure_new AS o ON h.organization_unit_id = o.org_unit_id
LEFT JOIN data_in.proj_vw pvw on pvw.project_id = a.project_id 
WHERE EXISTS (
    SELECT 1 
    FROM data_mis_project.sec_emp_all_permission
    WHERE permission_name = 'PERM_PROJECTS_READ' AND email = USER_NAME()
) 
OR IS_MEMBER('db_owner') = 1 OR USER_NAME() = 'ADF-Automation-Team' OR USER_NAME() = 'PMCC mis connector' OR USER_NAME() = 'lingaro.manila.apps@lingarogroup.com'
GO

GRANT SELECT
    ON OBJECT::[data_mis].[proj] TO [ADF-Automation-Team]
    AS [dbo];
GO

