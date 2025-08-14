CREATE PROCEDURE [data_mis_project].[update_capacity_vs_demand_report] as

IF OBJECT_ID('[data_mis_project].[capacity_vs_demand_report]', 'U') IS NOT NULL TRUNCATE TABLE [data_mis_project].[capacity_vs_demand_report];
WITH 

EMPLOYEE_TABLE_NEW_SULU as (
SELECT [id]
      ,[ldap_login]
      ,[employee_full_name]
      ,[line_manager_id]
      ,[line_manager_name]
      ,[phone_number]
      ,[email]
      ,[position_name]
      ,[country_name]
	  ,city_name
      ,[pg_user_name_deprecated]
      ,pg_t_number_deprecated
      ,[gender_code]
      ,[nationality_name]
      ,[role]
      ,[active_ind]
      ,[functional_manager_id]
      ,[functional_manager_name]
      ,[employment_date]
      ,case when [contract_termination_date] is null then EOMONTH(GETDATE(), 6) else [contract_termination_date] end as [contract_termination_date]
      ,[contract_type]
      ,[fte]
	  ,org_unit_name 
	  ,team_name
	  ,delivery_team_name
	  ,senior_delivery_team_name
	  ,sub_bu_name
	  ,bu_name
      ,[create_ip_ind]
      ,[photo_ind]
      ,[allow_photo_usage_ind]  
      ,[country_work_location_name]
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
	  ,DATEADD(DAY, 1, EOMONTH(getdate(), -1)) as CURRENT_START_DATE
  FROM data_mis_project.org_emp
  where  (id>0 and active_ind=1) or (id <= -1156)),


FTE_TO_CHANGE as (
SELECT id as [FTE_ID]
      ,employee_id as [EMPEE_ID]
      ,fte as [FTE_PCT]
      ,cast(start_date as date) as [FTE_START_DATE] 
      ,case when end_date is null then  cast(DATEADD(month,5,GETDATE()) as date) else cast(end_date as date) end as FTE_END_DATE
	  ,case when cast(getdate() as date)>=cast(start_date as date) and cast(getdate() as date)<=cast(end_date as date) then 1 
	        when cast(getdate() as date)>=cast(start_date as date) and end_date is null then 1 
	  else 0 end as CURRENT_FTE
  FROM data_in.org_emp_fte
),

FTE as (
SELECT 
FTE_ID
,EMPEE_ID
,FTE_PCT
,FTE_START_DATE
,FTE_END_DATE
,CURRENT_FTE
FROM FTE_TO_CHANGE
WHERE  CURRENT_FTE=1),


WORKDAYS as (
SELECT day_date as [WKDAY_DATE]
      ,month_name as [MTH_NAME]
      ,calendar_id as [NON_WKDAY_CAL_ID]
      ,month_cnt as [MTH_CNT]
      ,week_cnt as [WEEK_CNT]
  FROM data_in.org_working_day),

  BOOKINGS as (
  	SELECT a.id
      ,employee_id
	  ,a.role_id
	  ,b.name as NEW_TAXONOMY_ROLE_NAME
	  ,seniority_id
	  ,c.name as SENIORITY_NAME
      ,project_id
      ,start_date as BOOKG_START_DATE
      ,end_date as BOOKG_END_DATE
      ,booking_percentage
      ,status
      ,criticality
      ,comment
  FROM data_in.proj_booking a
left join data_in.role b on a.role_id= b.id
left join [data_in].[seniority] c on a.SENIORITY_ID = c.id
),

list_emp_with_avatars as (
SELECT a.id as employee_id
		,start_date as employment_date
		,case when b.end_date is null then EOMONTH(GETDATE(), 6) else end_date end as contract_termination_date
FROM data_in.org_emp a 
left join data_in.employee_contract b on a.id = b.employee_id 
),

contract_start_date as (
SELECT  employee_id
		, MIN(employment_date) as employment_date
		,DATEADD(DAY, 1, EOMONTH(getdate(), -1)) as CURRENT_START_DATE
FROM list_emp_with_avatars
GROUP BY employee_id
),

contract_termination_date as (
SELECT 
		employee_id
		,MAX(contract_termination_date) as contract_termination_date
FROM list_emp_with_avatars
GROUP BY employee_id
),

FOR_LIST_DATES as (
SELECT a.employee_id as EMPEE_ID
      ,case when a.employee_id  <=-1156 then CURRENT_START_DATE 
	  when a.employee_id > 0 and CURRENT_START_DATE>=employment_date then CURRENT_START_DATE else employment_date end as CONTRACT_START_DATE
	  ,contract_termination_date as CONTRACT_END_DATE
	  ,CURRENT_START_DATE

FROM contract_start_date a
left join contract_termination_date b on a.employee_id = b.employee_id
),


LIST_DATES as(
select EMPEE_ID, CONTRACT_START_DATE,CURRENT_START_DATE
from FOR_LIST_DATES	
union all 
select b.empee_id, DATEADD(day,1,a.CONTRACT_START_DATE),b.CURRENT_START_DATE  
from LIST_DATES a 
INNER JOIN FOR_LIST_DATES b on a.EMPEE_ID=b.EMPEE_ID
where a.CONTRACT_START_DATE<CONTRACT_END_DATE),


NON_WORKING as (
SELECT
--	   [client_id]
--    ,[client_name]
       [project_id]
      --,[project_name]
      ,[employee_id]
      --,[employee_full_name]
      ,[day_date]
      --,[month_date]
      --,[timesheet_code_id]
      --,[timesheet_version_project_code_type]
      --,[timesheet_code_name]
      --,[timesheet_code]
      --,[multiplier]
      --,[ip_code]
      --,[minutes]
      --,[hours]
      ,[days]
      --,[comment]
      --,[timeoff]
      --,[status]
  FROM [data_in].[tmsht_time_report_vw]
  where project_name like 'Non-working time%' and day_date>=DATEADD(DAY, 1, EOMONTH(getdate(), -1)) ),

  NON_WORKING_DETAILS as (
  SELECT 
       [project_id] as PROJ_ID
      ,a.[employee_id] as EMPEE_ID
      ,[day_date]
      ,[days]
	  ,c.calendar_id as NON_WKDAY_CAL_ID
	  ,'Time Off' as TYPE
  FROM NON_WORKING a 
  LEFT JOIN data_in.org_emp_country_city b on a.employee_id = b.employee_id
  left join data_in.org_location_calendar c on b.country_id = c.location_id),


MAIN_TABLE_1 as(
select 
	EMPEE_ID
	,CONTRACT_START_DATE as DAY_DATE 
from LIST_DATES 
where CONTRACT_START_DATE>=CURRENT_START_DATE),

MAIN_TABLE_HOLIDAYS_CHANGES as(
select 
	 a.EMPEE_ID 
	,a.DAY_DATE
	,a.days as DAYS
	,a.TYPE
	,'' as STATUS
	,PROJ_ID
	,c.FTE_PCT
	,MTH_CNT
	,WEEK_CNT
	,(MTH_CNT*FTE_PCT)/100 as WORKDAYS_MTH
	,days/((MTH_CNT*FTE_PCT)/100) as [ALLOCATION%]
	,days/((WEEK_CNT*FTE_PCT)/100) as [ALLOCATION_WEEK%]
from NON_WORKING_DETAILS a
LEFT JOIN FTE c on a.EMPEE_ID=c.EMPEE_ID
LEFT JOIN WORKDAYS d on a.NON_WKDAY_CAL_ID=d.NON_WKDAY_CAL_ID and a.day_date=d.WKDAY_DATE

),

MAIN_TABLE_HOLIDAYS as (
select 	
	 EMPEE_ID 
	,DAY_DATE
	,days as DAYS
	,TYPE
	,'' as STATUS
	,PROJ_ID
	,null as BOOKG_START_DATE
	,null as BOOKG_END_DATE
	,null as BOOKG_COMMENT
	,'' as NEW_TAXONOMY_ROLE_NAME
	,'' as SENIORITY_NAME
	--,c.FTE_PCT
	--,MTH_CNT
	--,WEEK_CNT
	--,(MTH_CNT*FTE_PCT)/100 as WORKDAYS_MTH
	,[ALLOCATION%]
	,[ALLOCATION_WEEK%]
	from MAIN_TABLE_HOLIDAYS_CHANGES
),

MAIN_TABLE_CAPACITY_CHANGES as(
select 
	 a.EMPEE_ID 
	,a.DAY_DATE
	,b.country_id
	,case when a.EMPEE_ID <0 then 1
	when a.EMPEE_ID >0 then 1*FTE_PCT/100 end as DAYS
	,'Capacity' as TYPE
	,0 as PROJ_ID
	,c.FTE_PCT
	,olc.calendar_id as NON_WKDAY_CAL_ID
	,d.WKDAY_DATE
	,d.MTH_CNT
	,d.WEEK_CNT
from MAIN_TABLE_1 a
LEFT JOIN FTE c on a.EMPEE_ID=c.EMPEE_ID
LEFT JOIN data_in.org_emp_country_city b on a.EMPEE_ID = b.employee_id
left join data_in.org_location_calendar olc on b.country_id = olc.location_id
LEFT JOIN WORKDAYS d on olc.calendar_id=d.NON_WKDAY_CAL_ID and a.DAY_DATE=d.WKDAY_DATE
),

MAIN_TABLE_CAPACITY as (
select 
	 EMPEE_ID 
	,DAY_DATE
	,DAYS
	,TYPE
	,'' as STATUS
	,0 as PROJ_ID
	,null as BOOKG_START_DATE
	,null as BOOKG_END_DATE
	,null as BOOKG_COMMENT
	,'' as NEW_TAXONOMY_ROLE_NAME
	,'' as SENIORITY_NAME
	--,FTE_PCT
	--,NON_WKDAY_CAL_ID
	--,WKDAY_DATE
	--,MTH_CNT
	--,WEEK_CNT
	--,(MTH_CNT*FTE_PCT)/100 as WORKDAYS_MTH
	,days/MTH_CNT as [ALLOCATION%]
	,days/WEEK_CNT as [ALLOCATION_WEEK%]
	from MAIN_TABLE_CAPACITY_CHANGES
	where WKDAY_DATE is not null ),

	MAIN_TABLE_DEMAND_CHANGES as (
select 
	 a.EMPEE_ID 
	,a.DAY_DATE
	,case when a.EMPEE_ID < 0 then 1
	when a.EMPEE_ID > 0 then (1*FTE_PCT)/100 end as DAYS
	,'Booking' as TYPE
	,e.project_id as PROJ_ID
	,case when a.EMPEE_ID <0 THEN 100 
	when a.EMPEE_ID > 0 then c.FTE_PCT end as FTE_PCT
	,NEW_TAXONOMY_ROLE_NAME
	,SENIORITY_NAME
	,olc.calendar_id NON_WKDAY_CAL_ID
	,d.WKDAY_DATE
	,d.MTH_CNT
	,d.WEEK_CNT
	,e.status as STATUS
	,e.booking_percentage
	,e.BOOKG_START_DATE
	,e.BOOKG_END_DATE
	,e.comment
from MAIN_TABLE_1 a
LEFT JOIN FTE c on a.EMPEE_ID=c.EMPEE_ID
LEFT JOIN data_in.org_emp_country_city b on a.EMPEE_ID = b.employee_id
left join data_in.org_location_calendar olc on b.country_id = olc.location_id
LEFT JOIN WORKDAYS d on olc.calendar_id=d.NON_WKDAY_CAL_ID and a.DAY_DATE=d.WKDAY_DATE
LEFT JOIN BOOKINGS e on a.EMPEE_ID=e.employee_id and (a.DAY_DATE>=BOOKG_START_DATE and a.DAY_DATE<=BOOKG_END_DATE)
	
	),

MAIN_TABLE_DEMAND as (
select 
	 EMPEE_ID 
	,DAY_DATE
	,(MTH_CNT * booking_percentage/100) / MTH_CNT as DAYS
	,TYPE
	,STATUS
	,PROJ_ID
	,BOOKG_START_DATE
	,BOOKG_END_DATE
	,comment as BOOKG_COMMENT
	,NEW_TAXONOMY_ROLE_NAME
	,SENIORITY_NAME
	--,FTE_PCT
	--,NON_WKDAY_CAL_ID
	--,WKDAY_DATE
	--,MTH_CNT
	--,WEEK_CNT
	--,(MTH_CNT*FTE_PCT)/100 as WORKDAYS_MTH
	,(DAYS * booking_percentage/100 )/((MTH_CNT*FTE_PCT)/100) as [ALLOCATION%]
	,(DAYS * booking_percentage/100 )/((WEEK_CNT*FTE_PCT)/100) as [ALLOCATION_WEEK%]
	from MAIN_TABLE_DEMAND_CHANGES
	where WKDAY_DATE is not null and PROJ_ID is not null
),

UNION_TABLES AS (
select * from MAIN_TABLE_DEMAND
union all
select * from MAIN_TABLE_CAPACITY
union all
select * from MAIN_TABLE_HOLIDAYS)


insert into [data_mis_project].[capacity_vs_demand_report] 
select * 
from UNION_TABLES

--where EMPEE_ID <0
--where EMPEE_ID=461 and DAY_DATE>='2023-07-01' and DAY_DATE<='2023-07-31'



OPTION (MAXRECURSION 0)
GO

