





CREATE VIEW [data_mis_thor].[project] as (
SELECT   project_id
		,project_name
		,code
		, parent_project_id
		, parent_project_name
		, parent_project_ind
		,a. client_id
		, client_name
		, start_date
		, end_date
		, proj_manager_id
		, proj_manager_name
		, a.time_off_ind
		, project_billable_ind
		, governance_ind
		, investment_ind
		, change_date
		, status_code
		, client_rate_card_id
		, invoicing_code
		, invoicing_name
		, change_by
		, project_invoicing_info_old
		, overtime_compensation_ind
		, holiday_ind
		, obs_client_project_manager_name_old
		, a.sick_leave_ind
		, personal_leave_ind
		, a.other_time_off_ind
		, share_point_link
		, bm_confirmation_alert_ind
		, svn_link
		, engagement_type_id
		, engagement_type_name
		, management_tool_id
		, management_tool_name
		, obs_client_project_manager_mail_old
		, wiki_link
		, default_currency
		, description
		, information_classification_code
		, cheetah_project_ind
		, client_contact_id
		, client_contact_email


		, client_contact_name as clen_proj_mgr_name


		, creation_date, engagement_scope
		, assumptions_constraints
		, high_level_risks
		, engagement_rules
		, department_id
		, share_point_auto_link
		, region_id
		, region_name
		, share_point_status_code
		, is_status_required
		, share_point_group_name
		, share_point_account_name
		, service_area_id
		, service_area_name
		, organization_unit_id
		, business_unit_id
		, organization_unit_name
		, BUSINESS_UNIT_NAME as business_unit_name
		, SUB_BUSINESS_UNIT_NAME as sub_business_unit_name
		, a.DELIVERY_TEAM_NAME as delivery_team_name
		, a.TEAM_NAME as team_name
		, it_client_project_manager_id
		, business_client_project_manager_id
		, new_cheetah_ind
		, double_counting_ind
		, a.new_sales_ind
		, cloud_project_ind
		, a.sow_sign_date
		, coupa_number
		, coupa_cr_number
		, parent_financial_project_id
		, pg_band_three_id
		, security_leader_id
		, sales_force_opportunity_id
		, jira_tenant_id
		, jira_integration_ind
		, a.first_end_date
		, a.project_scale
		, a.project_risk
		, a.business_criticality
		, a.project_priority
		, development_by_lingaro_ind
		, technical_leader_id
		, technical_leader_name
		, sonar_link
		, revenue_type
		, share_point_status_link
		, share_point_group_id
		, share_point_error_message
		, parent_dc_project_id
		, manual_revenue_recognition_ind
		, a.internal_code_repository
		, work_category_id
		, work_category_name
		, agile_framework_id
		, agile_score
		, program_id
FROM     data_mis.proj a
--left join [data_in_sulu_v1].[sulu_proj_hier_vw] b on a.project_id = b.PROJ_ID
left join data_in.proj_client_contact b on a.client_contact_id=b.id
WHERE  (a.client_id in ( 43,564788, 564787,62,	43760,	43766,	43779,	43784,	43790,	43793,	46869,	108155,	108156,	108157,	108344,	136812,	553615,	1020859
)) )
GO

GRANT ALTER
    ON OBJECT::[data_mis_thor].[project] TO [data_mis_thor_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_thor].[project] TO [data_mis_thor_read_all]
    AS [dbo];
GO

