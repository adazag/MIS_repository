create view [data_out_ad].[emp_roles_attributes] as (
SELECT id as EmployeeId
      ,management_community_member_ind as IsMCMember
      ,team_owner_ind as IsTeamOwner
      ,team_leader_ind IsTeamLeader
      ,active_ind as IsActive
      ,non_employee_ind IsExternal
	  ,CASE
                 WHEN (project_manager_ind IS NOT NULL)
                 THEN project_manager_ind
                 ELSE 0
                 END AS 'IsProjectManager'
	,az_ad_object_id
	,CASE
            WHEN (service_level_manager_ind IS NOT NULL)
            THEN service_level_manager_ind
            ELSE 0
            END AS 'IsServiceLevelManager'
FROM [data_in].[org_emp] e)
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[emp_roles_attributes] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[emp_roles_attributes] TO [data_out_ad_read_all]
    AS [dbo];
GO

