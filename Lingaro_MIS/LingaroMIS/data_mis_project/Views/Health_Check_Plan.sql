
CREATE view [data_mis_project].[Health_Check_Plan] as
WITH 
--------
   
-------------------------------
/*Employee list*/
-------------------------------
EMPEE as (
  SELECT id as [EMPEE_ID]
      ,employee_full_name
  FROM data_in.org_emp_vw),

-------------------------------
/*Project lkp list*/
-------------------------------
PROJ_LKP as (
SELECT [project_id]
      ,[project_name]
      ,[code]
      ,[parent_project_id]
      ,[parent_project_name]
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
      ,[BUSINESS_UNIT_NAME]
      ,[SUB_BUSINESS_UNIT_NAME]
      ,[DELIVERY_TEAM_NAME]
      ,[TEAM_NAME]
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
	  ,parent_financial_project_name
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
	  ,is_health_check_required
FROM data_mis.proj),
	

-------------------------------
/*Client contact*/
-------------------------------
CLEN_CNTCT as (
	SELECT id [CLEN_CNTCT_ID]
      ,[FIRST_NAME]
      ,[LAST_NAME]
      ,client_id [CLEN_ID]
      ,email_text [EMAIL_TXT]
      ,active_ind [ACTV_IND]
	FROM  [data_in].[proj_client_contact])



  SELECT 
  a.project_id as PROJ_ID
 ,a.project_name as PROJ_NAME
 ,a.start_date as PROJ_START_DATE
 ,a.end_date as PROJ_END_DATE
 ,a.proj_manager_name as PROJ_MGR_NAME
 ,null as CLEN_CNTCT_NAME
 ,a.client_name as CLEN_NAME
 ,a.parent_project_ind as PARNT_PROJ_IND
 ,e.project_name as PARNT_PROJ_NAME
 ,c.status_code as PROJ_STTUS_CODE
 ,os.organization_id as [BU_ID]
 ,os.organization_name as [BU_NAME]
 ,os.department_id as [SUB_BU_ID]
 ,os.department_name as [SUB_BU_NAME]
 ,os.division_id as [SENIOR_DELIVERY_TEAM_ID]
 ,os.division_name as [SENIOR_DELIVERY_TEAM_NAME]
 ,os.sub_division_id as [DELIVERY_TEAM_ID]
 ,os.sub_division_name as [DELIVERY_TEAM_NAME]
 ,os.team_id as [TEAM_ID]
 ,os.team_name as [TEAM_NAME]
 ,a.engagement_type_name as PROJ_ENGAG_NAME
 ,a.management_tool_name PROJ_MGMT_TOOL_NAME
 ,a.project_billable_ind as PROJ_BLLBL_IND
 ,null as EMAIL_TXT
 ,null as ACTV_IND
 ,a.organization_unit_name as ORG_UNIT_NAME
 ,'' as SECTION
 ,'https://sulu.lingarogroup.com/engagement/' +
                    cast(a.project_id as varchar(255))        +'/details'                             as 'SULU_PROJ_LINK'
 ,a.code as PROJ_CODE
 ,cast(a.change_date as date) as CHNG_DATE
 ,a.parent_financial_project_name as [PARENT_FIN_PROJ_NAME]
 ,CASE WHEN a.is_health_check_required is null then 1 else a.is_health_check_required end as IS_HEALTH_CHECK_REQUIRED
 FROM PROJ_LKP a 
 left join EMPEE b on a.proj_manager_id=b.EMPEE_ID
 left join PROJ_LKP c on a.project_id=c.project_id
-- left join CLEN_CNTCT d on c.CLEN_CNTCT_ID=d.CLEN_CNTCT_ID
 left join PROJ_LKP e on a.parent_financial_project_id=e.project_id
 left join data_mis.org_structure_new os on a.organization_unit_id = os.org_unit_id
 --WHERE A.project_id=8293
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[Health_Check_Plan] TO [data_mis_project_Health_Check_Plan_read_all]
    AS [dbo];
GO

