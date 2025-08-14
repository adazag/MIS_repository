
CREATE   view [data_out_cornerstone].[sulu_cornerstone_employee] as
select e.id                             as 'User ID',
       e.first_name                     as 'First Name',
       e.last_name                      as 'Last Name',
       emp.line_manager_id              as 'Manager',
       e.email                          as 'Email',
       case e.gender_code
           when 'F' then 'Female'
           when 'M' then 'Male'
           when null
               then 'Not Specified' end as 'Gender',
       e.phone_number                      'Mobile',
       'Employee'                       as 'User Type',
       case
           when (e.active_ind = 0)
               then 'Terminated'
           else 'Working'
           end                          as 'Employment Status',

       emp.org_unit_id                  as 'Division',
       emp.position_id                  as 'Position',
       case le.id
           when '1' then '1'
           when '2' then '1'
           when '3' then '1'
           when '4' then '2'
           when '5' then '3'
           when '6' then '1'
           when '7' then '4'
           when '8' then '5'
           when '9' then '6'
           when '10' then '3'
           when '11' then '4'
           when '12' then '7'
           end                          as 'Location',
       e.functional_manager_id          as 'Dotted Line Manager/Indirect Manager',
       le.id                            as 'Legal Entity',
       case
           when (e.project_manager_ind is not null)
               then e.project_manager_ind
           else cast(0 as BIT)
           end                          as 'Is Project Manager',
       emp.contract_termination_date    as 'Termination Date',
       e.team_leader_ind                as 'Is Line Manager',
       e.team_owner_ind                 as 'Is Team Owner',
       iif((e.service_level_manager_ind is not null), e.service_level_manager_ind,
           cast(0 as BIT))              as 'Is Service Level Manager',
       iif((e.management_community_member_ind is not null), e.management_community_member_ind,
           cast(0 as BIT))              as 'Is MC Member',
       emp.employment_date              as 'First Employment Date',
       emp.bu_id                        as 'BU ID',
       emp.sub_bu_id                    as 'Sub BU ID'
from [data_in].[org_emp] e
         left join [data_in].[org_emp_vw] emp on emp.id = e.id
         left join [data_in].[org_legal_entity] le on emp.legal_entity = le.name
where (e.non_employee_ind = 0 and e.technical_account_ind = 0 and (e.external_ind is null or e.external_ind = 0))
    OR (e.external_ind = 1 AND e.external_type_id = 1);
GO

GRANT SELECT
    ON OBJECT::[data_out_cornerstone].[sulu_cornerstone_employee] TO [cornerstone-integration]
    AS [grzegorz.pawelec@lingarogroup.com];
GO

