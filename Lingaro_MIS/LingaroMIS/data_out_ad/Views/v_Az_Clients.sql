CREATE VIEW data_out_ad.v_Az_Clients
AS
SELECT   data_out_ad.dic_clients.ClientId, data_out_ad.dic_clients.ClientName, data_out_ad.dic_clients.AccountManager AS AccountManager_EmployeeId, 
                         data_out_ad.dic_employees.AzADObjectId AS AccountManager_AzADObjectId, data_out_ad.dic_employees.Email AS AccountManager_Email, 
                         data_out_ad.dic_clients.SALESFORCE_ID AS SalesforceId
FROM         data_out_ad.dic_clients LEFT OUTER JOIN
                         data_out_ad.dic_employees ON data_out_ad.dic_clients.AccountManager = data_out_ad.dic_employees.EmployeeId
GO

EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "dic_clients (data_out_ad)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 216
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dic_employees (data_out_ad)"
            Begin Extent = 
               Top = 11
               Left = 467
               Bottom = 224
               Right = 637
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 2265
         Width = 4995
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2160
         Alias = 3765
         Table = 2745
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
', @level0type = N'SCHEMA', @level0name = N'data_out_ad', @level1type = N'VIEW', @level1name = N'v_Az_Clients';
GO

EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'data_out_ad', @level1type = N'VIEW', @level1name = N'v_Az_Clients';
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Clients] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Clients] TO [data_out_ad_alter_all]
    AS [dbo];
GO

