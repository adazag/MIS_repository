
CREATE view  [data_out_manila_apps].[sulu_org_mem] as

with employee_bookings as
(

SELECT DISTINCT
b.employee_id
,e.employee_full_name
,b.project_id
,b.project_name
--,b.month_name
FROM [data_in].[proj_booking_monthly_vw] b
LEFT JOIN [data_in].[org_emp_vw] e ON b.employee_id = e.id
where b.project_id > 9 and legal_entity = 'Lingaro (Philippines)' --and employee_id IN ('1200','173176')
),

projects as
(
SELECT 
	e.employee_id
	,e.employee_full_name as employee_name
	,o.leader_id
	,em.employee_full_name as leader_name
	,p.organization_unit_name
	,p.project_id as proj_id
	,p.project_name as proj_name
   ,p.proj_manager_id as proj_owner_id
   ,p.proj_manager_name as proj_owner_name
   ,p.status_code
   --,p.project_billable_ind
   --,p.governance_ind
   --,p.investment_ind
FROM employee_bookings e
LEFT JOIN data_mis.proj p ON e.project_id = p.project_id
left join [data_mis].[org_structure_new] o on p.organization_unit_id = o.org_unit_id
LEFT JOIN [data_mis].[org_emp] em ON o.leader_id = em.id
)
 
select *
from projects
GO

