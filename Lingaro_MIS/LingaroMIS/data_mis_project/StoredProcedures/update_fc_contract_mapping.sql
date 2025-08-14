CREATE PROCEDURE [data_mis_project].[update_fc_contract_mapping] as

IF OBJECT_ID('data_mis_project.fc_contract_mapping', 'U') IS NOT NULL TRUNCATE TABLE data_mis_project.fc_contract_mapping;

/****** Script for SelectTopNRows command from SSMS  ******/



WITH 

--------------------------------------------------------------
/* CONTRACT DATA*/
--------------------------------------------------------------
CONTRACT_LIST as (
SELECT 1 as ID
	  ,employee_id [EMPEE_ID]
      ,id [CNTRT_ID]
      ,cast(start_date as date) as [CNTRT_START_DATE]
      ,case when end_date is null then '9999-01-01' /* cast(getdate() as date)*/ else cast(end_date as date) end as [CNTRT_END_DATE]
      ,contract_type_id [CNTRT_TYPE_ID]
      ,legal_entity_id [LE_ID]
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
SELECT  id [CNTRT_TYPE_ID]
      ,code [CNTRT_TYPE_CODE]
      ,name [CNTRT_TYPE_NAME]
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
SELECT [org_unit_id]
      ,[org_unit_name]
      ,[org_unit_parent_id]
      ,[start_date]
      ,[end_date]
      ,parent_organization_id [Level0]
      ,parent_organization_name [Level0Name]
      ,organization_id [Level1]
      ,organization_name [Level1Name]
      ,department_id [Level2]
      ,department_name [Level2Name]
      ,division_id [Level3]
      ,division_name [Level3Name]
      ,sub_division_id [Level4]
      ,sub_division_name [Level4Name]
      ,team_id [Level5]
      ,team_name [Level5Name]
  FROM [data_mis].[org_structure_new]
  ),


--------------------------------------------------------------
/*POSITION*/
--------------------------------------------------------------
	 position_history as (SELECT 
  [id]
      ,[employee_id]
      ,[position_id]
      ,[start_date]
      ,eomonth(isnull([end_date],'9999-01-01')) as end_date
      --,[creation_at]
      --,[modified_at]
      --,[created_by]
      --,[modified_by]
    ,CASE 
        -- Jeśli end_date jest równy start_date następnej pozycji, cofnij end_date o jeden dzień
        WHEN [end_date] = LEAD([start_date]) OVER (PARTITION BY [employee_id] ORDER BY [start_date]) 
        THEN DATEADD(DAY, -1, [end_date])
        -- W przeciwnym razie pozostaw end_date bez zmian
        ELSE [end_date]
    END AS adjusted_end_date,
    -- Sprawdzenie, czy end_date pokrywa się ze start_date następnej pozycji
    CASE 
        WHEN [end_date] = LEAD([start_date]) OVER (PARTITION BY [employee_id] ORDER BY [start_date]) 
        THEN 'Pokrywają się' 
        ELSE 'Nie pokrywają się'
    END AS overlap_status
FROM 
     [data_in].[org_employee_position]
),
--------------------------------------------------------------
/*POSTITION NAME*/
--------------------------------------------------------------
position_name as(SELECT [id]
      ,[name]
      ,[active_ind]
      ,[order_number]
  FROM [data_in].[org_emp_position]
),

--------------------------------------------------------------
/*LINE MANAGER*/
--------------------------------------------------------------
line_manager_history as (SELECT 
	   a.[id]
      ,[employee_id]
      ,a.[line_manager_id]
	  ,b.employee_full_name as line_manager_name
      ,[start_date]
      ,eomonth(isnull([end_date],'9999-01-01')) as end_date
      --,[creation_at]
      --,[modified_at]
      --,[created_by]
      --,[modified_by]
    ,CASE 
        -- Jeśli end_date jest równy start_date następnej pozycji, cofnij end_date o jeden dzień
        WHEN [end_date] = LEAD([start_date]) OVER (PARTITION BY [employee_id] ORDER BY [start_date]) 
        THEN DATEADD(DAY, -1, [end_date])
        -- W przeciwnym razie pozostaw end_date bez zmian
        ELSE [end_date]
    END AS adjusted_end_date,
    -- Sprawdzenie, czy end_date pokrywa się ze start_date następnej pozycji
    CASE 
        WHEN [end_date] = LEAD([start_date]) OVER (PARTITION BY [employee_id] ORDER BY [start_date]) 
        THEN 'Pokrywają się' 
        ELSE 'Nie pokrywają się'
    END AS overlap_status
FROM data_in.org_emp_line_manager a
left join data_in.org_emp_vw b on a.line_manager_id = b.id
),

--------------------------------------------------------------
/*COMPETENCY_NEW_TAXONOMY_ROLE_HISTORY*/
--------------------------------------------------------------
new_taxonomy_role_history as (
SELECT 
	   a.[id]
      ,[employee_id]
      ,competency_role_id
	  ,c.name as competency_name
	  ,d.name as new_taxonomy_role
      ,[start_date]
      ,eomonth(isnull([end_date],'9999-01-01')) as end_date
      --,[creation_at]
      --,[modified_at]
      --,[created_by]
      --,[modified_by]
    ,CASE 
        -- Jeśli end_date jest równy start_date następnej pozycji, cofnij end_date o jeden dzień
        WHEN [end_date] = LEAD([start_date]) OVER (PARTITION BY [employee_id] ORDER BY [start_date]) 
        THEN DATEADD(DAY, -1, [end_date])
        -- W przeciwnym razie pozostaw end_date bez zmian
        ELSE [end_date]
    END AS adjusted_end_date,
    -- Sprawdzenie, czy end_date pokrywa się ze start_date następnej pozycji
    CASE 
        WHEN [end_date] = LEAD([start_date]) OVER (PARTITION BY [employee_id] ORDER BY [start_date]) 
        THEN 'Pokrywają się' 
        ELSE 'Nie pokrywają się'
    END AS overlap_status
FROM data_in.org_emp_competency_role_new a
left join data_in.new_taxonomy_competency_role b on a.competency_role_id = b.id
left join data_in.new_taxonomy_competency c on b.competency_id = c.id
left join data_in.role d on b.role_id = d.id
),

--------------------------------------------------------------
/*OLD_ROLE*/
--------------------------------------------------------------

old_role_history as (
SELECT 
  [id]
      ,[employee_id]
      ,role_name as old_role
      ,[start_date]
      ,eomonth(isnull([end_date],'9999-01-01')) as end_date
      --,[creation_at]
      --,[modified_at]
      --,[created_by]
      --,[modified_by]
    ,CASE 
        -- Jeśli end_date jest równy start_date następnej pozycji, cofnij end_date o jeden dzień
        WHEN [end_date] = LEAD([start_date]) OVER (PARTITION BY [employee_id] ORDER BY [start_date]) 
        THEN DATEADD(DAY, -1, [end_date])
        -- W przeciwnym razie pozostaw end_date bez zmian
        ELSE [end_date]
    END AS adjusted_end_date,
    -- Sprawdzenie, czy end_date pokrywa się ze start_date następnej pozycji
    CASE 
        WHEN [end_date] = LEAD([start_date]) OVER (PARTITION BY [employee_id] ORDER BY [start_date]) 
        THEN 'Pokrywają się' 
        ELSE 'Nie pokrywają się'
    END AS overlap_status
FROM 
     data_in.org_emp_old_role
),

--------------------------------------------------------------
/*SENIORITY_HISTORY*/
--------------------------------------------------------------

seniority_history as (
SELECT 
	   a.[id]
      ,[employee_id]
      ,seniority_id 
	  ,name as seniority_name
      ,[start_date]
      ,eomonth(isnull([end_date],'9999-01-01')) as end_date
      --,[creation_at]
      --,[modified_at]
      --,[created_by]
      --,[modified_by]
    ,CASE 
        -- Jeśli end_date jest równy start_date następnej pozycji, cofnij end_date o jeden dzień
        WHEN [end_date] = LEAD([start_date]) OVER (PARTITION BY [employee_id] ORDER BY [start_date]) 
        THEN DATEADD(DAY, -1, [end_date])
        -- W przeciwnym razie pozostaw end_date bez zmian
        ELSE [end_date]
    END AS adjusted_end_date,
    -- Sprawdzenie, czy end_date pokrywa się ze start_date następnej pozycji
    CASE 
        WHEN [end_date] = LEAD([start_date]) OVER (PARTITION BY [employee_id] ORDER BY [start_date]) 
        THEN 'Pokrywają się' 
        ELSE 'Nie pokrywają się'
    END AS overlap_status
FROM data_in.org_emp_seniority a
left join data_in.seniority b on a.seniority_id = b.id
),


--------------------------------------------------------------
/*LEGAL ENTITY*/
--------------------------------------------------------------
LEGAL_ENTITY AS(
  SELECT id [LE_ID]
      , name [LE_NAME]
      ,calendar_id [SULU3_CAL_ID]
  FROM data_in.org_legal_entity
  ),

--------------------------------------------------------------
/*DATE RANGE*/
--------------------------------------------------------------
YYYY_LIST as (
SELECT  1 as ID
        ,cast('2023/01/01' as date)  as YYYY_START
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
  SELECT id [FTE_ID]
      ,employee_id [EMPEE_ID]
      ,fte [FTE_PCT]
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
,CNTRT_ID
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
,email as EMAIL
--,line_manager as LINE_MANAGER_NAME
,lmh.line_manager_name as LINE_MANAGER_NAME
,functional_manager as FUNCTIONAL_MANAGER
,ltrh.competency_name as COMPETENCY
,ltrh.new_taxonomy_role as NEW_TAXONOMY_ROLE
,orh.old_role as ROLE
,sh.seniority_name as CLIENT_ENGAGEMENT_SENIORITY
,k.name POSITION
--,p as PRIMARY_PROFILE
--,location as LOCATION
,city as CITY
--,country_work_location
--,country
,CASE WHEN d.active_ind =1 then 'Active' else 'Inactive' end as STATUS
,e.LE_NAME
,f.FTE_PCT
,i.org_unit_id as ORG_ID
,i.org_unit_name as ORG_NAME
,i.Level5 as T_ID
,i.Level5Name as T_NAME
,i.Level4 as SUB_DIVISION_ID
,i.Level4Name as SUB_DIVISION
,i.Level3 as DIVISION_ID
,i.Level3Name as DIVISION
,i.Level2 as DEPARTMENT_ID
,i.Level2Name as DEPARTMENT
,i.Level1 as ORGANIZATION_ID
,i.Level1Name as ORGANIZATION
--,i.Level0Name as OH_NAME


--,CASE WHEN h.ORG_NAME is null then i.ORG_UNIT_NAME else h.ORG_NAME end as ORG_NAME
--,h.T_NAME
--,h.DT_NAME
--,h.SDT_NAME
--,h.SBU_NAME
--,h.BU_NAME
--,case 
--      when i.org_name=i.T_NAME then i.PARNT_TEAM_ID
--      when i.org_name=i.DELIVERY_TEAM_NAME then i.PARNT_DELIVERY_TEAM_ID
--	  when i.org_name=i.SENIOR_DELIVERY_TEAM_NAME then i.PARNT_SENIOR_DELIVERY_TEAM_ID
--	  when i.org_name=i.SUB_BU_NAME then i.PARNT_SUB_BU_ID
--	  when i.org_name=i.BU_NAME then i.PARNT_BU_ID
--	  end as PARENT_ORG_UNIT_ID
,case when DAY_DATE=getdate() then 1 
when DAY_DATE=EOMONTH(day_date) then 1
      when DAY_DATE=LAST_CONTRACT_END_DATE then 1
	  when DAY_DATE=cast(getdate() as date) then 1 else 0 end as DATE_TO_SHOW
from DATE_CONTRACT a
left join FIRST_LAST_CONTRACT_EMPEE_DATE b on a.EMPEE_ID=b.EMPEE_ID
left join CONTRACT_TYPE c on a.CNTRT_TYPE_ID=c.CNTRT_TYPE_ID
left join EMPLOYEE_VW d on a.EMPEE_ID=d.id
left join LEGAL_ENTITY e on a.LE_ID=e.LE_ID
left join FTE f on a.EMPEE_ID=f.EMPEE_ID and (a.DAY_DATE>=f.FTE_START_DATE and a.DAY_DATE<=f.FTE_END_DATE)
left join ORG_UNIT g on a.EMPEE_ID=g.employee_id and (a.DAY_DATE>=g.start_date and a.DAY_DATE<=g.end_date)
--left join ORG_UNIT_MAP h on g.organization_unit_id=h.ORG_ID
left join ORG_UNIT_MAP i on g.organization_unit_id=i.org_unit_id
left join position_history j on a.EMPEE_ID=j.employee_id and a.start_of_month>=j.start_date and a.start_of_month<=j.end_date
left join position_name k on j.position_id=k.id
left join line_manager_history lmh on a.EMPEE_ID=lmh.employee_id and a.start_of_month>=lmh.start_date and a.start_of_month<=lmh.end_date
left join new_taxonomy_role_history ltrh on a.EMPEE_ID=ltrh.employee_id and a.start_of_month>=ltrh.start_date and a.start_of_month<=ltrh.end_date
left join old_role_history orh on a.EMPEE_ID=orh.employee_id and a.start_of_month>=orh.start_date and a.start_of_month<=orh.end_date
left join seniority_history sh on a.EMPEE_ID=sh.employee_id and a.start_of_month>=sh.start_date and a.start_of_month<=sh.end_date
)


insert into data_mis_project.fc_contract_mapping
SELECT 
EMPLOYEE_ID
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
,EMAIL
--,LINE_MANAGER_NAME
,LINE_MANAGER_NAME
,FUNCTIONAL_MANAGER
,COMPETENCY
,NEW_TAXONOMY_ROLE
,ROLE
,CLIENT_ENGAGEMENT_SENIORITY
,POSITION
--,location as LOCATION
,city as CITY
--,country_work_location
--,country
,STATUS
,LE_NAME
,FTE_PCT
,ORG_ID
,ORG_NAME
,T_ID as TEAM_ID
,T_NAME as TEAM_NAME
,SUB_DIVISION_ID
,SUB_DIVISION
,DIVISION_ID
,DIVISION
,DEPARTMENT_ID
,DEPARTMENT
,ORGANIZATION_ID
,ORGANIZATION
--,b.org_name as PARENT_ORG_UNIT_NAME  

FROM FIRST_JOINING a
where DATE_TO_SHOW=1
order by DAY_DATE


OPTION (MAXRECURSION 32767)
GO

GRANT EXECUTE
    ON OBJECT::[data_mis_project].[update_fc_contract_mapping] TO [lingaro-mis-adf]
    AS [dbo];
GO

