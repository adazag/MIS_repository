create view data_out_manila_apps.eval_form_data as(
select 
	id,
	employee_full_name,
	line_manager_id,
	line_manager,
	case 
	when left(phone_number,2) = '63'and nationality = 'Filipino' then REPLACE(REPLACE(REPLACE(REPLACE(phone_number, left(phone_number,2), '0'),'-', ''),' ', ''),'''','')
	when left(phone_number,1) = '9' and nationality = 'Filipino' then REPLACE(REPLACE(REPLACE(CONCAT('0',phone_number),'-', ''),' ', ''),'''','') 
	when left(phone_number,5) = '+(63)' and nationality = 'Filipino' then REPLACE(REPLACE(REPLACE(REPLACE(phone_number, left(phone_number,5), '0'),'-', ''),' ', ''),'''','')
	when left(phone_number,3) = '+63' and nationality = 'Filipino' then REPLACE(REPLACE(REPLACE(REPLACE(phone_number, left(phone_number,3), '0'),'-', ''),' ', ''),'''','')
	else REPLACE(phone_number, ' ', '') end as phone_number,
	email,
	position,
	location,
	nationality,
	role,
	team_name,
	bu_name
FROM [data_in].[org_emp_vw]
where active_ind = '1')
GO

