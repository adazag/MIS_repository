
CREATE view [data_out_manila_apps].[sulu_mnl_cbp_report] as (
select 
	e.id,
	e.employee_full_name,
	e.line_manager_id,
	e.line_manager,
	case 
	when left(phone_number,2) = '63' then REPLACE(REPLACE(REPLACE(REPLACE(phone_number, left(phone_number,2), '0'),'-', ''),' ', ''),'''','')
	when left(phone_number,1) = '9' then REPLACE(REPLACE(REPLACE(CONCAT('0',phone_number),'-', ''),' ', ''),'''','')
	when left(phone_number,5) = '+(63)' then REPLACE(REPLACE(REPLACE(REPLACE(phone_number, left(phone_number,5), '0'),'-', ''),' ', ''),'''','')
	when left(phone_number,3) = '+63' then REPLACE(REPLACE(REPLACE(REPLACE(phone_number, left(phone_number,3), '0'),'-', ''),' ', ''),'''','')
	when left(phone_number,1) = ' ' then REPLACE(phone_number, left(phone_number,1), '')
	else phone_number end as phone_number,
	e.email,
	e.position,
	e.location,
	e.nationality,
	e.role,
	e.team_name,
	e.bu_name,
    e.postal_code,
	r.emergency_phone_number
FROM [data_in].[org_emp_vw] e
LEFT JOIN [data_in].[employee_restricted_info] r ON e.id = r.employee_id
where legal_entity  = 'Lingaro (Philippines)' and active_ind = '1'
)
GO

