
CREATE PROCEDURE [data_mis_project].[update_HR_Report] as

IF OBJECT_ID('[data_mis_project].[HR_Report]', 'U') IS NOT NULL TRUNCATE TABLE [data_mis_project].[HR_Report];



DECLARE @MinDate DATE = DATEFROMPARTS(YEAR(GETDATE()) - 1, 1, 1);
DECLARE @CurentDate DATE=GETDATE()
DECLARE @MaxDate DATE = DATEFROMPARTS(YEAR(GETDATE()), 12, 31);  -- generating dates for the next 6 months from today


WITH 
Date_list as (
SELECT  1 as ID
        ,@MinDate as DayDate
        union all
        select  
    1 as ID
    ,DATEADD(day,1,DayDate)
        from    Date_list
        where   DayDate < @MaxDate
),

change_contract_termination_date as (
select 
	 id
	,employee_id
	,start_date as contract_start_date
	,ISNULL(end_date, '9999-01-01') as contract_end_date
from data_in.employee_contract
),


contract_ranking AS (
    SELECT id, employee_id, contract_start_date, contract_end_date, 
           ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY contract_end_date DESC) AS Rank
    FROM change_contract_termination_date
),


-- change enddate FTE NULL --> 9999-01-01
employee_fte as (
select   employee_id
		,start_date as fte_start_date
		,ISNULL(end_date, '9999-01-01') as fte_end_date
		,fte
from data_in.org_emp_fte
),

fte_ranking AS (
    SELECT  employee_id, fte_start_date, fte_end_date , fte,
           ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY fte_end_date DESC) AS Rank
    FROM employee_fte
),

fte_last_changes as(
select  employee_id
		,fte_start_date
		,fte_end_date
		,fte, leave_ind
		,case when (Rank=1 and oe.leave_ind=0) then '9999-01-01' 
		WHEN rank = 1 and oe.leave_ind = 1 and fte_end_date <> EOMONTH(fte_end_date) THEN EOMONTH(fte_end_date)
		else fte_end_date end as to_this_fte_end_date
from fte_ranking fr
LEFT JOIN [data_in].[org_emp] oe ON fr.employee_id = oe.id
),

employee_organization_unit as (
select   employee_id
		,organization_unit_id
		,start_date as start_date_in_org_unit
		,ISNULL(end_date, '9999-01-01') as end_date_in_org_unit
from data_in.org_emp_org_unit oeou
where employee_id >= 0
),

org_unit_ranking AS (
    SELECT  employee_id, start_date_in_org_unit, end_date_in_org_unit , organization_unit_id,
           ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY end_date_in_org_unit DESC) AS Rank_org
    FROM employee_organization_unit
),

employee_organization_unit_last_changes as(
select  employee_id
		,start_date_in_org_unit
		,end_date_in_org_unit
		,organization_unit_id
		,leave_ind
		,case when (Rank_org=1 and oe.leave_ind=0) then '9999-01-01' 
		WHEN Rank_org = 1 and oe.leave_ind = 1 and end_date_in_org_unit <> EOMONTH(end_date_in_org_unit) THEN EOMONTH(end_date_in_org_unit)
		else end_date_in_org_unit end as to_this_org_unit_end_date
from org_unit_ranking our
LEFT JOIN [data_in].[org_emp] oe ON our.employee_id = oe.id
),


indefinite_period_of_time as(
select   ec.id
		,ec.employee_id
		,legal_entity_id
		,contract_start_date
		,contract_end_date
		,contract_type_id
		,ct.name AS contract_type_name
        ,oe.leave_ind
		,oe.active_ind
        ,CAST(oe.leaver_ind_modified_at AS DATE) AS leaver_ind_modified_at
        ,oe.leaver_last_day_of_work
		,long_term_leave_ind
		,long_term_leave_start_date
		,long_term_leave_end_date
		,case when (cr.Rank=1 and oe.leave_ind=0) then '9999-01-01' 
		WHEN rank = 1 and oe.leave_ind = 1 and contract_end_date <> EOMONTH(contract_end_date) THEN EOMONTH(contract_end_date)
		else contract_end_date end as to_this_date
from data_in.employee_contract ec
LEFT JOIN [data_in].[org_contract_type] ct ON ec.contract_type_id = ct.id
LEFT JOIN [data_in].[org_emp] oe ON ec.employee_id = oe.id
LEFT JOIN contract_ranking cr on ec.id = cr.id

),

first_contract_employee as (
select  employee_id
		,MAX(rank) as first_contract
FROM contract_ranking
group by employee_id
),

employee_contract AS (
    SELECT
		dl.DayDate
		,ipot.id
        ,ipot.employee_id
		,legal_entity_id
        ,ipot.contract_type_id
		,ipot.contract_type_name
		,oeou.organization_unit_id
        ,ipot.contract_start_date
		,ipot.contract_end_date
        ,to_this_date
		,fte
		,rank
        ,ipot.leave_ind
		,ipot.active_ind
        ,leaver_ind_modified_at
        ,CASE WHEN leaver_last_day_of_work is null then ipot.contract_end_date else leaver_last_day_of_work end as leaver_last_day_of_work
        ,long_term_leave_ind
        ,long_term_leave_start_date
        ,long_term_leave_end_date
    FROM indefinite_period_of_time ipot
	left join Date_list dl on contract_start_date <= dl.DayDate AND to_this_date >= dl.DayDate
	LEFT JOIN employee_organization_unit_last_changes oeou ON ipot.employee_id = oeou.employee_id AND (oeou.start_date_in_org_unit <= dl.DayDate AND end_date_in_org_unit >= dl.DayDate)
	left join fte_last_changes fte on ipot.employee_id = fte.employee_id and dl.DayDate>= fte.fte_start_date and dl.DayDate <= fte.to_this_fte_end_date
	LEFT JOIN contract_ranking cr on ipot.id = cr.id
),

Working_day_or_non_working_day as(
select 
		 DayDate
		,a.id
        ,employee_id
		,legal_entity_id
		,e.country_work_location_id
        ,contract_type_id
		,contract_type_name
		,organization_unit_id
        ,contract_start_date
		,contract_end_date
        ,to_this_date
		,a.fte
		,rank
        ,a.leave_ind
		,a.active_ind
        ,a.leaver_ind_modified_at
        ,a.leaver_last_day_of_work
        ,a.long_term_leave_ind
        ,a.long_term_leave_start_date
        ,a.long_term_leave_end_date
		,b.day_date
		,month_cnt
		,case when b.day_date is null then 'Non working day' else 'Working day' end as TypeOfDay
from employee_contract a
--left join data_in.org_working_day b on emp.NON_WKDAY_CAL_ID = b.calendar_id and a.DayDate = b.day_date
left join data_mis_project.org_emp e on a.employee_id = e.id
left join data_in.org_legal_entity le on a.legal_entity_id = le.id
left join data_in.org_working_day b on le.calendar_id = b.calendar_id AND a.DayDate = b.day_date
),

amount_of_contract as (
select employee_id, count(rank) as number_of_contract
from contract_ranking
group by employee_id
),

new_employees_in_current_month as( 
select a.*
		,b.start_date
		,1 as joiners_in_this_month from amount_of_contract a
left join data_in.employee_contract b on a.employee_id = b.employee_id
where number_of_contract = 1 and start_date >= DATEADD(month, DATEDIFF(month, 0, @CurentDate), 0) and start_date < = EOMONTH(@CurentDate)
),

last_change as (
SELECT
	 DayDate
	,TypeOfDay
    ,c.employee_id
    ,contract_type_id
    ,contract_type_name
    ,organization_unit_id
    ,contract_start_date
	,contract_end_date
	,rank
	,fte
	,to_this_date
	,leave_ind
	,active_ind
    ,leaver_ind_modified_at
    ,long_term_leave_ind
    ,long_term_leave_start_date
    ,long_term_leave_end_date
	,leaver_last_day_of_work
	,CASE 
        WHEN Rank = 1 THEN 'Y'
        ELSE 'N'
    END AS IsMostRecentContract,
	CASE 
		WHEN DayDate <= to_this_date and leave_ind = 0 THEN 1
		WHEN DayDate <= contract_end_date and leave_ind = 1  THEN 1
		ELSE 0 
		END AS IsHeadcount_LastDayOfMonth,
    CASE 
        WHEN YEAR(DayDate) = YEAR(contract_end_date) AND MONTH(DayDate) = MONTH(contract_end_date) and rank = 1 AND leave_ind = 1 THEN 'Y'
        ELSE 'N'
    END AS IsLeaver,
    CASE 
        WHEN leave_ind = '1' AND CAST(leaver_ind_modified_at AS DATE) <= c.DayDate THEN 'Y'
		WHEN rank = 1 and leave_ind = '1' AND CAST(leaver_ind_modified_at AS DATE) IS NULL and YEAR(DayDate) = YEAR(contract_end_date) AND MONTH(DayDate) = MONTH(contract_end_date) THEN 'Y'
		WHEN rank = 1 and leave_ind = '1' AND CAST(leaver_ind_modified_at AS DATE) > contract_end_date and YEAR(DayDate) = YEAR(contract_end_date) AND MONTH(DayDate) = MONTH(contract_end_date) THEN 'Y'
        ELSE 'N'
    END AS OnNotice,
    CASE 
        WHEN long_term_leave_ind = '1' AND (DayDate >= long_term_leave_start_date AND DayDate <= long_term_leave_end_date ) THEN 'Y'
        ELSE 'N'
    END AS OnLongtermLeave,
	case when joiners_in_this_month is null then 0 else 1 end as joiners_current_month,
	case when c.rank = first_contract and YEAR(DayDate) = YEAR(contract_start_date) AND MONTH(DayDate) = MONTH(contract_start_date)  THEN 1 ELSE 0 end as IsNewJoinersInThisMonth
	,c.month_cnt
	,ISNULL(CAST(ROUND(((fte / 100) / month_cnt),4) as numeric (6,4)),0) as capacity
FROM Working_day_or_non_working_day c
LEFT JOIN new_employees_in_current_month nj on c.employee_id = nj.employee_id and DayDate >= DATEADD(month, DATEDIFF(month, 0, @CurentDate), 0) and DayDate < = EOMONTH(@CurentDate)
left join first_contract_employee fce on c.employee_id = fce.employee_id and c.rank = fce.first_contract
where DayDate <= to_this_date
--ORDER BY c.DayDate, ec.employee_id, ec.id
),

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
      ,[timeoff]
      --,[status]
  FROM [data_in].[tmsht_time_report_vw]
  where timeoff = 1 and day_date >= '2023-01-01'),

position as (
Select employee_id
		,start_date
		,ISNULL(end_date, '9999-01-01') as position_end_date
		,position_id
from data_in.org_employee_position 
),

role as (
select ecr.employee_id, ecr.competency_role_id, r.id as role_id, r.name as role_name, ecr.start_date, ISNULL(ecr.end_date, '9999-01-01') as role_end_date
      from data_in.org_emp_competency_role_new ecr
               left join
           data_in.new_taxonomy_competency_role ncr
           on ncr.id = ecr.competency_role_id
               left join
           data_in.role r
           on r.id = ncr.role_id
),

final as (
select  DayDate
	   ,TypeOfDay
       ,a.employee_id
	   ,role_id
	   ,position_id
	   --,contract_type_id
       ,contract_type_name
       ,organization_unit_id
       ,contract_start_date
	   ,contract_end_date
	   ,fte
	   --,active_ind
       --,long_term_leave_ind
       ,project_id
	   ,CASE WHEN timeoff = 1 then 1 else 0 end as IsTimeOff
	   ,long_term_leave_start_date
       ,long_term_leave_end_date
	   ,leaver_last_day_of_work
	   ,IsHeadcount_LastDayOfMonth
	   ,active_ind
	   ,leave_ind
	   ,IsLeaver
	   ,leaver_ind_modified_at
	   ,OnNotice
	   ,OnLongtermLeave
	   ,joiners_current_month
	   ,IsNewJoinersInThisMonth
	   ,month_cnt
	   ,capacity
	   ,CASE WHEN OnLongtermLeave = 'Y' then capacity
	   WHEN OnLongtermLeave = 'N' and timeoff = 1 then 0
	   WHEN TypeOfDay = 'Non working day' then 0
	   ELSE capacity END AS capacity_without_holiday
	   ,CASE WHEN OnLongtermLeave = 'N' and timeoff = 1 then 0
	   else (fte/100) end as fte_for_current_day
from last_change a
left join NON_WORKING b on a.employee_id =b.employee_id and a.DayDate = b.day_date 
left join role c on a.employee_id = c.employee_id and DayDate >= c.start_date and DayDate <= role_end_date
left join position d on a.employee_id = d.employee_id and DayDate >= d.start_date and DayDate <= position_end_date
)


insert into [data_mis_project].[HR_Report]
select 
		DayDate
	   ,TypeOfDay
       ,employee_id
	   ,role_id
	   ,position_id
	   --,contract_type_id
       ,contract_type_name
       ,organization_unit_id
       ,contract_start_date
	   ,contract_end_date
	   ,fte
	   --,active_ind
       --,long_term_leave_ind
       ,project_id
	   ,IsTimeOff
	   ,long_term_leave_start_date
       ,long_term_leave_end_date
	   ,leaver_last_day_of_work
	   ,IsHeadcount_LastDayOfMonth
	   ,active_ind
	   ,leave_ind
	   ,IsLeaver
	   ,leaver_ind_modified_at
	   ,OnNotice
	   ,OnLongtermLeave
	   ,joiners_current_month
	   ,IsNewJoinersInThisMonth
	   ,month_cnt
	   ,capacity_without_holiday
	   ,fte_for_current_day
	   ,capacity
from final

OPTION (MAXRECURSION 0)
GO

GRANT EXECUTE
    ON OBJECT::[data_mis_project].[update_HR_Report] TO [lingaro-mis-adf]
    AS [dbo];
GO

