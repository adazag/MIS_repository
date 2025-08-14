--/****** Object:  View [data_mis_rls].[tmsht_pm_approval]    Script Date: 09.04.2025 07:54:55 ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO





CREATE view data_mis_project.overtime with schemabinding as
--WITH SCHEMABINDING 
--as
--declare @start_date date = '2024-01-01'
--declare @end_date date =  DATETRUNC(WEEK, getdate());


with TIMESHEETS as (
SELECT [client_id]
      ,[client_name]
      ,[project_id]
      ,[project_name]
      ,[employee_id]
      ,[employee_full_name]
      ,[day_date]
      ,[month_date]
      ,[timesheet_code_id]
      ,[timesheet_version_project_code_type]
      ,[timesheet_code_name]
      ,[timesheet_code]
      ,[hours]
      ,[days]
	  ,minutes
 --     ,[comment]
      ,[timeoff]
      ,[status]
  FROM [data_in].[tmsht_time_report_vw] a
  where
  status in ('approved','verification','open','pending','rejected') and day_date >= '2025-01-01' and day_date<DATETRUNC(WEEK, getdate())

  and timeoff = 0
),

tmst_id as (
select distinct t.id
      ,cast(t.employee_id as nvarchar) employee_id
	  ,t.start_date
	  ,t.end_date
	  ,t.week_number 
	  ,v.last_version
	  --,c.timesheet_version_project_id
	  --,c.id as timesheet_version_project_code_id
	  ,p.project_id
	  ,p.id as tmst_ver_proj_id

  from [data_in].[tmsht] t
  left join (select distinct id, timesheet_id, last_version from [data_in].[tmsht_ver]) v on v.timesheet_id = t.id
  left join (select distinct id,timesheet_version_id, project_id from [data_in].[tmsht_ver_proj]) p on p.timesheet_version_id = v.id
  --left join (select distinct id, timesheet_version_project_id from data_in.tmsht_ver_proj_code) c on c.timesheet_version_project_id=p.id
  --left join (select distinct version_project_code_id from [data_in].[tmsht_ver_proj_code_time] ct on ct.version_project_code_id=c.id
  where t.week_number is not null
  and t.start_date <> (select max(start_date) from [data_in].[tmsht] where week_number is not null
  and t.start_date>='2024-01-01'
  and v.last_version=1
				
  )),

timesheet_with_project as (
  select 
		b.id as timesheet_id
		,a.timesheet_code_id
		,a.timesheet_version_project_code_type
		,a.timesheet_code_name
		,a.timesheet_code
		,a.employee_id
		,a.employee_full_name
		,a.month_date
		,b.week_number
		,a.status
		--,a.timeoff
		,b.start_date
		,b.end_date
		,b.week_number ++ ' (' ++ FORMAT(b.start_date, 'MMM') ++ '-' ++ FORMAT(b.start_date, 'dd') ++ '-' ++ FORMAT(b.end_date, 'dd') ++ ')'  as timesheet_name
		,hours 
		,minutes
		,a.project_id
		,c.timesheet_version_project_id
		,c.id as timesheet_version_project_code_id

  from TIMESHEETS a
  left join tmst_id b on a.employee_id = b.employee_id
  and a.day_date between b.start_date and b.end_date
  and a.project_id = b.project_id

  left join (select distinct id, timesheet_version_project_id, timesheet_code_id from data_in.tmsht_ver_proj_code) c on c.timesheet_version_project_id=b.tmst_ver_proj_id and a.timesheet_code_id = c.timesheet_code_id

		),

timesheet_grouped as (select 
		timesheet_id
		,timesheet_code_id
		,timesheet_version_project_code_type
		,timesheet_code_name
		,timesheet_code
		,employee_id
		,employee_full_name
		,month_date
		,week_number
		,status
		--,a.timeoff
		,start_date
		,end_date
		,timesheet_name
		,project_id	
		,timesheet_version_project_id
		,timesheet_version_project_code_id
		,sum(hours) as sum_hours
		,sum(minutes) as sum_minutes

from timesheet_with_project
group by timesheet_id
		,timesheet_code_id
		,timesheet_version_project_code_type
		,timesheet_code_name
		,timesheet_code
		,employee_id
		,employee_full_name
		,month_date
		,week_number
		,status
		--,a.timeoff
		,start_date
		,end_date
		,timesheet_name
		,project_id	
		,timesheet_version_project_id
		,timesheet_version_project_code_id
		),

tmst_with_PM as (select distinct
		a.timesheet_id
		,a.timesheet_code_id
		,a.timesheet_version_project_code_type
		,a.timesheet_version_project_id
		,a.timesheet_version_project_code_id
		,a.timesheet_code_name
		,a.timesheet_code
		,a.employee_id
		,a.employee_full_name
		,a.month_date
		,a.week_number
		,a.status
		,a.timesheet_name
		,a.sum_hours
		,a.sum_minutes
		,a.start_date
		,a.end_date
		--,a.timeoff
		,a.project_id
		,p.manager_id as project_manager_id
from timesheet_grouped a
left join data_in.proj p on a.project_id = p.project_id

),


tmst_approval as (select 
		timesheet_version_project_code_id
		,status as tmst_ver_proj_code_status
		,approval_level 
		,aprover_employee_id as approver

from data_in.tmsht_approval 
--where approval_level = 'project_code'
),
Bookings as (SELECT  [id]
      ,[employee_id]
      ,[project_id]
      ,[week_number]
      ,[start_date]
      ,[end_date]
      ,[booking_percentage]
      ,[booking_man_days]
      ,[booking_hours]
      ,[status]
      ,[criticality]
      ,[comment]
      ,[competency_role_id]
      ,[creation_at]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
      ,[competency_id]
      ,[role_id]
      ,[seniority_id]
      ,[working_days_cnt]
      ,[resource_row_id]
      ,[resource_proposal_id]
  FROM [data_in].[proj_booking]
  where start_date>='2025-01-01' and end_date<='2025-12-31'
  ),

 FTE as ( SELECT [id]
      ,[employee_id]
      ,[start_date]
      ,[end_date]
      ,[fte]
      ,[created_by2]
      ,[creation_at]
      ,[modified_by2]
      ,[modified_at]
      ,[created_by]
      ,[modified_by]
  FROM [data_in].[org_emp_fte]),


tmst_pm_approver as (select
		a.timesheet_id
		,a.timesheet_code_id
		,a.timesheet_version_project_code_type
		,a.timesheet_version_project_id
		,a.timesheet_version_project_code_id
		,a.timesheet_code_name
		,a.timesheet_code
		,a.employee_id
		,a.employee_full_name
		,a.month_date
		,a.week_number
		,a.status as timesheet_status
		,a.timesheet_name
		,a.sum_hours
		,a.sum_minutes
		,c.booking_hours
		,a.start_date
		,a.end_date
		,a.status
		--,a.timeoff
		,a.project_id
		,a.project_manager_id
		,b.tmst_ver_proj_code_status
		,b.approval_level
		,b.approver
		,case when a.project_manager_id = b.approver then 1 else 0 end as Is_Approver_Employee_PM
		,d.fte
from tmst_with_PM a
left join tmst_approval b on a.timesheet_version_project_code_id = b.timesheet_version_project_code_id
left join Bookings c on a.project_id=c.project_id and a.week_number=c.week_number and a.employee_id=c.employee_id 
left join FTE d on a.employee_id=d.employee_id and a.start_date>=d.start_date and a.start_date<=ISNULL(d.end_date,'9999-01-01')
where sum_hours<>0)

select 
timesheet_id
		,timesheet_code_id
		,timesheet_version_project_code_type
		,timesheet_version_project_id
		,timesheet_version_project_code_id
		,timesheet_code_name
		,timesheet_code
		,employee_id
		,employee_full_name
		,month_date
		,week_number
		,timesheet_status
		,timesheet_name
		,sum_hours
		,sum_minutes
		,booking_hours
		,start_date
		,end_date
		,status
		--,a.timeoff
		,project_id
		,project_manager_id
		,tmst_ver_proj_code_status
		,approval_level
		,approver
		,Is_Approver_Employee_PM
		,fte
		from tmst_pm_approver
		--where employee_id=997498 and month_date='2025-02'
GO

