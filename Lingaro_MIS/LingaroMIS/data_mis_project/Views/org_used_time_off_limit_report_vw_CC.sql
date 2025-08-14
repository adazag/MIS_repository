
CREATE view [data_mis_project].[org_used_time_off_limit_report_vw_CC]

as

WITH used_time_off_1 AS (SELECT id, employee_full_name, employee_id, start_date, ISNULL(end_date, '9999-01-01') AS end_date, time_off_limit, used_limit, available_limit_hours, available_limit_days, time_off_type, lm_id, lm_full_name, fm_full_name, old_sulu_ind, org_unit_name, bu_name, 
                                                        legal_entity, contract_type, used_up_to_today, available_up_to_today, used_up_to_previous_month
                                          FROM    data_in.org_used_time_off_limit_report_vw), organizational_structure AS
    (SELECT id, employee_id, organization_unit_id, start_date, ISNULL(end_date, '9999-01-01') AS end_date
    FROM    data_in.org_emp_org_unit), employee AS
    (SELECT id, ldap_login, last_name, first_name, employee_full_name, line_manager_id, line_manager, functional_manager_id, functional_manager, phone_number, email, maiden_name, gender_code, nationality_id, nationality_name, country_id, country_name, city_id, city_name, 
                 country_work_location_id, country_work_location_name, position_id, position_name, seniority_id, seniority_name, role, role_name, competency_name, active_ind, contract_termination_date, employment_date, contract_type, fte, leave_ind, exp_before_lingaro, 
                 total_work_experience, exp_in_lingaro, management_community_member_ind, team_owner_ind, team_leader_ind, project_manager_ind, service_level_manager_ind, non_employee_ind, technical_account_ind, billable_ind, org_unit_name, team_name, delivery_team_name, 
                 senior_delivery_team_name, sub_bu_name, bu_name, photo_ind, pg_walmart_cda_valid, disable_timesheet_generation, sponsor_email, rhir_training_date, rhir_training_status_id, pg_pos_training_status_id, pg_pos_training_expire_date, 
                 auto_approval_time_off_ind, create_ip_ind, allow_photo_usage_ind, allow_fm_approve_timesheet_ind, allow_fm_approve_time_off, allow_fm_grant_overtime_perm, ad_object_id, allow_applying_ooo_ind, az_ad_object_id, allow_displaying_holidays_ind, created_by, modified_by, 
                 modified_at, creation_at, az_ad_account_enabled_ind, personal_leave_per_year, skills_reviewed_at, leaver_ind_modified_at, skills_reviewed_ind, leaver_notice_date, leaver_reason_id, leaver_reason_name, long_term_leave_ind, long_term_leave_modified_at, 
                 long_term_leave_start_date, long_term_leave_end_date, leaver_last_day_of_work, managerial_requirements_profile_id
    FROM    data_mis.org_emp), report_org AS
    (SELECT id, employee_full_name, employee_id, org_unit_name, bu_name, legal_entity, contract_type, start_date, end_date, time_off_limit, used_limit, available_limit_hours, available_limit_days, time_off_type, lm_id, lm_full_name, fm_full_name, old_sulu_ind, used_up_to_today, 
                 available_up_to_today, used_up_to_previous_month
    FROM    used_time_off_1 AS a)
    SELECT id, employee_full_name, employee_id, org_unit_name, bu_name, legal_entity, contract_type, start_date, end_date, time_off_limit, used_limit, available_limit_hours, available_limit_days, time_off_type, lm_id, lm_full_name, fm_full_name, old_sulu_ind, used_up_to_today, 
                available_up_to_today, used_up_to_previous_month
   FROM    report_org
   WHERE (bu_name = 'CC')
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[org_used_time_off_limit_report_vw_CC] TO [Resourcing_data_read]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[org_used_time_off_limit_report_vw_CC] TO [data_mis_project_org_used_time_off_limit_report_vw_CC_read_all]
    AS [dbo];
GO

