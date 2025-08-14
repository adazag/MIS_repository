
CREATE view [data_out_ad].[lttst_accnt] as  
with ts as (
select t.id as TMSHT_ID
            , tpc.timesheet_code_id as TMSHT_CODE_ID
            , t.employee_id as EMPEE_ID
			, emp.employee_full_name as EMPEE_FULL_NAME
			, emp.email as EMPEE_EMAIL
            , cast(dateadd(day, 6, t.start_date) as date) [TMSHT_END_DATE]
            , tvp.project_id as PROJ_ID
			, p.name as PROJ_NAME
            , p.client_id as CLEN_ID
			, cl.name as CLEN_NAME
       from data_in.tmsht t
                left join data_in.tmsht_ver tv on t.id = tv.timesheet_id
				left join data_in.tmsht_ver_proj tvp on tvp.timesheet_version_id = tv.id
				left join data_in.tmsht_ver_proj_code tpc on tvp.id = tpc.timesheet_version_project_id
				left join data_in.tmsht_ver_proj_code_time tpct on tpc.id = tpct.version_project_code_id
                left join data_in.proj p on p.project_id = tvp.project_id
				left join data_in.proj_clnt cl on cl.id=p.client_id
				left join data_in.org_emp_vw emp on t.employee_id = emp.id
       where tv.status <> 'REJECTED'
         and dateadd(day, 7, t.start_date) >= dateadd(year, -1, getdate())
),

actl as (
select  distinct
ts.EMPEE_ID, EMPEE_FULL_NAME, EMPEE_EMAIL, ts.CLEN_ID, CLEN_NAME, PROJ_ID, PROJ_NAME, TMSHT_END_DATE LATEST_DATE from ts
inner join
(select EMPEE_ID, CLEN_ID, MAX(TMSHT_END_DATE) LATEST_TMSHT_END_DATE from ts
group by EMPEE_ID, CLEN_ID) tsa
on tsa.EMPEE_ID=ts.EMPEE_ID and tsa.CLEN_ID=ts.CLEN_ID and tsa.LATEST_TMSHT_END_DATE=ts.TMSHT_END_DATE
),

book_all as (
SELECT b.employee_id as [EMPEE_ID]
      ,employee_full_name as EMPEE_FULL_NAME
	  ,e.email as EMPEE_EMAIL
      ,b.project_id as [PROJ_ID]
      ,b.project_name as [PROJ_NAME]
      ,cast([DAY_DATE] as date) LATEST_DATE
	  ,p.client_id as CLEN_ID
	  ,cl.name as CLEN_NAME
  FROM data_in.proj_booking_daily_vw b
  left join data_in.proj p on p.project_id=b.project_id
  left join data_in.proj_clnt cl on cl.id=p.client_id
  left join data_in.org_emp e on e.id=b.employee_id
  where status <> 'REJECTED'
  and [DAY_DATE] >= dateadd(year, -1, GETDATE())
),

book as (
select distinct
b.EMPEE_ID, EMPEE_FULL_NAME, EMPEE_EMAIL, b.CLEN_ID, CLEN_NAME, PROJ_ID, PROJ_NAME, b.LATEST_DATE from book_all b
inner join
(select EMPEE_ID, CLEN_ID, MAX(LATEST_DATE) LATEST_DATE from book_all
group by EMPEE_ID, CLEN_ID) ba
on ba.EMPEE_ID=b.EMPEE_ID and ba.CLEN_ID=b.CLEN_ID and ba.LATEST_DATE=b.LATEST_DATE
),



tot as (
select actl.*, 'ACTUAL' as TYPE from actl
UNION ALL
select book.*, 'BOOKING' as TYPE from book
),


owner_team_proj as (
SELECT 
	[project_id]
    ,[project_name]
    ,[code]
    ,[parent_project_id]
    ,[parent_project_name]
    ,[parent_project_manager_employee_id]
    ,[parent_project_ind]
    ,[client_id]
    ,[client_name]
    ,[start_date]
    ,[end_date]
    ,[proj_manager_id]
    ,[proj_manager_name]
    ,[time_off_ind]
    ,[project_billable_ind]
    ,[governance_ind]
    ,[investment_ind]
    ,[change_date]
    ,[status_code]
    ,[client_rate_card_id]
    ,[invoicing_code]
    ,[invoicing_name]
    ,[change_by]
    ,[project_invoicing_info_old]
    ,[overtime_compensation_ind]
    ,[holiday_ind]
    ,[obs_client_project_manager_name_old]
    ,[sick_leave_ind]
    ,[personal_leave_ind]
    ,[other_time_off_ind]
    ,[share_point_link]
    ,[bm_confirmation_alert_ind]
    ,[svn_link]
    ,[engagement_type_id]
    ,[engagement_type_name]
    ,[management_tool_id]
    ,[management_tool_name]
    ,[obs_client_project_manager_mail_old]
    ,[wiki_link]
    ,[default_currency]
    ,[description]
    ,[information_classification_code]
    ,[cheetah_project_ind]
    ,[client_contact_id]
    ,[client_contact_name]
    ,[client_contact_email]
    ,[creation_date]
    ,[engagement_scope]
    ,[assumptions_constraints]
    ,[high_level_risks]
    ,[engagement_rules]
    ,[department_id]
    ,[share_point_auto_link]
    ,[region_id]
    ,[region_name]
    ,[share_point_status_code]
    ,[is_status_required]
    ,[share_point_group_name]
    ,[share_point_account_name]
    ,[service_area_id]
    ,[service_area_name]
    ,[organization_unit_id]
    ,[business_unit_id]
    ,[organization_unit_name]
    ,[business_unit_name]
    ,[sub_business_unit_name]
    ,[senior_delivery_team_name]
    ,[delivery_team_name]
    ,[team_name]
    ,[it_client_project_manager_id]
    ,[business_client_project_manager_id]
    ,[new_cheetah_ind]
    ,[double_counting_ind]
    ,[new_sales_ind]
    ,[cloud_project_ind]
    ,[sow_sign_date]
    ,[coupa_number]
    ,[coupa_cr_number]
    ,[parent_financial_project_id]
    ,[parent_financial_project_name]
    ,[parent_financial_project_ind]
    ,[pg_band_three_id]
    ,[security_leader_id]
    ,[sales_force_opportunity_id]
    ,[jira_tenant_id]
    ,[jira_integration_ind]
    ,[first_end_date]
    ,[project_scale]
    ,[project_risk]
    ,[business_criticality]
    ,[project_priority]
    ,[development_by_lingaro_ind]
    ,[technical_leader_id]
    ,[technical_leader_name]
    ,[sonar_link]
    ,[revenue_type]
    ,[share_point_status_link]
    ,[share_point_group_id]
    ,[share_point_error_message]
    ,[parent_dc_project_id]
    ,[manual_revenue_recognition_ind]
    ,[internal_code_repository]
    ,[work_category_id]
    ,[work_category_name]
    ,[agile_framework_id]
    ,[agile_score]
    ,[program_id]
    ,[is_health_check_required]
    ,[active]
FROM data_mis.proj),

emp as (
select 
	[id]
    ,[ldap_login]
    ,[last_name]
    ,[first_name]
    ,[line_manager_id]
    ,[photo_ind]
    ,[phone_number]
    ,[email]
    ,[position_id]
    ,[location]
    ,[non_employee_ind]
    ,[work_experience]
    ,[pg_walmart_cda_valid_deprecated]
    ,[pg_t_number_deprecated]
    ,[pg_user_name_deprecated]
    ,[gender_code]
    ,[nationality_id]
    ,[maiden_name]
    ,[disable_timesheet_generation]
    ,[sponsor_email_deprecated]
    ,[rhir_training_date_deprecated]
    ,[rhir_training_status_id_deprecated]
    ,[pg_pos_training_status_id_deprecated]
    ,[role]
    ,[pg_pos_training_expire_date_deprecated]
    ,[auto_approval_time_off_ind]
    ,[create_ip_ind]
    ,[primary_competency_id]
    ,[technical_account_ind]
    ,[active_ind]
    ,[functional_manager_id]
    ,[location_id]
    ,[allow_photo_usage_ind]
    ,[allow_fm_approve_timesheet_ind]
    ,[allow_fm_approve_time_off]
    ,[allow_fm_grant_overtime_perm]
    ,[leave_ind]
    ,[ad_object_id]
    ,[allow_applying_ooo_ind]
    ,[az_ad_object_id]
    ,[country_id]
    ,[city_id]
    ,[country_work_location_id]
    ,[allow_displaying_holidays_ind]
    ,[created_by]
    ,[modified_by]
    ,[modified_at]
    ,[creation_at]
    ,[management_community_member_ind]
    ,[team_owner_ind]
    ,[team_leader_ind]
    ,[az_ad_account_enabled_ind]
    ,[personal_leave_per_year]
    ,[skills_reviewed_at]
    ,[competency_role_id]
    ,[leaver_ind_modified_at]
    ,[billable_ind]
    ,[total_work_experience]
    ,[project_manager_ind]
    ,[service_level_manager_ind]
    ,[seniority_id]
    ,[skills_reviewed_ind]
    ,[leaver_notice_date]
    ,[leaver_reason_id]
    ,[long_term_leave_ind]
    ,[long_term_leave_modified_at]
    ,[long_term_leave_start_date]
    ,[long_term_leave_end_date]
    ,[leaver_last_day_of_work]
    ,[managerial_requirements_profile_id]
    ,[new_hire_ind]
    ,[external_ind]
    ,[external_type_id]
    ,[gallup_assessment_ind]
    ,[shift_time_id]
    ,[resource_row_id]
    ,[draft_profile_ind]
from [data_in].[org_emp])

select tot.*, owner_team_proj.parent_project_manager_employee_id, emp.email as PARNT_PROJ_MGR_EMPEE_MAIL, emp.az_ad_object_id PARNT_PROJ_MGR_az_ad_object_id, emp.ad_object_id as PARNT_PROJ_MGR_ad_object_id  from tot
left join owner_team_proj on tot.PROJ_ID=owner_team_proj.project_id
left join emp on owner_team_proj.parent_project_manager_employee_id=emp.id
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[lttst_accnt] TO [michal.jablonski3@lingarogroup.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[lttst_accnt] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[lttst_accnt] TO [ADF-Automation-Team]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[lttst_accnt] TO [data_out_ad_read_all]
    AS [dbo];
GO

