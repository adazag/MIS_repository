/****** Object:  StoredProcedure [data_mis_rls].[update_empee_cntrt_leaver]    Script Date: 02.11.2023 13:41:09 ******/
CREATE VIEW [data_mis_project].[empee_cntrt_leaver] as

with

/*EMPLOYEE_CONTRACT_LIST_ALL*/
---------------------------------
EMP_CONTRACT as (
SELECT employee_id [EMPEE_ID]
      ,start_date [CNTRT_START_DATE]
      ,end_date [CNTRT_END_DATE]
      ,contract_type_id [CNTRT_TYPE_ID]
      ,legal_entity_id [LE_ID]
FROM data_in.employee_contract
where end_date >= cast(GETDATE() as date) or end_date is null 
),


/*LEAVER_FLAG*/
---------------------------
LEAVER_FLAG as ( 
SELECT [id] as ID
      ,[leave_ind] as LEAVE_IND
	  ,CONCAT(first_name,' ', last_name) as EMPLOYEE_FULL_NAME
      /*,[ldap_login]
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
      ,[pg_walmart_cda_valid]
      ,[pg_t_number]
      ,[pg_user_name]
      ,[gender_code]
      ,[nationality_id]
      ,[maiden_name]
      ,[disable_timesheet_generation]
      ,[sponsor_email]
      ,[rhir_training_date]
      ,[rhir_training_status_id]
      ,[pg_pos_training_status_id]
      ,[role]
      ,[pg_pos_training_expire_date]
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
      ,[skills_reviewed_at]*/
  FROM [data_in].[org_emp]
 ),

 /*EMPLOYEE_CONTRACT_LIST + LEAVER FLAG*/
-----------------------------------------------
EMP_CONTRACT_LEAVER_FLAG as (
SELECT [EMPEE_ID]
	  ,EMPLOYEE_FULL_NAME
      ,[CNTRT_START_DATE]
      ,[CNTRT_END_DATE]
      ,[CNTRT_TYPE_ID]
      ,[LE_ID]
	  ,LEAVE_IND
FROM EMP_CONTRACT a
LEFT JOIN LEAVER_FLAG b on a.EMPEE_ID=b.id
),

/*COMBINE ALL TABLES ABOVE*/
-------------------------------------------------------
TOTAL as (
SELECT  [EMPEE_ID] as EMPLOYEE_ID
	   ,EMPLOYEE_FULL_NAME
       ,[CNTRT_START_DATE] as CONTRACT_START_DATE
       ,[CNTRT_END_DATE] as CONTRACT_END_DATE
       ,[CNTRT_TYPE_ID] as CONTRACT_TYPE
       ,[LE_ID] as LEGAL_ENTITY_ID
	   ,LEAVE_IND
FROM EMP_CONTRACT_LEAVER_FLAG 
)

SELECT * from TOTAL
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[empee_cntrt_leaver] TO [michal.jablonski3@lingarogroup.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[empee_cntrt_leaver] TO [data_mis_project_empee_cntrt_leaver_read_all]
    AS [dbo];
GO

