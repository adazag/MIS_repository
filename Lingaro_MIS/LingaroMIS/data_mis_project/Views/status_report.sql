


CREATE view [data_mis_project].[status_report] as


WITH
all_status as (
 
SELECT
 
s.project_id as 'ID'
,s.project_priority as 'Priority'
,s.project_name as 'Engagement'
,s.engagement_type_name as 'Engagement Type'
,s.start_date as 'Start date'
,s.end_date as 'End date'
,s.first_start_date as 'Original start date'
,s.first_end_date as 'Original end date'
,s.proj_manager_id 
,s.proj_manager_name as 'Project Manager'
,psr.status_day_date as 'SR Date'
,psr.overall_health_status as 'Overalhealth status'
,psr.cost_status as 'Cost status'
,psr.time_status as 'Time status'
,psr.scope_status as 'Scope status'
,psr.resource_status as 'Resource Status'
,pv.security_ind as 'Security flag'
,s.is_status_required as 'Is SR required?'
,s.client_name as 'Client Name'
,s.parent_financial_project_name as 'Parent Project'
--,s.parent_project_ind as 'Is Project Parent'
,CASE 
    WHEN EXISTS (
        SELECT 1 
        FROM data_mis.proj AS p2 
        WHERE p2.parent_financial_project_id = s.project_id
    ) THEN 1
    ELSE 0
 END AS 'Is Project Parent'
,s.project_scale as 'Project Scale'
,s.project_risk as 'Project Risk'
,s.business_criticality as 'Business Importance'
,s.parent_project_name as 'Engagement Group'
,s.business_unit_name as 'Business Unit'
,s.sub_business_unit_name as 'Sub Business Unit'
,s.senior_delivery_team_name as 'Senior Delivery Team'
,s.delivery_team_name  as 'Delivery Team'
,s.team_name as 'Team'
,s.status_code as 'Status Code'
,psr.full_link as 'Full link'
,psr.help_needed as 'Help needed (text)'
,psr.help_needed_lingaro as 'Help needed (text) Lingaro'
,p.share_point_auto_link as 'Documents repository'
,e.first_name +' '+ e.last_name as 'Last modified by'
,psr.executive_summary as 'Executive summary (trimmed)'
,s.engagement_type_id as 'Engagement Type ID'
,pv.project_group_ind as 'Is Engagement Group?'
,s.change_date as 'Status Code Change date'
,s.is_health_check_required as 'Is health check required'
,psr.creation_at as 'Creation Date'
,p.created_by as 'Creation By'
,s.agile_score as 'agile_maturity'
,s.engagement_manager_id
,emp.employee_full_name as engagement_manager_name
,s.repo_project_id

  FROM
   data_mis.proj as s
  --left join data_mis.proj as s2 on s.parent_project_id = s2.project_id
  left join  data_in.proj_vw pv on s.project_id = pv.project_id
  left join data_in.proj p on s.project_id = p.project_id
  left join [data_in].[org_emp] as e on s.change_by = e.id
  left join data_in.proj_status_report as psr on s.project_id = psr.project_id
  left join [data_in].[org_emp_vw] as emp on s.engagement_manager_id = emp.id
  ),
 
  SCRTY_LDR_ID as (
  SELECT emp_id.project_id, emp_id.security_leader_id, emp_name.first_name as s_name, emp_name.last_name as s_surname
  FROM data_mis.proj as emp_id
  INNER JOIN [data_in].[org_emp] as emp_name
  on emp_id.security_leader_id = emp_name.id
  ),
 
  TECH_LDR_ID as (
  SELECT emp_id.project_id, emp_id.technical_leader_id, emp_name.first_name as t_name, emp_name.last_name as t_surname
  FROM data_mis.proj as emp_id
  INNER JOIN [data_in].[org_emp] as emp_name
  on emp_id.technical_leader_id = emp_name.id
  ),
 
  DLV_LDR_ID as (
  SELECT DISTINCT dlv_id.sub_division_id, dlv_id.sub_division_name ,dlv_id.sub_division_leader_id, CONCAT(emp_name.first_name, ' ', emp_name.last_name) as dlv_lead_name
  FROM data_mis.org_structure_new as dlv_id
  INNER JOIN  [data_in].[org_emp] as emp_name
  on dlv_id.sub_division_leader_id = emp_name.id
  ),
 
  Senior_DLV_LDR_ID as (
  SELECT DISTINCT dlv_id.division_id, dlv_id.division_name ,dlv_id.division_leader_id, CONCAT(emp_name.first_name, ' ', emp_name.last_name) as senior_dlv_lead_name
  FROM data_mis.org_structure_new as dlv_id
  INNER JOIN [data_in].[org_emp] as emp_name
  on dlv_id.division_leader_id = emp_name.id
  ),
 
  SUB_BU_LDR_ID as (
  SELECT DISTINCT dlv_id.department_id, dlv_id.department_name, dlv_id.department_leader_id, CONCAT(emp_name.first_name, ' ', emp_name.last_name) as sub_lead_name
  FROM data_mis.org_structure_new as dlv_id
  INNER JOIN [data_in].[org_emp] as emp_name
  on dlv_id.department_leader_id = emp_name.id
  ),
 
  BU_LDR_ID as (
  SELECT DISTINCT dlv_id.organization_id, dlv_id.organization_name, dlv_id.organization_leader_id, CONCAT(emp_name.first_name, ' ', emp_name.last_name) as bu_lead_name
  FROM data_mis.org_structure_new as dlv_id
  INNER JOIN [data_in].[org_emp] as emp_name
  on dlv_id.organization_leader_id = emp_name.id
  ),
 
  first_confirmed as (
  SELECT project_id PROJ_ID, status PROJ_STTUS_CODE, min(change_time_stamp) as First_entry_in_Confirmed_status
  FROM data_in.proj_project_status_history as prc
  where status = 'CONFIRMED'
  group by project_id, status),
 
  last_closed as (
  SELECT project_id  PROJ_ID,status PROJ_STTUS_CODE, max(change_time_stamp) as Last_entry_in_Closed_status
  FROM data_in.proj_project_status_history as prc
  where status = 'CLOSED'
  group by project_id, status),
 

final as (
SELECT
ID
,Priority
,Engagement
,[Engagement Type]
,[Start date]
,[End date]
,[Original start date]
,[Original end date]
,proj_manager_id
,[Project Manager]
,[SR Date]
,[Overalhealth status]
,[Cost status]
,[Time status]
,[Scope status]
,[Resource Status]
,[Security flag]
,[Is SR required?]
,[Client Name]
,[Parent Project]
,[Is Project Parent]
,[Project Scale]
,[Project Risk]
,[Business Importance]
,[Engagement Group]
,[Business Unit]
,[Sub Business Unit]
,[Senior Delivery Team]
,[Delivery Team]
,[Team]
,[Status Code]
,[Full link]
,[Help needed (text)]
,[Help needed (text) Lingaro]
,[Last modified by]
,[Executive summary (trimmed)]
,[Engagement Type ID]
,[Is Engagement Group?]
,[Status Code Change date]
,[Is health check required]
,security_leader_id as Security_Lead
,CONCAT(s_name, ' ' ,s_surname) as security_leader_name  
,technical_leader_id as Technical_Lead
,CONCAT(t_name,' ',t_surname) as Technical_Lead_name
,CASE
	  WHEN dl.dlv_lead_name IS NOT NULL THEN dl.dlv_lead_name
      WHEN senior_dlv_lead_name is not null then senior_dlv_lead_name
	  WHEN sub_lead_name is not NULL then sub_lead_name
	  ELSE bu.bu_lead_name
   END as Delivery_Lead
,s.First_entry_in_Confirmed_status
,t.Last_entry_in_Closed_status
,agile_maturity
,[Creation Date]
,[Creation By]
,[Documents repository]
,engagement_manager_id
,engagement_manager_name
,repo_project_id
 FROM all_status as f
  left join first_confirmed as s
  on f.[ID] = s.PROJ_ID
  left join last_closed as t
  on f.[ID] = t.PROJ_ID
  left join SCRTY_LDR_ID as l
  on f.[ID] = l.project_id
  left join TECH_LDR_ID as tl
  on f.[ID] = tl.project_id
  left join DLV_LDR_ID as dl
  on f.[Delivery Team] = dl.sub_division_name
  left join Senior_DLV_LDR_ID as sdl
  on f.[Senior Delivery Team] = sdl.division_name
  left join SUB_BU_LDR_ID as sbu
  on f.[Sub Business Unit] = sbu.department_name
  left join BU_LDR_ID as bu
  on f.[Business Unit] = bu.organization_name
 )

 select * from final
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[status_report] TO [data_mis_project_status_report_read_all]
    AS [dbo];
GO

