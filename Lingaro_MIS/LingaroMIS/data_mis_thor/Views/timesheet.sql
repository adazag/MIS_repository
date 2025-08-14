
CREATE view [data_mis_thor].[timesheet] as (
SELECT client_id, client_name, project_id, project_name, employee_id, employee_full_name, day_date, month_date, timesheet_code_id, timesheet_version_project_code_type, timesheet_code_name, timesheet_code, multiplier, ip_code, minutes, 
                  hours, days, comment, timeoff, status, competency_id, new_taxonomy_role_id, seniority_id
FROM     data_in.tmsht_time_report_vw
WHERE  (client_id in ( 43,564788, 564787,62,	43760,	43766,	43779,	43784,	43790,	43793,	46869,	108155,	108156,	108157,	108344,	136812,	553615,	1020859)
 AND (day_date >= '2023-01-01')))
GO

GRANT SELECT
    ON OBJECT::[data_mis_thor].[timesheet] TO [data_mis_thor_read_all]
    AS [dbo];
GO

GRANT ALTER
    ON OBJECT::[data_mis_thor].[timesheet] TO [data_mis_thor_read_all]
    AS [dbo];
GO

