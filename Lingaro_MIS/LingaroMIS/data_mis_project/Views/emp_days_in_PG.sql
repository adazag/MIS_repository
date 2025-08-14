create view data_mis_project.emp_days_in_PG as
select 
c.ultimate_parent_name 
,p.project_name
,p.employee_id
,p.employee_full_name
,COUNT(day_date) as all_working_days
from [data_in].[tmsht_time_report_vw] p
LEFT JOIN [data_in].[proj_clnt] c ON p.client_id = c.id
where  ultimate_parent_name = 'Procter & Gamble' and day_date > DATEADD(YEAR, -2, GETDATE()) 
group by 
c.ultimate_parent_name
,p.project_name
,p.employee_id
,p.employee_full_name
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[emp_days_in_PG] TO [data_mis_project_emp_days_in_PG_read_all]
    AS [dbo];
GO

