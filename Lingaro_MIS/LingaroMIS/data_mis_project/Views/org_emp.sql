



/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [data_mis_project].[org_emp] as
(

SELECT a.id, a.ldap_login, a.last_name, a.first_name, CONCAT(a.last_name, ' ', a.first_name) AS employee_full_name, a.line_manager_id, CONCAT(b.last_name, ' ', b.first_name) AS line_manager_name, a.functional_manager_id, 
                  CONCAT(i.last_name, ' ', i.first_name) AS functional_manager_name, a.phone_number, a.email, a.maiden_name, a.gender_code, a.nationality_id, e.name AS nationality_name, a.country_id, f.name AS country_name, a.city_id, 
                  h.name AS city_name, a.country_work_location_id, g.name AS country_work_location_name, a.position_id, c.name AS position_name, a.seniority_id, d.name AS seniority_name, a.role, k.role_name, k.competency_name, a.active_ind, 
                  k.contract_termination_date, k.employment_date, k.contract_type, k.fte, a.leave_ind, a.work_experience AS exp_before_lingaro, CASE WHEN a.total_work_experience IS NULL 
                  THEN a.work_experience ELSE a.total_work_experience END AS total_work_experience, a.total_work_experience - a.work_experience AS exp_in_lingaro, a.management_community_member_ind, a.team_owner_ind, a.team_leader_ind, 
                  a.project_manager_ind, a.service_level_manager_ind, a.non_employee_ind, a.technical_account_ind, a.billable_ind, k.org_unit_name, k.team_name, k.delivery_team_name, k.senior_delivery_team_name, k.sub_bu_name, k.bu_name, 
                  a.photo_ind, a.pg_walmart_cda_valid_deprecated, a.pg_t_number_deprecated,a.pg_user_name_deprecated, a.disable_timesheet_generation, a.sponsor_email_deprecated, a.rhir_training_date_deprecated, a.rhir_training_status_id_deprecated, a.pg_pos_training_status_id_deprecated, a.pg_pos_training_expire_date_deprecated, 
                  a.auto_approval_time_off_ind, a.create_ip_ind, a.allow_photo_usage_ind, a.allow_fm_approve_timesheet_ind, a.allow_fm_approve_time_off, a.allow_fm_grant_overtime_perm, a.ad_object_id, a.allow_applying_ooo_ind, a.az_ad_object_id, 
                  a.allow_displaying_holidays_ind, a.created_by, a.modified_by, a.modified_at, a.creation_at, a.az_ad_account_enabled_ind, a.personal_leave_per_year, a.skills_reviewed_at, a.leaver_ind_modified_at, a.skills_reviewed_ind, 
                  a.leaver_notice_date, a.leaver_reason_id, j.name AS leaver_reason_name, a.long_term_leave_ind, a.long_term_leave_modified_at, a.long_term_leave_start_date, a.long_term_leave_end_date, a.leaver_last_day_of_work, a.managerial_requirements_profile_id,
				  a.new_hire_ind, k.external_ind, k.external_type, vendor_ind, shift_time
FROM     data_in.org_emp AS a LEFT OUTER JOIN
                  data_in.org_emp AS b ON a.line_manager_id = b.id LEFT OUTER JOIN
                  data_in.org_emp AS i ON a.functional_manager_id = i.id LEFT OUTER JOIN
                  data_in.org_emp_position AS c ON a.position_id = c.id LEFT OUTER JOIN
                  data_in.seniority AS d ON a.seniority_id = d.id LEFT OUTER JOIN
                  data_in.org_nationality AS e ON a.nationality_id = e.id LEFT OUTER JOIN
                  data_in.org_country AS f ON a.country_id = f.id LEFT OUTER JOIN
                  data_in.org_country AS g ON a.country_work_location_id = g.id LEFT OUTER JOIN
                  data_in.org_city AS h ON a.city_id = h.id LEFT OUTER JOIN
                  data_in.org_leaver_reason AS j ON a.leaver_reason_id = j.id LEFT OUTER JOIN
                  data_in.org_emp_vw AS k ON a.id = k.id )
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[org_emp] TO [Resourcing_data_read]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[org_emp] TO [data_mis_project_org_emp_read_all]
    AS [dbo];
GO

