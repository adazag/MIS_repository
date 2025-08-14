CREATE PROCEDURE [data_mis_project].[update_contract_mapping_historical_position] as

IF OBJECT_ID('data_mis_project.contract_mapping_historical_position', 'U') IS NOT NULL TRUNCATE TABLE data_mis_project.contract_mapping_historical_position;

/****** Script for SelectTopNRows command from SSMS  ******/



WITH 

--------------------------------------------------------------
/* CONTRACT DATA*/
--------------------------------------------------------------
CONTRACT_LIST as (
SELECT 1 as ID
	  ,employee_id as [EMPEE_ID]
      ,cast(start_date as date) as [CNTRT_START_DATE]
      ,case when end_date is null then '9999-01-01' /* cast(getdate() as date)*/ else cast(end_date as date) end as [CNTRT_END_DATE]
      ,contract_type_id [CNTRT_TYPE_ID]
      ,legal_entity_id as [LE_ID]
	FROM data_in.employee_contract
  ),
 
CONTRACT_RANGE_DATE as (
SELECT min(cast(start_date as date)) as [MIN_MONTH_DATE]
      ,cast(getdate() as date) as MAX_MONTH_DATE
	FROM data_in.employee_contract
  ),


FIRST_LAST_CONTRACT_EMPEE_DATE as (
SELECT EMPEE_ID
	  ,min(cast([CNTRT_START_DATE] as date)) as [FIRST_CONTRACT_START_DATE]
      ,case when max(CNTRT_END_DATE) is null then '9999-01-01'  /*cast(eomonth(getdate()) as date)*/ else max(cast([CNTRT_END_DATE] as date)) end as  LAST_CONTRACT_END_DATE
	FROM CONTRACT_LIST
	GROUP BY EMPEE_ID
  ),


CONTRACT_TYPE as (
SELECT id as [CNTRT_TYPE_ID]
      ,code as [CNTRT_TYPE_CODE]
      ,name as [CNTRT_TYPE_NAME]
	FROM data_in.org_contract_type
  ),

--------------------------------------------------------------
/*ORG UNIT */
--------------------------------------------------------------
ORG_UNIT as(
  SELECT [id]
      ,[employee_id]
      ,[organization_unit_id]
      ,[start_date]
      ,case when end_date is null then '9999-01-01' else [end_date] end as end_date
  FROM [data_in].[org_emp_org_unit]
  ),

 ORG_UNIT_MAP as(
SELECT org_unit_id [ORG_ID]
      ,org_unit_name AS [ORG_NAME]
      ,[LEADER_ID]
      ,TEAM_ID AS [T_ID]
      ,TEAM_NAME AS [T_NAME]
      ,sub_division_id AS [DT_ID]
      ,sub_division_name AS [DT_NAME]
      ,division_id AS [SDT_ID]
      ,division_name AS [SDT_NAME]
      ,department_id AS [SBU_ID]
      ,department_name AS [SBU_NAME]
      ,organization_id AS [BU_ID]
      ,organization_name AS [BU_NAME]
  FROM [data_mis].[org_structure_new]
  ),

 ORG_UNIT_MAP_HIST as(  
	SELECT 
	   id [ORG_UNIT_ID]
      ,name [ORG_UNIT_NAME]
      ,parent_id [PARNT_ORG_UNIT_ID]
      ,unit_level [ORG_UNIT_LVL]
      ,type [ORG_UNIT_TYPE]
      ,leader_id [ORG_UNIT_LEADER_ID]
      ,[TEAM_ID]
      ,[TEAM_NAME]
      ,[PARNT_TEAM_ID]
      ,[TEAM_LVL]
      ,[TEAM_TYPE]
      ,[TEAM_LEADER_ID]
      ,[DELIVERY_TEAM_ID]
      ,[DELIVERY_TEAM_NAME]
      ,[PARNT_DELIVERY_TEAM_ID]
      ,[DELIVERY_TEAM_LVL]
      ,[DELIVERY_TEAM_TYPE]
      ,[DELIVERY_TEAM_LEADER_ID]
      ,[SENIOR_DELIVERY_TEAM_ID]
      ,[SENIOR_DELIVERY_TEAM_NAME]
      ,[PARNT_SENIOR_DELIVERY_TEAM_ID]
      ,[SENIOR_DELIVERY_TEAM_LVL]
      ,[SENIOR_DELIVERY_TEAM_TYPE]
      ,[SENIOR_DELIVERY_TEAM_LEADER_ID]
      ,[SUB_BU_ID]
      ,[SUB_BU_NAME]
      ,sub_parnt_bu_id [PARNT_SUB_BU_ID]
      ,[SUB_BU_LVL]
      ,[SUB_BU_TYPE]
      ,[SUB_BU_LEADER_ID]
      ,[BU_ID]
      ,[BU_NAME]
      ,[PARNT_BU_ID]
      ,[BU_LVL]
      ,[BU_TYPE]
      ,[BU_LEADER_ID]
  FROM  [data_in].[org_unit_flatten]
  ),

--------------------------------------------------------------
/*PRIMARY PROFILE*/
--------------------------------------------------------------

PRIMARY_PROFILE as(
  SELECT a.id [EMPEE_ID]
      ,a.primary_competency_id [EMPEE_PROFL_ID]
	  ,b.name EMPEE_PROFL_NAME	
  FROM data_in.org_emp a
  left join [data_in].[org_competency] b on a.primary_competency_id=b.id),


--------------------------------------------------------------
/*LEGAL ENTITY*/
--------------------------------------------------------------
LEGAL_ENTITY AS(
  SELECT id as [LE_ID]
      ,name as [LE_NAME]
  FROM data_in.org_legal_entity
  ),

--------------------------------------------------------------
/*DATE RANGE*/
--------------------------------------------------------------
YYYY_LIST as (
SELECT  1 as ID
        ,cast('2008/07/01' as date)  as YYYY_START
        union all
        select  
		1 as ID
		,DATEADD(day,1,YYYY_START)
        from    YYYY_LIST
        where   YYYY_START < cast(GETDATE() as date)
		),

MM_LIST as (
SELECT  1 as ID
       ,datepart(MONTH, '2008-01-01') AS MM_START
	   ,0 as LEADING_0
        UNION ALL
        SELECT  
		1 as ID
	   ,MM_START + 1
	   ,0 as LEADING_0
FROM    MM_LIST
WHERE   MM_START < 12
		),

MONTH_TABLE AS (
SELECT concat(YYYY_START,'-',right(concat(LEADING_0,MM_START),2)) as 'YYYY_MM'
,'2008-07' as FIRST_MONTH
,format(getdate(),'yyyy-MM') as LAST_MONTH
FROM MM_LIST a
left join YYYY_LIST b on a.ID=b.ID
),

--------------------------------------------------------------
/*EMPLOYEE LIST*/
--------------------------------------------------------------
EMPLOYEE_VW as(
SELECT 1 as id_key 
,[id]
      ,[ldap_login]
      ,[employee_full_name]
      ,[line_manager_id]
      ,[line_manager]
      ,[phone_number]
      ,[email]
      ,[position]
      ,[location]
      ,[pg_user_name_deprecated]
      ,[pg_t_number_deprecated]
      ,[gender_code]
      ,[nationality]
      ,[role]
      ,[active_ind]
      ,[functional_manager_id]
      ,[functional_manager]
      ,[employment_date]
      ,[contract_termination_date]
      ,[contract_type]
      ,[approval_required]
      ,[legal_entity]
      ,[fte]
      ,[org_unit_id]
      ,[org_unit_name]
      ,[team_id]
      ,[team_name]
      ,[delivery_team_id]
      ,[delivery_team_name]
      ,[senior_delivery_team_id]
      ,[senior_delivery_team_name]
      ,[sub_bu_id]
      ,[sub_bu_name]
      ,[bu_id]
      ,[bu_name]
      ,[create_ip_ind]
      ,[gender]
      ,[photo_ind]
      ,[allow_photo_usage_ind]
      ,[primary_competency_name]
      ,[country]
      ,[city]
      ,[country_work_location]
      ,[city_id]
      ,[country_id]
      ,[ad_object_id]
      ,[az_ad_object_id]
      ,[az_ad_account_enabled_ind]
      ,[leave_ind]
      ,[country_work_location_id]
      ,[team_leader_ind]
      ,[team_owner_ind]
      ,[management_community_member_ind]
      ,[org_unit_area]
      ,[project_manager_ind]
      ,[service_level_manager_ind]
      ,[competency_name]
      ,[role_name]
      ,[seniority_id]
      ,[seniority_name]
      ,[technical_account_ind]
      ,[position_id]
      ,[creation_at]
      ,[external_ind]
      ,[external_type]
      ,[vendor_ind]
      ,[shift_time]
      ,[resource_row_id]
      ,[postal_code]
      ,[draft_profile_ind]
  FROM [data_in].[org_emp_vw]
  ),

--------------------------------------------------------------
/*FTE*/
--------------------------------------------------------------
FTE as(
  SELECT id as [FTE_ID]
      ,employee_id as [EMPEE_ID]
      ,fte as [FTE_PCT]
      ,cast(start_date as date) AS FTE_START_DATE
      ,case when end_date is null then '9999-01-01' else cast(end_date as date) END AS FTE_END_DATE
  FROM data_in.org_emp_fte
  ),
--------------------------------------------------------------
/*DATE_CONTRACT_CLEARING*/
--------------------------------------------------------------
DATE_CONTRACT as(
select YYYY_START as DAY_DATE
,format(yyyy_start, 'yyyy-MM') as MONTH
,CAST(DATEADD(month, DATEDIFF(month, 0, YYYY_START), 0) AS DATE) AS START_OF_MONTH
,CAST(EOMONTH(YYYY_START) AS DATE) AS END_OF_MONTH
,EMPEE_ID
,CNTRT_START_DATE
,CNTRT_END_DATE
,CNTRT_TYPE_ID
,LE_ID
from YYYY_LIST a
Left join CONTRACT_LIST b on a.ID=b.id
where (YYYY_START>=CNTRT_START_DATE and YYYY_START<=CNTRT_END_DATE)
),

FIRST_JOINING as(
select
DAY_DATE
,a.EMPEE_ID as EMPLOYEE_ID
,FIRST_CONTRACT_START_DATE
,LAST_CONTRACT_END_DATE
,MONTH
,START_OF_MONTH
,END_OF_MONTH
--,a.CNTRT_TYPE_ID
,c.CNTRT_TYPE_NAME AS CONTRACT_TYPE_NAME
--,a.LE_ID
--,CNTRT_ID
,employee_full_name as EMPLOYEE_NAME
,line_manager as LINE_MANAGER_NAME
--,position as POSITION
,EMPEE_PROFL_NAME as PRIMARY_PROFILE
--,location as LOCATION
,city as CITY
--,country_work_location
,country
,CASE WHEN active_ind =1 then 'Active' else 'Inactive' end as STATUS
,e.LE_NAME
,f.FTE_PCT
,i.ORG_UNIT_NAME as ORG_NAME
--,CASE WHEN h.ORG_NAME is null then i.ORG_UNIT_NAME else h.ORG_NAME end as ORG_NAME
,h.T_NAME
,h.DT_NAME
,h.SDT_NAME
,h.SBU_NAME
,h.BU_NAME
,case 
      when i.ORG_UNIT_NAME=i.TEAM_NAME then i.PARNT_TEAM_ID
      when i.ORG_UNIT_NAME=i.DELIVERY_TEAM_NAME then i.PARNT_DELIVERY_TEAM_ID
	  when i.ORG_UNIT_NAME=i.SENIOR_DELIVERY_TEAM_NAME then i.PARNT_SENIOR_DELIVERY_TEAM_ID
	  when i.ORG_UNIT_NAME=i.SUB_BU_NAME then i.PARNT_SUB_BU_ID
	  when i.ORG_UNIT_NAME=i.BU_NAME then i.PARNT_BU_ID
	  end as PARENT_ORG_UNIT_ID
,case when DAY_DATE=getdate() then 1 
when DAY_DATE=EOMONTH(day_date) then 1
      when DAY_DATE=LAST_CONTRACT_END_DATE then 1
	  when DAY_DATE=cast(getdate() as date) then 1 else 0 end as DATE_TO_SHOW
,CASE WHEN SUBSTRING(CAST(LAST_CONTRACT_END_DATE as varchar),1,7)=MONTH then 'Y' else 'N' end as NOTICE_LAST_MONTH
,CASE WHEN leave_ind = 1 then 'Y' else 'N' end as LEAVE_IND
from DATE_CONTRACT a
left join FIRST_LAST_CONTRACT_EMPEE_DATE b on a.EMPEE_ID=b.EMPEE_ID
left join CONTRACT_TYPE c on a.CNTRT_TYPE_ID=c.CNTRT_TYPE_ID
left join EMPLOYEE_VW d on a.EMPEE_ID=d.id
left join LEGAL_ENTITY e on a.LE_ID=e.LE_ID
left join FTE f on a.EMPEE_ID=f.EMPEE_ID and (a.DAY_DATE>=f.FTE_START_DATE and a.DAY_DATE<=f.FTE_END_DATE)
left join ORG_UNIT g on a.EMPEE_ID=g.employee_id and (a.DAY_DATE>=g.start_date and a.DAY_DATE<=g.end_date)
left join ORG_UNIT_MAP h on g.organization_unit_id=h.ORG_ID
left join ORG_UNIT_MAP_HIST i on g.organization_unit_id=i.ORG_UNIT_ID
left join PRIMARY_PROFILE j on a.EMPEE_ID=j.EMPEE_ID),

history_position as (
SELECT a.[id]
      ,[employee_id]
      ,[position_id]
	  ,b.name
      ,[start_date]
      ,case when end_date is null then '2999-01-01' else end_date end as end_date
  FROM data_in.org_employee_position a
  left join  [data_in].[org_emp_position] b on a.position_id=b.id
),



BEFORE_CHANGE as (SELECT 
a.EMPLOYEE_ID
,DAY_DATE
,FIRST_CONTRACT_START_DATE
,LAST_CONTRACT_END_DATE
,MONTH
,START_OF_MONTH
,END_OF_MONTH
--,a.CNTRT_TYPE_ID
,CONTRACT_TYPE_NAME
--,a.LE_ID
--,CNTRT_ID
,EMPLOYEE_NAME
,LINE_MANAGER_NAME
--,POSITION
,name as POSITION
,c.id as id_row_number
,PRIMARY_PROFILE
--,location as LOCATION
,city as CITY
--,country_work_location
,country as COUNTRY 
,STATUS
,LE_NAME
,FTE_PCT
,ORG_NAME
,T_NAME
,DT_NAME
,SDT_NAME
,SBU_NAME
,a.BU_NAME
--,PARENT_ORG_UNIT_ID
,b.ORG_UNIT_NAME as PARENT_ORG_UNIT_NAME
,NOTICE_LAST_MONTH
FROM FIRST_JOINING a 
left join ORG_UNIT_MAP_HIST b on a.PARENT_ORG_UNIT_ID=b.ORG_UNIT_ID
left join history_position c on a.EMPLOYEE_ID=c.employee_id and (a.DAY_DATE>=c.start_date and a.DAY_DATE<=c.end_date)
where DATE_TO_SHOW=1 and month>='2022-01' 
),


  POSITION_HISTORY_RANGE_SUPPORT as (
select EMPLOYEE_ID,DAY_DATE,MAX(id_row_number) as id_position_max
from BEFORE_CHANGE
group by EMPLOYEE_ID,DAY_date),

POSITION_AFTER_CHANGE as (

select a.*,b.id_position_max from BEFORE_CHANGE a
left join POSITION_HISTORY_RANGE_SUPPORT b on a.EMPLOYEE_ID=b.EMPLOYEE_ID and a.DAY_DATE=b.DAY_DATE
where 
(a.id_row_number=b.id_position_max or b.id_position_max is null))



insert into data_mis_project.contract_mapping_historical_position

select EMPLOYEE_ID
--,DAY_DATE
,FIRST_CONTRACT_START_DATE
,LAST_CONTRACT_END_DATE
,MONTH
,START_OF_MONTH
,END_OF_MONTH
--,a.CNTRT_TYPE_ID
,CONTRACT_TYPE_NAME
--,a.LE_ID
--,CNTRT_ID
,EMPLOYEE_NAME
,LINE_MANAGER_NAME
--,POSITION
,POSITION
--,c.id as id_row_number
,PRIMARY_PROFILE
--,location as LOCATION
,city as CITY
--,country_work_location
,country as COUNTRY 
,STATUS
,LE_NAME
,FTE_PCT
,ORG_NAME
,T_NAME
,DT_NAME
,SDT_NAME
,SBU_NAME
,BU_NAME
--,PARENT_ORG_UNIT_ID
,PARENT_ORG_UNIT_NAME
,NOTICE_LAST_MONTH 
 from POSITION_AFTER_CHANGE
--WHERE EMPLOYEE_ID = 228968





OPTION (MAXRECURSION 32767)
GO

