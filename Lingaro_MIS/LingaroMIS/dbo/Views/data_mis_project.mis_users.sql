-- =============================================
-- Author:        Hanna Teszbir
-- Create date:   2025-02-03
-- Description:   View of MIS database users
-- =============================================
CREATE view "data_mis_project.mis_users" as 

with 

-- select list of employees

employees as (
select	
id,
email,
org_unit_id,
bu_name,
role,
position,
active_ind
from data_in.org_emp_vw
where id>0 and email like '%@lingarogroup%'),

mis_users as (
select name 
from sys.sysusers
where name like '%@lingarogroup%'
),

employees_users_MIS as(
select 
id,
email,
org_unit_id,
bu_name,
role,
position,
active_ind,
name
from employees a
left join mis_users b on a.email=b.name)

select * from  employees_users_MIS
where active_ind=1
GO

