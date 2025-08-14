



CREATE PROCEDURE [rls].[update_pm_del] AS

IF OBJECT_ID('[rls].[pm_del]', 'U') IS NOT NULL TRUNCATE TABLE [rls].[pm_del];

WITH project_delegates AS (
SELECT
      project_id as project_id
      ,delegate_employee_id as employee_id
	  ,'delegates' as type
	  ,e.email
	  ,e.employee_full_name
FROM [data_in].proj_permission p
LEFT JOIN [data_mis].[org_emp] e ON p.delegate_employee_id = e.id
where 1=1 
AND (end_date > GETDATE() or end_date is null) 
AND e.active_ind = 1
--AND project_id = 7947
),

project_managers AS (
SELECT 
	   [project_id] as project_id
      ,[manager_id] as employee_id
	  ,'project_manager' as type
	  ,e.email
	  ,e.employee_full_name
FROM [data_in].[proj] p -- PM
LEFT JOIN [data_mis].[org_emp] e ON p.manager_id = e.id
WHERE 1=1 
AND e.active_ind = 1
),

engagement_managers AS (
SELECT 
	   [project_id] as project_id
      ,[manager_id] as employee_id
	  ,'engagement_manager' as type
	  ,e.email
	  ,e.employee_full_name
FROM [data_in].[proj] p -- PM
LEFT JOIN [data_mis].[org_emp] e ON p.engagement_manager_id = e.id
WHERE 1=1 
AND e.active_ind = 1
),

engagement_group_managers AS (
SELECT 
	   p.[project_id] as project_id
      ,p2.[manager_id] as employee_id
	  ,'engagement_group_manager' as type
	  ,e.email
	  ,e.employee_full_name
FROM [data_in].[proj] p -- PM
LEFT JOIN [data_in].[proj] p2 ON p.parent_project_id = p2.project_id
LEFT JOIN [data_mis].[org_emp] e ON p2.manager_id = e.id
WHERE 1=1 
AND e.active_ind = 1
--AND p.project_id = 7947
),



engagement_group_delegates AS (
SELECT 
	   p.[project_id] as project_id
      ,per.[delegate_employee_id] as employee_id
	  ,'engagement_group_delegates' as type
	  ,e.email
	  ,e.employee_full_name
FROM [data_in].[proj] p -- PM
LEFT JOIN [data_in].[proj] p2 ON p.parent_project_id = p2.project_id
LEFT JOIN [data_in].[proj_permission] per ON p2.project_id = per.project_id
LEFT JOIN [data_mis].[org_emp] e ON per.delegate_employee_id = e.id
WHERE 1=1 
AND (per.end_date > GETDATE() or per.end_date is null)
AND e.active_ind = 1
),

all_permissions AS (

SELECT * 
FROM project_delegates

UNION 

SELECT * 
FROM project_managers

UNION

SELECT * 
FROM engagement_managers

UNION

SELECT * 
FROM engagement_group_managers

UNION 

SELECT * 
FROM engagement_group_delegates
)

INSERT INTO [rls].[pm_del]
Select * 
FROM all_permissions
GO

GRANT EXECUTE
    ON OBJECT::[rls].[update_pm_del] TO [lingaro-mis-adf]
    AS [dbo];
GO

