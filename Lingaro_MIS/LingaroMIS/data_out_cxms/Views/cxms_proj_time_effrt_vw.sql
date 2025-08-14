-- data_out_cxms.cxms_proj_time_effrt_vw source

CREATE view [data_out_cxms].[cxms_proj_time_effrt_vw] as 
select --CAST(date_trunc('quarter', day_date)  + interval '3 months' - interval '1 day' AS date) as quarter
--DATEADD (dd, -1,  dateadd(QUARTER, datediff(QUARTER, 0, ct.day_date), 0))  as quarter,
DATEADD (dd, -1, DATEADD(qq, DATEDIFF(qq, 0, ct.day_date) +1, 0)) as quarter,
p.project_id,
case 
when e.city_id = '1' then 'Warsaw'
when e.city_id = '2' then 'Lublin'
when e.city_id = '3' then 'Cincinnati'
when e.city_id = '4' then 'Manila'
when e.city_id = '5' then 'India'
when e.city_id = '6' then 'Singapore'
when e.city_id = '7' then 'Wroclaw'
when e.city_id = '8' then 'Zurych'
end as site_name,
-- e.location as site_name,
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
where technical_account_ind = 0
and last_version = 1
group BY
p.project_id,
-- e.location,
e.city_id,
--DATEADD (dd, -1,  dateadd(QUARTER, datediff(QUARTER, 0, ct.day_date), 0)) 
DATEADD (dd, -1, DATEADD(qq, DATEDIFF(qq, 0, ct.day_date) +1, 0));
GO

GRANT SELECT
    ON OBJECT::[data_out_cxms].[cxms_proj_time_effrt_vw] TO [data_out_cxms_read_all]
    AS [dbo];
GO

