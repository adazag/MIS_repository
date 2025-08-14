
CREATE view [data_mis_project].[competency_report]

as

with potentialRole as 
(
SELECT 
	a.employee_id
	,a.competency_role_id
	,b.name
FROM data_in.employee_competency_role a 
LEFT JOIN data_in.role b ON b.id = a.competency_role_id
WHERE a.preference = 'POTENTIAL'
),

/*New taxonomy role potential (in single row)*/ 
connect_potential_role AS

(
SELECT DISTINCT 
employee_id, STUFF
                     ((SELECT ', ' + name
                      FROM    potentialRole a
                      WHERE a.employee_id = b.employee_id FOR XML PATH('')), 1, 1, '') AS Potential_Role
FROM    potentialRole b), 
	
/*New taxonomy role main*/ 

main_role_new_taxonomy AS
(
SELECT 
	employee_id
	,name AS Main_Role
FROM    data_in.employee_competency_role a 
LEFT JOIN data_in.role b ON b.id = a.competency_role_id
WHERE preference = 'MAIN'), 
	
all_employee AS
(
SELECT 
	c.[id] AS [Employee ID]
	,c.[first_name] AS [First Name]
	,c.[last_name] AS [Last Name]
	,x.role AS [Role]
	,Potential_Role
	,x.role_name as Main_Role
	,position AS Position
	,competency_name AS Competency_name
	,c.project_manager_ind AS [Is Project Manager]
	,c.management_community_member_ind
	,c.team_leader_ind
	,c.team_owner_ind

FROM    [data_in].[org_emp] c 
LEFT JOIN connect_potential_role z ON z.employee_id = c.id 
LEFT JOIN main_role_new_taxonomy y ON y.employee_id = c.id
LEFT JOIN data_in.org_emp_vw x ON x.id = c.id
WHERE c.id IS NOT NULL 
--AND c.project_manager_ind = 1 
AND c.active_ind = 1

)


SELECT * FROM    all_employee
--where [Employee ID] IN ('223338','251332')
GO

GRANT SELECT
    ON OBJECT::[data_mis_project].[competency_report] TO [data_mis_project_competency_report_read_all]
    AS [dbo];
GO

