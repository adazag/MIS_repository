create view data_mis_project.lttst_accnt_TR as
with ts as (
select t.id as TMSHT_ID
            , tpc.timesheet_code_id as TMSHT_CODE_ID
			, tv.status as STTUS_CODE
            , t.employee_id as EMPEE_ID
			, emp.employee_full_name as EMPEE_FULL_NAME
			, emp.email as EMPEE_EMAIL
            , cast(dateadd(day, 6, t.start_date) as date) [TMSHT_END_DATE]
            , tvp.project_id as PROJ_ID
			, p.name as PROJ_NAME
            , p.client_id as CLEN_ID
			, cl.name as CLEN_NAME
       from data_in.tmsht t
                left join data_in.tmsht_ver tv on t.id = tv.timesheet_id
				left join data_in.tmsht_ver_proj tvp on tvp.timesheet_version_id = tv.id
				left join data_in.tmsht_ver_proj_code tpc on tvp.id = tpc.timesheet_version_project_id
				left join data_in.tmsht_ver_proj_code_time tpct on tpc.id = tpct.version_project_code_id
                left join data_in.proj p on p.project_id = tvp.project_id
				left join data_in.proj_clnt cl on cl.id=p.client_id
				left join data_in.org_emp_vw emp on t.employee_id = emp.id
       where tv.status <> 'REJECTED'
         and dateadd(day, 7, t.start_date) >= dateadd(year, -1, getdate())
),


actl as (
select  distinct
ts.EMPEE_ID, EMPEE_FULL_NAME, EMPEE_EMAIL, ts.CLEN_ID, CLEN_NAME, PROJ_ID, PROJ_NAME, TMSHT_END_DATE LATEST_DATE, ts.STTUS_CODE from ts
inner join
(select EMPEE_ID, CLEN_ID, MAX(TMSHT_END_DATE) LATEST_TMSHT_END_DATE, STTUS_CODE from ts
group by EMPEE_ID, CLEN_ID, STTUS_CODE) tsa
on tsa.EMPEE_ID=ts.EMPEE_ID and tsa.CLEN_ID=ts.CLEN_ID and tsa.LATEST_TMSHT_END_DATE=ts.TMSHT_END_DATE
),

book_all as (
SELECT b.employee_id as [EMPEE_ID]
      ,employee_full_name as EMPEE_FULL_NAME
	  ,e.email EMPEE_EMAIL
      ,b.project_id as [PROJ_ID]
      ,b.project_name as [PROJ_NAME]
	  ,b.status as STTUS_CODE
      ,cast([DAY_DATE] as date) LATEST_DATE
	  ,p.client_id as CLEN_ID
	  ,cl.name as CLEN_NAME
  FROM data_in.proj_booking_daily_vw b
  left join data_in.proj p on p.project_id=b.project_id
  left join data_in.proj_clnt cl on cl.id=p.client_id
  left join data_in.org_emp e on e.id=b.employee_id
  where status <> 'REJECTED'
  and [DAY_DATE] >= dateadd(year, -1, GETDATE())
),

book as (
select distinct
b.EMPEE_ID, EMPEE_FULL_NAME, EMPEE_EMAIL, b.CLEN_ID, CLEN_NAME, PROJ_ID, PROJ_NAME, b.LATEST_DATE, ba.STTUS_CODE from book_all b
inner join
(select EMPEE_ID, CLEN_ID, MAX(LATEST_DATE) LATEST_DATE, STTUS_CODE from book_all
group by EMPEE_ID, CLEN_ID, STTUS_CODE) ba
on ba.EMPEE_ID=b.EMPEE_ID and ba.CLEN_ID=b.CLEN_ID and ba.LATEST_DATE=b.LATEST_DATE
),

tot as (
select actl.*, 'ACTUAL' as TYPE from actl
UNION ALL
select book.*, 'BOOKING' as TYPE from book
),


owner_team_proj as (SELECT *
  FROM data_mis.proj),

emp as (select *
from [data_in].[org_emp])


select tot.*, owner_team_proj.parent_project_manager_employee_id, emp.email as PARNT_PROJ_MGR_EMPEE_MAIL, emp.az_ad_object_id PARNT_PROJ_MGR_az_ad_object_id, emp.ad_object_id as PARNT_PROJ_MGR_ad_object_id  from tot
left join owner_team_proj on tot.PROJ_ID=owner_team_proj.project_id
left join emp on owner_team_proj.parent_project_manager_employee_id=emp.id
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[lttst_accnt_TR] TO [data_mis_project__lttst_accnt_TR_read_all]
    AS [dbo];
GO

