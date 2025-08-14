
CREATE view [data_mis_project].[ad_emp_roles_attributes] as
(
SELECT  [EmployeeId]
      ,[IsMCMember]
      ,[IsTeamOwner]
      ,[IsTeamLeader]
      ,[IsActive]
      ,[IsExternal]
      ,[IsProjectManager]
      ,[az_ad_object_id]
      ,[IsServiceLevelManager]  FROM [data_out_ad].[emp_roles_attributes])
GO

