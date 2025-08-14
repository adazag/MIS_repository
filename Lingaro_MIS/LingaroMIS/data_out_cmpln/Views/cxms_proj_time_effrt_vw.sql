CREATE view [data_out_cmpln].[cxms_proj_time_effrt_vw] as 
select --CAST(date_trunc('quarter', day_date)  + interval '3 months' - interval '1 day' AS date) as quarter
--DATEADD (dd, -1,  dateadd(QUARTER, datediff(QUARTER, 0, ct.day_date), 0))  as quarter,
DATEADD (dd, -1, DATEADD(qq, DATEDIFF(qq, 0, ct.day_date) +1, 0)) as quarter,
p.project_id,
e.location as site_name,
e.email,
pc.name as clnt_name,
sum( ct.time ) as time_effort
from data_in.tmsht t
inner join data_in.tmsht_ver v
on t.id = v.timesheet_id
inner join data_in.org_emp e
on e.id = t.employee_id
inner join data_in.tmsht_ver_proj p
on v.id = p.timesheet_version_id
inner join data_in.tmsht_ver_proj_code c
on p.id = c.timesheet_version_project_id
--inner join [data_in].[proj_tmsht_code] code
--on code.timesheet_code_id = c.timesheet_code_id
left join [data_in].[tmsht_ver_proj_code_time] ct
on c.id = ct.version_project_code_id
left join [data_in].[proj] pp
on pp.project_id = p.project_id
left join [data_in].proj_clnt pc
on pp.client_id = pc.id
where technical_account_ind = 0
and last_version = 1
group BY
p.project_id,
e.location,
DATEADD (dd, -1, DATEADD(qq, DATEDIFF(qq, 0, ct.day_date) +1, 0)),
--//dateadd(QUARTER, datediff(QUARTER, 0, ct.day_date), 0),
e.email,
pc.name
GO

GRANT SELECT
    ON OBJECT::[data_out_cmpln].[cxms_proj_time_effrt_vw] TO [data_out_cmpln_read_all]
    AS [dbo];
GO

