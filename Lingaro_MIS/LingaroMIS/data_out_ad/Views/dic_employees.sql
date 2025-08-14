

CREATE view [data_out_ad].[dic_employees]  as
with


employee as (
SELECT a.id as EmployeeId
		,first_name as FirstName
		,last_name as LastName
		,email as Email
		,position_id
		,functional_manager_id
		,line_manager_id 
		,az_ad_object_id as AzADObjectId
		,ad_object_id as ADObjectId
		,active_ind as IsActive
		,leave_ind as IsLeaver
		,project_manager_ind as IsPM
		,first_day_of_work


  FROM [data_in].[org_emp] a
  --left join new_taxonomy_role b on a.id=b.employee_id

 ),

 details as (
 SELECT a.id as employee_id
		,employment_date
		,s.id as legal_entity_id
		,legal_entity
		,org_unit_id
		,team_id
		,delivery_team_id
		,senior_delivery_team_id
		,sub_bu_id
		,bu_id
		,r.id as role_id
		,role_name
		,ct.ContractTypeId
		,a.contract_termination_date
		,a.contract_type
		,a.nationality
		,a.gender
        ,a.line_manager_id
        ,a.position_id
        ,a.role
        ,a.country_id
        ,a.city_id
        ,a.vendor_ind
 from [data_in].[org_emp_vw] a
 left join data_in.role r on r.name = a.role_name
 left join [data_in].[org_legal_entity] s on s.name = a.legal_entity
 left join data_out_ad.dic_contract_types ct on ct.ContractTypeName = a.contract_type
 ),

 IsFunctionalmanager as (
 select distinct(functional_manager_id), 
 1 as IsFunctionalManager
 from [data_in].[org_emp] o
 ),

 IsLineManager as (
 select distinct(line_manager_id), 
 1 as IsLineManager
 from [data_in].[org_emp_vw]
 ),

 IsDelegate as (
 select distinct(delegate_employee_id) as EMPEE_ID, 
 CASE WHEN end_date  IS NULL then 1 
 WHEN end_date >= CAST(GETDATE() as date) then 1
 else 0 end as IsDelegate
 from [data_in].proj_permission
 where end_date >= CAST(GETDATE() as date) or end_date is null and delegate_employee_id is not null
 )
 

Select	o.id as EmployeeId
		,o.first_name as FirstName
		,o.last_name as LastName
		,o.email as Email
		,d.position_id
		,o.functional_manager_id
		,d.line_manager_id 
		,o.az_ad_object_id as AzADObjectId
		,o.ad_object_id as ADObjectId
		,o.active_ind as IsActive
		,o.leave_ind as IsLeaver
		,o.project_manager_ind as IsPM
		,d.employment_date
		,legal_entity_id
		,org_unit_id
		,team_id
		,delivery_team_id
		,senior_delivery_team_id
		,sub_bu_id
		,bu_id
		,role_id
		,CASE WHEN IsFunctionalmanager = 1 then 1 else 0 end as IsFunctionalmanager
		,CASE WHEN IsLineManager = 1 then 1 else 0 end as IsLineManager
		,CASE WHEN IsDelegate = 1 then 1 else 0 end as IsDelegate
		,modified_at
		,d.ContractTypeId
		,d.role as role_internal
		,d.contract_termination_date
		,d.contract_type
		,o.create_ip_ind
		,o.phone_number
		,d.gender
		,d.nationality
		,o.long_term_leave_ind as IsLongTermLeave
		,o.long_term_leave_start_date as LongTermLeaveStart
		,o.long_term_leave_end_date as LongTermLeaveEnd
		,o.leaver_last_day_of_work as LastDayOfWork
		,d.country_id
		,o.country_work_location_id
		,d.city_id
		,o.ldap_login
        ,o.creation_at
        ,d.vendor_ind
        ,o.leaver_ind_modified_at
        ,long_term_leave_modified_at
		,first_day_of_work
FROM [data_in].[org_emp] o 
  left join details d on o.id = d.employee_id
  left join IsLineManager m on o.id = m.line_manager_id
  left join IsFunctionalmanager f on o.id = f.functional_manager_id
  left join IsDelegate i on o.id = i.EMPEE_ID
  where id>0 and technical_account_ind=0;
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_employees] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_employees] TO [data_out_ad_alter_all]
    AS [dbo];
GO

