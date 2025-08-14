
CREATE view [data_out_manila_apps].[timesheet_utilization_report_tview] as (
select a.employee_id,
a.employee_full_name,
a.line_manager_id,
a.line_manager_full_name as line_manager,
a.organization_unit_id,
a.organization_unit_name,
a.start_date,
a.version_number,
a.status,
a.due_date,
a.close_date,
a.total_hours,
a.client_work_hours,
a.utilization,
a.country,
a.city,
a.bu_name,
b.department_id SUB_BU_ID, 
b.department_name SUB_BU_NAME, 
b.sub_division_id DELIVERY_TEAM_ID, 
b.sub_division_name DELIVERY_TEAM_NAME, 
b.TEAM_ID, 
b.TEAM_NAME  
FROM [data_in].[timesheet_utilization_report_tview] a
left join [data_mis].[org_structure_new] b on a.organization_unit_id  = b.org_unit_id)
GO

