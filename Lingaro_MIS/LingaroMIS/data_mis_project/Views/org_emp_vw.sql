
CREATE view [data_mis_project].[org_emp_vw]

as



WITH empee_info AS 
(
SELECT 
	vw.id,
    vw.ldap_login,
    vw.employee_full_name,
    vw.line_manager_id,
    vw.line_manager,
    vw.phone_number,
    vw.email,
    vw.position,
    vw.location,
    vw.pg_user_name_deprecated AS pg_user_name,
    vw.pg_t_number_deprecated  AS pg_t_number,
    vw.gender_code,
    vw.nationality,
    vw.role,
    vw.active_ind,
    vw.functional_manager_id,
    vw.functional_manager,
    vw.employment_date,
    vw.contract_termination_date,
    vw.contract_type,
    vw.approval_required,
    vw.legal_entity,
    vw.fte,
    vw.org_unit_id,
    vw.org_unit_name,
    vw.team_id,
    vw.team_name,
    vw.delivery_team_id,
    vw.delivery_team_name,
    vw.senior_delivery_team_id,
    vw.senior_delivery_team_name,
    vw.sub_bu_id,
    vw.sub_bu_name,
    vw.bu_id,
    vw.bu_name,
    vw.create_ip_ind,
    vw.gender,
    vw.photo_ind,
    vw.allow_photo_usage_ind,
    vw.primary_competency_name,
    vw.country,
    vw.city,
    vw.country_work_location,
    vw.city_id,
    vw.country_id,
    vw.ad_object_id,
    vw.az_ad_object_id,
    vw.az_ad_account_enabled_ind,
    vw.leave_ind,
    vw.country_work_location_id,
    vw.team_leader_ind,
    vw.team_owner_ind,
    vw.management_community_member_ind,
    vw.org_unit_area,
    vw.project_manager_ind,
    vw.service_level_manager_ind,
    vw.competency_name,
    vw.role_name,
    vw.seniority_id,
    vw.seniority_name,
    vw.technical_account_ind,
	emp.leaver_last_day_of_work,
    emp.work_experience        AS exp_before_lingaro,
    emp.competency_role_id,
    vw.external_ind,
    vw.external_type,
    vw.vendor_ind,
    vw.shift_time,
    emp.new_hire_ind
FROM data_in.org_emp_vw AS vw
LEFT OUTER JOIN data_in.org_emp AS emp ON vw.id = emp.id),

exp_curr AS 
(
SELECT employee_id,
           Sum(Datediff(month, Cast(start_date AS DATE), Cast(
                   CASE
                   WHEN start_date >= Getdate() THEN start_date
                   WHEN Isnull(end_date, Getdate()) <= Getdate() THEN Isnull(end_date, Getdate())
                   ELSE Getdate() END AS DATE)) ) AS exp_in_Lingaro
FROM   data_in.employee_contract
GROUP  BY employee_id)

SELECT a.id,
       a.ldap_login,
       a.employee_full_name,
       a.line_manager_id,
       a.line_manager,
       a.phone_number,
       a.email,
       a.position,
       a.location,
       a.pg_user_name,
       a.pg_t_number,
       a.gender_code,
       a.nationality,
       a.role,
       a.active_ind,
       a.functional_manager_id,
       a.functional_manager,
       a.employment_date,
       a.contract_termination_date,
       a.contract_type,
       a.approval_required,
       a.legal_entity,
       a.fte,
       a.org_unit_id,
       a.org_unit_name,
       a.team_id,
       a.team_name,
       a.delivery_team_id,
       a.delivery_team_name,
       a.senior_delivery_team_id,
       a.senior_delivery_team_name,
       a.sub_bu_id,
       a.sub_bu_name,
       a.bu_id,
       a.bu_name,
       a.create_ip_ind,
       a.gender,
       a.photo_ind,
       a.allow_photo_usage_ind,
       a.primary_competency_name,
       a.country,
       a.city,
       a.country_work_location,
       a.city_id,
       a.country_id,
       a.ad_object_id,
       a.az_ad_object_id,
       a.az_ad_account_enabled_ind,
       a.leave_ind,
       a.country_work_location_id,
       a.team_leader_ind,
       a.team_owner_ind,
       a.management_community_member_ind,
       a.org_unit_area,
       a.project_manager_ind,
       a.service_level_manager_ind,
       a.competency_name,
       a.role_name,
       a.seniority_id,
       a.seniority_name,
       a.technical_account_ind,
       a.exp_before_lingaro,
       b.exp_in_lingaro,
       Isnull(a.exp_before_lingaro, 0) + Isnull(b.exp_in_lingaro, 0)  AS total_exp_mth,
       Round(( Cast(Isnull(a.exp_before_lingaro, 0) AS FLOAT) + Cast(Isnull(b.exp_in_lingaro, 0) AS FLOAT) ) / 12, 2) AS total_exp_years,
       a.external_ind,
       a.external_type,
       a.vendor_ind,
       a.shift_time,
       a.new_hire_ind,
	   a.leaver_last_day_of_work
FROM   empee_info AS a
LEFT OUTER JOIN exp_curr AS b ON a.id = b.employee_id
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[org_emp_vw] TO [Resourcing_data_read]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[org_emp_vw] TO [data_mis_project_org_emp_vw_read_all]
    AS [dbo];
GO

