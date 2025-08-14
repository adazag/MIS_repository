
CREATE view [data_mis_rls].[org_emp_position_history]
with schemabinding 
as 

with 
position_history as
(select 
		[id]
        ,[employee_id]
        ,[position_id]
        ,[start_date]
        ,[end_date]
from data_in.org_emp_position_history),

position_map as 
(select  [id]
		,[name]
        ,[active_ind]
        ,[order_number]
from data_in.org_emp_position),

employee_name as 
(select [id]
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
from data_in.org_emp),

full_data as
(select a.[id]
		,a.employee_id
		,CONCAT(c.first_name,' ',c.last_name) as employee_name
		,a.position_id
		,b.name as position_name
		,a.start_date
		,a.end_date
from position_history a
left join  position_map b on a.position_id=b.id
left join employee_name c on a.employee_id=c.id)


select  [id]
		,employee_id
		,employee_name
		,position_id
		,position_name
		,start_date
		,end_date

from full_data
GO

