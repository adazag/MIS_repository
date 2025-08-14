

CREATE VIEW [data_out_ad].[v_Az_Employees_ClientIDs]
AS

SELECT 
  t1.privilege_user_id AS EmployeeId, 
  String_agg(
    '<' + CAST(t1.client_id AS VARCHAR) + '>', 
    ''
  ) AS ClientIds, 
  data_out_ad.v_Az_Employees.FullName, 
  data_out_ad.v_Az_Employees.Email, 
  data_out_ad.v_Az_Employees.AzADObjectId,
  data_out_ad.v_Az_Employees.IsActive
FROM 
  (
	SELECT *
	FROM (
		SELECT *
			,ROW_NUMBER() over (PARTITION BY privilege_user_id order by client_id) as [row_number]
		FROM (
		   SELECT DISTINCT
			   privilege_user_id
			  ,client_id
			FROM 
			  data_out_ad.latest_accounts 
			WHERE 
			  (privilege_user_id > 0)
		) t_clients
	) t_clients_limitted where t_clients_limitted.[row_number] <= 87 
  ) AS t1 
  LEFT OUTER JOIN data_out_ad.v_Az_Employees ON t1.privilege_user_id = data_out_ad.v_Az_Employees.EmployeeId 
GROUP BY 
  t1.privilege_user_id, 
  data_out_ad.v_Az_Employees.FullName, 
  data_out_ad.v_Az_Employees.Email, 
  data_out_ad.v_Az_Employees.AzADObjectId,
  data_out_ad.v_Az_Employees.IsActive
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Employees_ClientIDs] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Employees_ClientIDs] TO [data_out_ad_read_all]
    AS [dbo];
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
         Begin Table = "t1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 287
               Right = 230
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "v_Az_Employees (data_out_ad)"
            Begin Extent = 
               Top = 6
               Left = 268
               Bottom = 251
               Right = 454
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
         Width = 2160
         Width = 2070
         Width = 3105
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 2190
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
', @level0type = N'SCHEMA', @level0name = N'data_out_ad', @level1type = N'VIEW', @level1name = N'v_Az_Employees_ClientIDs';
GO

EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'data_out_ad', @level1type = N'VIEW', @level1name = N'v_Az_Employees_ClientIDs';
GO

