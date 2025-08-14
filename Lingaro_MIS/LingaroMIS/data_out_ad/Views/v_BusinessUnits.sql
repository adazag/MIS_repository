
CREATE VIEW [data_out_ad].[v_BusinessUnits]
AS
SELECT   
	bu.BusinessUnitId,
	bu.BusinessUnitName,
	bu.ParentId,
	bu_parent.BusinessUnitName AS ParentName,
	IIF(
		(bu.[start_date] <= CAST( GETDATE() AS Date) AND bu.[end_date] > CAST( GETDATE() AS Date)) OR
		(bu.[start_date] <= CAST( GETDATE() AS Date) AND bu.[end_date]  IS NULL)
	, 1 , 0 ) as [IsActive]
FROM
	data_out_ad.dic_business_units AS bu LEFT OUTER JOIN
    data_out_ad.dic_business_units AS bu_parent ON bu.ParentId = bu_parent.BusinessUnitId
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_BusinessUnits] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_BusinessUnits] TO [data_out_ad_read_all]
    AS [dbo];
GO

EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'data_out_ad', @level1type = N'VIEW', @level1name = N'v_BusinessUnits';
GO

EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[12] 3) )"
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
         Begin Table = "bu"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 221
               Right = 226
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "bu_parent"
            Begin Extent = 
               Top = 6
               Left = 264
               Bottom = 119
               Right = 452
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
         Width = 2295
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2415
         Alias = 900
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
', @level0type = N'SCHEMA', @level0name = N'data_out_ad', @level1type = N'VIEW', @level1name = N'v_BusinessUnits';
GO

