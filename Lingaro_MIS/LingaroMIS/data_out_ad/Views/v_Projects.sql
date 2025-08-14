

CREATE VIEW [data_out_ad].[v_Projects]
AS
SELECT 
  prj.ProjectId, 
  prj.ProjectName, 
  prj.CreatedDate,
  prj.ChangeDate,
  prj.StartDate, 
  prj.EndDate,
  
  prjStatus.StateCode as [StatusCode],
  prjStatus.StatusCode  as [SULUStatusCode],
  prjStatus.StatusTest   as [SULUStatusName],
  ~prjStatus.StateCode   as [DVStateCode],
  

  employees.AzADObjectId as [PM_AzADObjectId],
  employees.Email as [PM_Email], 
  employees.IsActive as [PM_IsActive], 
  employees.EmployeeId as [PM_EmployeeId], 
  CONCAT(employees.FirstName, ' ', employees.LastName) as [PM_FullName],
  prjLeaders.ORG_UNIT_LEADER_ID as [DL_EmployeeId],
  prjLeaders.az_ad_object_id as [DL_AzADObjectId],
  prj.SharepointLink as [SPOUrl],
  prj.SharepointGroupId as [M365GroupId]
FROM 
  data_out_ad.dic_projects prj

  LEFT JOIN data_out_ad.dic_project_members prjMembers 
     ON prj.ProjectId = prjMembers.ProjectId  AND prjMembers.Role = 'PROJECT_MANAGER'
  
  INNER JOIN data_out_ad.dic_employees employees
     ON employees.EmployeeId = prjMembers.EmployeeId
  
  LEFT JOIN data_out_ad.dic_project_status prjStatus 
     ON prj.Status = prjStatus.SULUStatus
  
  LEFT OUTER JOIN data_out_ad.proj_org_leader prjLeaders
     ON prj.ProjectId = prjLeaders.PROJ_ID
  
WHERE
  prj.ProjectId > 7
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Projects] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Projects] TO [data_out_ad_alter_all]
    AS [dbo];
GO

EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[26] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "dic_projects (data_out_ad)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 190
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dic_project_members (data_out_ad)"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 187
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dic_employees (data_out_ad)"
            Begin Extent = 
               Top = 21
               Left = 544
               Bottom = 234
               Right = 714
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1590
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'data_out_ad', @level1type = N'VIEW', @level1name = N'v_Projects';
GO

EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'data_out_ad', @level1type = N'VIEW', @level1name = N'v_Projects';
GO

