create view data_out_fc.for_salaries_new as
with

mth as
(
    SELECT DATEFROMPARTS(YEAR(DATEADD(YEAR,-1,GETDATE())),1,1) PERIOD
    UNION ALL
    SELECT DATEADD(month, 1, PERIOD)
    from mth
    where DATEADD(month, 1, PERIOD) <= DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()),1)
),

cntr_dates as (
select employee_id as EMPEE_ID, cast((start_date) as date) CNTR_STRAT_DATE, 
cast((ISNULL(end_date, cast('9999-01-01' as date))) as date) CNTRT_END_DATE, legal_entity_id as  LE_ID, contract_type_id CNTRT_TYPE_ID
from data_in.employee_contract 
),

org_unit as (
select employee_id EMPEE_ID, cast((start_date) as date) [UNIT_START_DATE], 
cast((ISNULL(end_date, cast('9999-01-01' as date))) as date) [UNIT_END_DATE], organization_unit_id [ORG_UNIT_ID]
from data_in.org_emp_org_unit
),

empee as (
select [id] EMPEE_ID, [employee_full_name] "NAME", 
concat(city, ', ', country) as LOCATION, 
line_manager_id LM_ID, line_manager LM
from [data_in].[org_emp_vw] where id > 0
),

actl as (
SELECT 
  a.employee_id EMPEE_ID,
  cast(DAY_DATE as date) DAY_DATE,
  month_name MTH_NAME,
  case when project_id in (-11, -9, -8, -7, -6, -5, -4, -3, -2, -1, 4,7) then time_days  else 0 end SickLeave,
  case when project_name not like 'Non-working%' or project_id in (-13, -10) then time_days * multiplier  else 0 end Actuals
FROM data_in.fin_actuals_vw a


),


final_a as (
select 
a.EMPEE_ID, CNTR_STRAT_DATE CTRTNSTART, CNTRT_END_DATE CTRNTEND, a.MTH_NAME, 
sum(Actuals) ACTUALS, sum(SickLeave) SICKLEAVE, e.NAME, LM_ID "LM ID", LM, LOCATION,
ct.name "Contract type", l.name "Legal entity", 
org.name MAPPING, cast(concat(a.MTH_NAME, '-01') as date) "full month"
from actl a
left join empee e on a.EMPEE_ID=e.EMPEE_ID
left join cntr_dates c on a.EMPEE_ID=c.EMPEE_ID and DAY_DATE >= CNTR_STRAT_DATE and DAY_DATE <= CNTRT_END_DATE
left join org_unit o on a.EMPEE_ID=o.EMPEE_ID and DAY_DATE >= UNIT_START_DATE and DAY_DATE <= UNIT_END_DATE
left join [data_in].[org_legal_entity] l on l.id = c.LE_ID
left join [data_in].[org_contract_type] ct on ct.id = c.CNTRT_TYPE_ID
left join [data_in].org_unit org on org.id = o.ORG_UNIT_ID
--where DAY_DATE >= cast(DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0) as date) and DAY_DATE <= cast(DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) + 1, -1) as date)
group by a.EMPEE_ID, CNTR_STRAT_DATE, CNTRT_END_DATE, MTH_NAME,  e.NAME, LM_ID, LM, 
LOCATION,  ct.name, l.name, org.name, cast(concat(a.MTH_NAME, '-01') as date)
),

empee_wa as (
select e.EMPEE_ID, e.LM, e.LM_ID, e.LOCATION, e.NAME, mth.PERIOD from empee e
cross join mth
left join final_a a on a.EMPEE_ID=e.EMPEE_ID and a.[full month]=mth.PERIOD
where a.EMPEE_ID is null
),

final_wa as (
select 
e.EMPEE_ID, 
CNTR_STRAT_DATE CTRTNSTART, CNTRT_END_DATE CTRNTEND, left(PERIOD,7) MTH_NAME, 
NULL ACTUALS, NULL SICKLEAVE, e.NAME, LM_ID "LM ID", LM, LOCATION,
ct.name "Contract type", l.name "Legal entity", 
org.name MAPPING, PERIOD "full month"
from empee_wa e
left join cntr_dates c on e.EMPEE_ID=c.EMPEE_ID and eomonth(PERIOD) >= CNTR_STRAT_DATE and PERIOD <= CNTRT_END_DATE
left join org_unit o on e.EMPEE_ID=o.EMPEE_ID and eomonth(PERIOD) >= UNIT_START_DATE and (PERIOD) <= UNIT_END_DATE
left join [data_in].[org_legal_entity] l on l.id = c.LE_ID
left join [data_in].[org_contract_type] ct on ct.id = c.CNTRT_TYPE_ID
left join [data_in].[org_unit] org on org.id = o.ORG_UNIT_ID
),

tot as (
select * from final_a
union all
select * from final_wa
),

tot_final as (select EMPEE_ID
, case 
	when CTRNTEND='9999-01-01' and CTRTNSTART <=[full month] then [full month] 
	when CTRNTEND<=EOMONTH([full month]) or CTRTNSTART <=[full month] then [full month] 
	else CTRTNSTART 
	end as CTRTNSTART
, case 
	when CTRNTEND='9999-01-01' or CTRNTEND>=EOMONTH([full month]) then EOMONTH([full month]) 
	else CTRNTEND 
	end as CTRNTEND
, MTH_NAME, ACTUALS, SICKLEAVE, NAME, [LM ID], LM, LOCATION, [Contract type], [Legal entity], MAPPING, [full month]
from tot
where (CTRNTEND ='9999-01-01' or CTRNTEND >= [full month])
),

tot_final_agg as (
select EMPEE_ID, min(CTRTNSTART) CTRTNSTART, max(CTRNTEND) CTRNTEND, MTH_NAME, sum(ACTUALS) ACTUALS, sum(SICKLEAVE) SICKLEAVE,
NAME, [LM ID], LM, LOCATION, [Contract type], [Legal entity], MAPPING, [full month]
from tot_final
group by EMPEE_ID, MTH_NAME, NAME, [LM ID], LM, LOCATION, [Contract type], [Legal entity], MAPPING, [full month]
)


select * 
from tot_final_agg


where year([full month])>=2022
GO

GRANT SELECT
    ON OBJECT::[data_out_fc].[for_salaries_new] TO [data_out_fc_read_all]
    AS [dbo];
GO

