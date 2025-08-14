




/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [data_out_ad].[v_Az_Employees_Roles] as
SELECT t1.[EmployeeId]
      ,t1.[IsMCMember]
      ,t1.[IsTeamOwner]
      ,t1.[IsTeamLeader]
	  ,t1.[IsProjectManager]
	  ,t1.[IsServiceLevelManager]
      ,t1.[IsExternal]
	  ,CONCAT(
			 'MCM=' + CAST(t1.[IsMCMember] as varchar(1)) + ';'
			,'TO=' + CAST(t1.[IsTeamOwner] as varchar(1)) + ';'
			,'TL=' + CAST(t1.[IsTeamLeader] as varchar(1)) + ';'
			,'PM=' + CAST(t1.[IsProjectManager] as varchar(1)) + ';'
			,'SLM=' + CAST(t1.[IsServiceLevelManager] as varchar(1)) + ';'
		) as AzADRoleString
	   ,t2.FullName
       ,t2.Email
       ,t2.AzADObjectId
	   ,t2.IsActive
  FROM [data_out_ad].[emp_roles_attributes] t1 LEFT OUTER JOIN data_out_ad.v_az_employees t2
                    ON t1.[EmployeeId] = t2.employeeid
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Employees_Roles] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Employees_Roles] TO [data_out_ad_read_all]
    AS [dbo];
GO

