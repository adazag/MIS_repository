
CREATE PROCEDURE [data_in].[update_tmsht_time_fct] as

IF OBJECT_ID('[data_in].[tmsht_time_fct]', 'U') IS NOT NULL TRUNCATE TABLE [data_in].[tmsht_time_fct];


insert into  [data_in].[tmsht_time_fct]

select timesheet_id,employee_id, t.start_date, t.end_date, c.timesheet_code_id, time as time_min_amt, multiplier, comment,timesheet_code_name
from [data_in].[tmsht] t 
left join [data_in].[tmsht_ver] v on v.timesheet_id = t.id
left join [data_in].[tmsht_ver_proj] p on p.timesheet_version_id = v.id
left join [data_in].[tmsht_ver_proj_code] c on c.timesheet_version_project_id=p.id
left join [data_in].[tmsht_ver_proj_code_time] ct on ct.version_project_code_id=c.id
left join [data_in].[tmsht_version_project_bench] pb on pb.timesheet_version_id=v.id
left join [data_in].[proj_tmsht_code] tc on tc.project_id=p.project_id
where t.start_date>='2024-01-01' and time>0
GO

GRANT EXECUTE
    ON OBJECT::[data_in].[update_tmsht_time_fct] TO [lingaro-mis-adf]
    AS [dbo];
GO

