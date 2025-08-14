








CREATE view [data_mis].[org_emp] as 
--Czy logująca się osoba ma dany permission? (widoczność całej kolumny) ---->> EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_SENIORITY_READ' AND USER_NAME() = email) 
--Czy logująca się osoba jest team leaderem? (widoczność całej kolumny) ---->> EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_leader_ind = 1 AND email = USER_NAME())
--Czy logująca się osoba jest team ownerem? (widoczność całej kolumny) ---->> EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_owner_ind = 1 AND email = USER_NAME())
--Czy logująca się osoba mngmt community memberem? (widoczność całej kolumny) ---->> EXISTS (SELECT 1 FROM data_in.org_emp WHERE management_community_member_ind = 1 AND email = USER_NAME())
--Czy logująca się osoba jest przełożonym danego pracownika w tabeli? (widoczność tylko podwładnych na pierwszym poziomie) ---->> l.email = USER_NAME() 
--Czy logująca się osoba należy do hierarchii przełożonych danego pracownika w tabeli (widoczność podwładnych na wszystkich poziomach) ---->> CHARINDEX(USER_NAME(), eh.manager_chain) > 0  
--Czy logująca się osoba jest profile ownerem? (widoczność tylko swoich danych) ---->> USER_NAME() = a.email

  SELECT  a.id --visible for everyone
  		--,CASE WHEN CHARINDEX(USER_NAME(), eh.manager_chain) > 0 THEN 1 ELSE 0 END as is_lm+_check
		--,CASE WHEN USER_NAME() = a.email THEN 1 ELSE 0 END as is_profile_owner_check
		--,CASE WHEN EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_owner_ind = 1 AND email = USER_NAME()) THEN 1 ELSE 0 END as team_owner_check
		, a.ldap_login --visible for everyone
		, a.last_name --visible for everyone
		, a.first_name --visible for everyone
		, CONCAT(a.last_name, ' ', a.first_name) AS employee_full_name --visible for everyone
		, k.line_manager_id --visible for everyone
		, k.line_manager  --visible for everyone
		, l.email as line_manager_email
		, k.functional_manager_id --visible for everyone
		, k.functional_manager --visible for everyone
		, a.phone_number  --visible for everyone
		, a.email --visible for everyone
		, maiden_name  --visible for everyone
		, a.gender_code --visible for everyone
		, a.nationality_id --visible for everyone
		, e.name AS nationality_name --visible for everyone
		, k.country_id --visible for everyone
		, f.name AS country_name --visible for everyone
		, k.city_id --visible for everyone
		, h.name AS city_name --visible for everyone
		, k.country_work_location_id --visible for everyone
		, g.name AS country_work_location_name --visible for everyone
		, k.position_id --visible for everyone
		, k.position AS position_name --visible for everyone
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_SENIORITY_READ' AND USER_NAME() = email) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_owner_ind = 1 AND email = USER_NAME()) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_leader_ind = 1 AND email = USER_NAME()) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE management_community_member_ind = 1 AND email = USER_NAME()) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 THEN k.seniority_id else null end AS seniority_id --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_SENIORITY_READ' AND USER_NAME() = email) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_owner_ind = 1 AND email = USER_NAME()) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_leader_ind = 1 AND email = USER_NAME()) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE management_community_member_ind = 1 AND email = USER_NAME()) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0  THEN d.name else null end AS seniority_name --limited visibility
		, k.role  --visible for everyone
		, k.role_name --visible for everyone
		, k.competency_name --visible for everyone
		,a.active_ind --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_CONTRACTS_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 or USER_NAME() = a.email THEN k.[contract_termination_date] else null end AS contract_termination_date --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_CONTRACTS_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 or USER_NAME() = a.email THEN k.[employment_date] else null end AS employment_date --limited visibility
        ,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_CONTRACTS_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 or USER_NAME() = a.email THEN k.[contract_type] else null end AS contract_type --limited visibility
        ,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_CONTRACTS_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 or USER_NAME() = a.email THEN k.[fte] else null end AS fte --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_LEAVER_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 THEN a.leave_ind else null end AS leave_ind --limited visibility
		, a.work_experience AS exp_before_lingaro --visible for everyone
		, a.total_work_experience --visible for everyone
		, a.total_work_experience - a.work_experience AS exp_in_lingaro --visible for everyone
		, a.management_community_member_ind --visible for everyone
		, a.team_owner_ind --visible for everyone
		, a.team_leader_ind --visible for everyone
		, a.project_manager_ind--visible for everyone
		, a.service_level_manager_ind--visible for everyone
		,a.key_talent_program_alumnus_ind --visible for everyone
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_NON_EMPLOYEE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 THEN a.non_employee_ind else null end AS non_employee_ind --limited visibility
		,a.technical_account_ind --visible for everyone
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_BILLABLE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0   THEN a.billable_ind ELSE null END AS billable_ind --limited visibility
		, k.org_unit_id --visible for everyone
		, k.org_unit_name--visible for everyone
		, k.team_name--visible for everyone
		, k.delivery_team_name--visible for everyone
		, k.senior_delivery_team_name--visible for everyone
		, k.sub_bu_name--visible for everyone
		, k.bu_name--visible for everyone
		, a.photo_ind --visible for everyone
		--, a.pg_walmart_cda_valid_deprecated as pg_walmart_cda_valid --visible for everyone
		--, a.pg_t_number_deprecated as pg_t_number--visible for everyone
		--, a.pg_user_name_deprecated as pg_user_name--visible for everyone
		--, a.disable_timesheet_generation --visible for everyone
		--, a.sponsor_email_deprecated as sponsor_email--visible for everyone
		--, a.rhir_training_date_deprecated as rhir_training_date--visible for everyone
		--, a.rhir_training_status_id_deprecated as rhir_training_status_id--visible for everyone
		--, a.pg_pos_training_status_id_deprecated as pg_pos_training_status_id--visible for everyone
		--, a.pg_pos_training_expire_date_deprecated as pg_pos_training_expire_date--visible for everyone
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_AUTO_APPROVAL_TIMEOFF_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1  THEN a.auto_approval_time_off_ind else null end AS auto_approval_time_off_ind --limited visibility
		,a.create_ip_ind --visible for everyone
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_ALLOWED_PHOTO_USAGE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1  THEN a.allow_photo_usage_ind else null end AS allow_photo_usage_ind --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_ALLOWED_FM_APPROVE_TS_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1  THEN a.allow_fm_approve_timesheet_ind else null end AS allow_fm_approve_timesheet_ind --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_ALLOWED_FM_APPROVE_TIME_OFF_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 THEN a.allow_fm_approve_time_off else null end AS allow_fm_approve_time_off --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_ALLOWED_FM_GRANT_OVERTIME_PERM_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1or IS_MEMBER('db_bial_y') = 1  THEN a.allow_fm_grant_overtime_perm else null end AS allow_fm_grant_overtime_perm --limited visibility
		, a.ad_object_id --visible for everyone
		, a.allow_applying_ooo_ind--visible for everyone
		, a.az_ad_object_id--visible for everyone
		, a.allow_displaying_holidays_ind --visible for everyone
		, a.created_by--visible for everyone
		, a.modified_by--visible for everyone
		, a.modified_at--visible for everyone
		, a.creation_at--visible for everyone
		, a.az_ad_account_enabled_ind --visible for everyone
		, a.personal_leave_per_year--visible for everyone
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_LEAVER_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1  or CHARINDEX(USER_NAME(), eh.manager_chain) > 0  THEN a.leaver_ind_modified_at  else null end AS leaver_ind_modified_at --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_ARE_SKILLS_REVIEWED_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1  or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 THEN a.skills_reviewed_ind else null end AS skills_reviewed_ind --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_ARE_SKILLS_REVIEWED_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 THEN a.skills_reviewed_at else null end AS skills_reviewed_at --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_LEAVER_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0  THEN leaver_notice_date  else null end AS leaver_notice_date --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_LEAVER_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0  THEN leaver_reason_id  else null end AS leaver_reason_id --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_LEAVER_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1  or l.email = USER_NAME() THEN j.name else null end AS leaver_reason_name --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_LONG_TERM_LEAVE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0  THEN a.long_term_leave_ind else null end AS long_term_leave_ind --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_LONG_TERM_LEAVE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or l.email = USER_NAME() THEN a.long_term_leave_modified_at else null end AS long_term_leave_modified_at --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_LONG_TERM_LEAVE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0  THEN a.long_term_leave_start_date else null end AS long_term_leave_start_date --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_LONG_TERM_LEAVE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0  THEN a.long_term_leave_end_date else null end AS long_term_leave_end_date --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_LEAVER_LAST_DAY_OF_WORK_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0  THEN a.leaver_last_day_of_work else null end AS leaver_last_day_of_work --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'MANAGERIAL_REQUIREMENTS_PROFILE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 THEN a.managerial_requirements_profile_id else null end AS managerial_requirements_profile_id --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_NEW_HIRE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 THEN a.[new_hire_ind] else null end AS new_hire_ind --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_EXTERNAL_TYPE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 THEN a.[external_ind] else null end AS external_ind --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_EXTERNAL_TYPE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 THEN a.external_type_id else null end AS external_type_id --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_EXTERNAL_TYPE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 THEN k.external_type else null end AS external_type --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_VIEW_VENDORS' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or IS_MEMBER('db_bial_y') = 1 THEN k.vendor_ind else null end AS vendor_ind --limited visibility
		, k.shift_time --visible for everyone
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_DRAFT_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 THEN a.draft_profile_ind else null end AS draft_profile_ind --limited visibility
		,a.first_day_of_work
		--,USER_NAME() as logged_user
FROM     data_in.org_emp AS a 
LEFT OUTER JOIN data_in.org_leaver_reason AS j ON a.leaver_reason_id = j.id 
LEFT OUTER JOIN data_in.org_emp_vw AS k ON a.id = k.id
LEFT OUTER JOIN data_in.org_emp_vw AS l ON k.line_manager_id = l.id
LEFT OUTER JOIN data_in.org_emp_position AS c ON k.position_id = c.id 
LEFT OUTER JOIN data_in.seniority AS d ON k.seniority_id = d.id 
LEFT OUTER JOIN data_in.org_nationality AS e ON a.nationality_id = e.id 
LEFT OUTER JOIN data_in.org_country AS f ON k.country_id = f.id 
LEFT OUTER JOIN data_in.org_country AS g ON k.country_work_location_id = g.id 
LEFT OUTER JOIN data_in.org_city AS h ON k.city_id = h.id 
LEFT OUTER JOIN data_mis_project.employee_hierarchy AS eh ON a.id = eh.employee_id -- tabela do sprawdzenia permissionu LM+

--where a.active_ind = 1 or a.draft_profile_ind=1 or new_hire_ind=1
GO

