



CREATE view [data_mis].[org_emp_vw_active] as

--Czy logująca się osoba ma dany permission? (widoczność całej kolumny) ---->> EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_SENIORITY_READ' AND USER_NAME() = email) 
--Czy logująca się osoba jest team leaderem? (widoczność całej kolumny) ---->> EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_leader_ind = 1 AND email = USER_NAME())
--Czy logująca się osoba jest team ownerem? (widoczność całej kolumny) ---->> EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_owner_ind = 1 AND email = USER_NAME())
--Czy logująca się osoba mngmt community memberem? (widoczność całej kolumny) ---->> EXISTS (SELECT 1 FROM data_in.org_emp WHERE management_community_member_ind = 1 AND email = USER_NAME())
--Czy logująca się osoba jest przełożonym danego pracownika w tabeli? (widoczność tylko podwładnych na pierwszym poziomie) ---->> l.email = USER_NAME() 
--Czy logująca się osoba należy do hierarchii przełożonych danego pracownika w tabeli (widoczność podwładnych na wszystkich poziomach) ---->> CHARINDEX(USER_NAME(), eh.manager_chain) > 0  
--Czy logująca się osoba jest profile ownerem? (widoczność tylko swoich danych) ---->> USER_NAME() = a.email

WITH empee_info AS (
SELECT   vw.id
		,vw.ldap_login
		,vw.employee_full_name
		,vw.line_manager_id
		,vw.line_manager
		,vw.phone_number
		,vw.email
		,vw.position
		,vw.location
		,vw.pg_user_name_deprecated as pg_user_name
		,vw.pg_t_number_deprecated as pg_t_number
		,vw.gender_code
		,vw.nationality
		,vw.role
		,vw.active_ind
		,vw.functional_manager_id
		,vw.functional_manager
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_CONTRACTS_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 or USER_NAME() = vw.email THEN vw.[employment_date] else null end AS employment_date --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_CONTRACTS_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 or USER_NAME() = vw.email THEN vw.[contract_termination_date] else null end AS contract_termination_date --limited visibility
        ,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_CONTRACTS_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 or USER_NAME() = vw.email THEN vw.[contract_type] else null end AS contract_type --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_CONTRACTS_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 THEN vw.approval_required else null end as approval_required --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_CONTRACTS_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 THEN vw.legal_entity else null end as legal_entity --limited visibility
        ,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_CONTRACTS_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 or USER_NAME() = vw.email THEN vw.[fte] else null end AS fte --limited visibility
		,vw.org_unit_id
		,vw.org_unit_name
		, vw.team_id
		, vw.team_name
		, vw.delivery_team_id
		, vw.delivery_team_name
		, vw.senior_delivery_team_id
		, vw.senior_delivery_team_name
		, vw.sub_bu_id
		, vw.sub_bu_name
		, vw.bu_id
		, vw.bu_name
		,vw.create_ip_ind
		, vw.gender
		, vw.photo_ind
		, vw.allow_photo_usage_ind
		, vw.primary_competency_name
		, vw.country
		, vw.city
		, vw.country_work_location
		, vw.city_id
		, vw.country_id
		, vw.ad_object_id
		, vw.az_ad_object_id
		, vw.az_ad_account_enabled_ind
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_LEAVER_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 THEN vw.leave_ind else null end AS leave_ind --limited visibility
		, vw.country_work_location_id
		, vw.team_leader_ind
		, vw.team_owner_ind
		, vw.management_community_member_ind
		, vw.org_unit_area
		, vw.project_manager_ind
		, vw.service_level_manager_ind
		, vw.competency_name
		, vw.role_name
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_SENIORITY_READ' AND USER_NAME() = email) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_owner_ind = 1 AND email = USER_NAME()) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_leader_ind = 1 AND email = USER_NAME()) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE management_community_member_ind = 1 AND email = USER_NAME()) or IS_MEMBER('db_owner') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 THEN vw.seniority_id else null end as seniority_id --limited visibility
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_SENIORITY_READ' AND USER_NAME() = email) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_owner_ind = 1 AND email = USER_NAME()) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE team_leader_ind = 1 AND email = USER_NAME()) or EXISTS (SELECT 1 FROM data_in.org_emp WHERE management_community_member_ind = 1 AND email = USER_NAME()) or IS_MEMBER('db_owner') = 1 or CHARINDEX(USER_NAME(), eh.manager_chain) > 0 THEN vw.seniority_name else null end as seniority_name --limited visibility
		,vw.technical_account_ind 
		, emp.work_experience AS exp_before_lingaro
		, emp.competency_role_id
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_NEW_HIRE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 THEN emp.[new_hire_ind] else null end AS new_hire_ind --limited visibility
        ,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_EXTERNAL_TYPE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 THEN vw.[external_ind] else null end AS external_ind --limited visibility
        ,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_EXTERNAL_TYPE_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 THEN vw.[external_type] else null end AS external_type --limited visibility
        ,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_VIEW_VENDORS' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 THEN vw.vendor_ind else null end AS vendor_ind --limited visibility
        ,vw. shift_time
		,CASE WHEN EXISTS (SELECT 1 FROM data_mis_project.sec_emp_all_permission  WHERE permission_name = 'PERM_EMPLOYEE_IS_DRAFT_READ' AND USER_NAME() = email) or IS_MEMBER('db_owner') = 1 THEN vw.draft_profile_ind else null end AS draft_profile_ind --limited visibility
        FROM data_in.org_emp_vw AS vw 
		LEFT OUTER JOIN data_in.org_emp AS emp ON vw.id = emp.id
		LEFT OUTER JOIN data_in.org_emp_vw AS l ON vw.line_manager_id = l.id
		LEFT OUTER JOIN data_mis_project.employee_hierarchy AS eh ON vw.id = eh.employee_id -- tabela do sprawdzenia permissionu LM+
),

exp_curr AS
    (SELECT employee_id
	, SUM(DATEDIFF(month, CAST(start_date AS date), CAST(CASE WHEN start_date >= GETDATE() THEN start_date 
	WHEN isnull(end_date, GETDATE()) <= GETDATE() THEN isnull(end_date, GETDATE()) ELSE GETDATE() 
                       END AS date))) AS exp_in_Lingaro
FROM      data_in.employee_contract
GROUP BY employee_id
)
    
	
	
SELECT a.id, a.ldap_login, a.employee_full_name, a.line_manager_id, a.line_manager, a.phone_number, a.email, a.position, a.location, a.pg_user_name, a.pg_t_number, a.gender_code, a.nationality, a.role, a.active_ind, a.functional_manager_id, 
                      a.functional_manager, a.employment_date, a.contract_termination_date, a.contract_type, a.approval_required, a.legal_entity, a.fte, a.org_unit_id, a.org_unit_name, a.team_id, a.team_name, a.delivery_team_id, a.delivery_team_name, 
                      a.senior_delivery_team_id, a.senior_delivery_team_name, a.sub_bu_id, a.sub_bu_name, a.bu_id, a.bu_name, a.create_ip_ind, a.gender, a.photo_ind, a.allow_photo_usage_ind, a.primary_competency_name, a.country, a.city, 
                      a.country_work_location, a.city_id, a.country_id, a.ad_object_id, a.az_ad_object_id, a.az_ad_account_enabled_ind, a.leave_ind, a.country_work_location_id, a.team_leader_ind, a.team_owner_ind, 
                      a.management_community_member_ind, a.org_unit_area, a.project_manager_ind, a.service_level_manager_ind, a.competency_name, a.role_name, a.seniority_id, a.seniority_name, a.technical_account_ind, a.exp_before_lingaro, 
                      b.exp_in_Lingaro, ISNULL(a.exp_before_lingaro, 0) + ISNULL(b.exp_in_Lingaro, 0) AS total_exp_mth, ROUND((CAST(ISNULL(a.exp_before_lingaro, 0) AS float) + CAST(ISNULL(b.exp_in_Lingaro, 0) AS float)) / 12, 2) 
                      AS total_exp_years,a.new_hire_ind, a.external_ind, a.external_type, a.vendor_ind, a.shift_time, a. draft_profile_ind
FROM     empee_info AS a 
LEFT OUTER JOIN exp_curr AS b ON a.id = b.employee_id
where active_ind = 1
GO

