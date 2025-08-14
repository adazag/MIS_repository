




/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [data_out_ad].[v_Az_Employees]
AS
SELECT
	t1.EmployeeId,

	t1.FirstName																AS [FirstName],
	CONVERT(VARCHAR(100), t1.FirstName COLLATE SQL_Latin1_General_CP1_CI_AS )	AS [FirstNameNormalized],
	
	t1.LastName																	AS [LastName], 
	CONVERT(VARCHAR(100), t1.LastName COLLATE SQL_Latin1_General_CP1_CI_AS )	AS [LastNameNormalized],

	t1.FirstName + ' ' + t1.LastName											AS [FullName],
	CONVERT(VARCHAR(100), t1.FirstName COLLATE SQL_Latin1_General_CP1_CI_AS ) + ' ' +
	CONVERT(VARCHAR(100), t1.LastName COLLATE SQL_Latin1_General_CP1_CI_AS )	AS [FullNameNormalized],

	t1.nationality as [Nationality],
	t1.gender as [Gender],

	TRIM(t1.phone_number)	  AS [Phone1],

	t1.IsActive, 
	
	t1.Email,
	IIF(LEN(ISNULL(restricted_info.private_email, '')) > 0, CAST(1 AS bit), CAST(0 AS bit)) AS HasPrivateEmail,
	t1.AzADObjectId, 
	t1.ADObjectId, 
	t1.ldap_login		AS [LDAPLogin],
	
	country1.[name]		AS [Addr1_CountryName],
	country1.code		AS [Addr1_CountryCode],
	city1.[name]		AS [Addr1_CityName],
	
	country2.[name]		AS [Addr2_CountryName],
	country2.code		AS [Addr2_CountryCode],

	t1.legal_entity_id			AS [LegalEntityId],
	legel_entities.name			AS [LegalEntityName],
	t1.bu_id					AS [BUID],
	org_bu.name					AS [BUName],
	t1.sub_bu_id				AS [SubBUID],
	org_sub_bu.name				AS [SubBUName],
	t1.senior_delivery_team_id	AS [SDTID],
	org_sdt.name				AS [SDTName],
	t1.delivery_team_id			AS [DTID],
	org_dt.name					AS [DTName],
	t1.org_unit_id				AS [TeamId],
	org_units.name				AS [TeamName],
	t1.position_id				AS [PositionId],
	positions.PositionName		AS [PositionName],
	t1.role_id					AS [RoleId],
	roles.name					AS [RoleName],
	TRIM(t1.role_internal)		AS [RoleInternal],

	IIF(t1.line_manager_id = t1.EmployeeId, NULL, t1.line_manager_id) AS LineManagerId,
	t1.functional_manager_id AS FunctionalManagerId,

	t1.IsFunctionalmanager,
	t1.IsLineManager,
	t1.IsPM,
	IIF( ou_leaders.[ORG_UNIT_LEADER_ID] IS NULL,
		CAST(0 AS bit),
		CAST(1 AS bit))																				as [IsEPM],
	t1.IsDelegate,



	/*
		Long-term Leave
	*/
	IIF( 
		GETDATE() >= CAST(t1.LongTermLeaveStart AS DATE) AND 
		GETDATE() <= CAST(t1.LongTermLeaveEnd AS DATE),
		CAST(1 AS bit),
		CAST(0 AS bit)
	)																								as [IsLongTermLeave],

	-- Days until LTL start (negative = already started, NULL if >30 days ago or LTL already ended)
	CASE 
		--WHEN DATEDIFF(DAY, GETDATE(), t1.LongTermLeaveStart) < -30 THEN NULL
		WHEN GETDATE() > t1.LongTermLeaveEnd THEN NULL
		ELSE DATEDIFF(DAY, GETDATE(), t1.LongTermLeaveStart)
	END																								AS [LTLStartInDays],

	-- Days until LTL end (negative = already ended, NULL if ended >30 days ago)
	CASE
		WHEN DATEDIFF(DAY, t1.LongTermLeaveEnd, GETDATE()) > 30 THEN NULL
		ELSE DATEDIFF(DAY, GETDATE(), t1.LongTermLeaveEnd)
	END																								AS [LTLEndInDays],

	-- PreLongLeave: from 30 days before start until 5 days after
	IIF(
		DATEDIFF(DAY, GETDATE(), t1.LongTermLeaveStart) BETWEEN -5 AND 30,
		CAST(1 AS BIT),
		CAST(0 AS BIT)
	)																								AS [IsPreLTL],

	-- PreReturn: within 30 days before LTL end
	IIF(
		DATEDIFF(DAY, GETDATE(), t1.LongTermLeaveEnd) BETWEEN 0 AND 30,
		CAST(1 AS BIT),
		CAST(0 AS BIT)
	)																								AS [IsPreLTLReturn],

	t1.LongTermLeaveStart																			AS [LongTermLeaveStart],
	t1.LongTermLeaveEnd																				AS [LongTermLeaveEnd],
	t1.long_term_leave_modified_at																	AS [LongTermLeaveModifiedOn],


	-- LEAVER
	t1.IsLeaver																						as [IsLeaver],
	t1.leaver_ind_modified_at																		as [IsLeaverModifiedOn],
	
	IIF(t1.IsLeaver = 1, ISNULL(t1.LastDayOfWork,t1.contract_termination_date), NULL)				as [LeaveDate],

	IIF(t1.IsLeaver = 1, 
		DATEDIFF(D, GETDATE(), ISNULL(t1.LastDayOfWork,t1.contract_termination_date)), 
		NULL)																						as [LeaveInDays],

	IIF(t1.IsLeaver = 1, ISNULL(t1.LastDayOfWork,t1.contract_termination_date), NULL)				as [EndDate],

	IIF(t1.IsLeaver = 1, 
		DATEDIFF(D, GETDATE(), ISNULL(t1.LastDayOfWork, t1.contract_termination_date)), 
		NULL)																						as [EndInDays],
	
	IIF(t1.IsLeaver = 1 AND DATEDIFF(D, GETDATE(), ISNULL(t1.LastDayOfWork,t1.contract_termination_date)) > 0, 
		CAST(1 AS bit), 
		CAST(0 AS bit))																				as [PreOffBoard],
	
	IIF(t1.IsLeaver = 1 AND DATEDIFF(D, GETDATE(), ISNULL(t1.LastDayOfWork,t1.contract_termination_date)) = 0, 
		CAST(1 AS bit), 
		CAST(0 AS bit))																				as [OffBoard],
	
	IIF(t1.IsLeaver = 1 AND DATEDIFF(D, GETDATE(), ISNULL(t1.LastDayOfWork,t1.contract_termination_date)) BETWEEN -90 AND -1, 
		CAST(1 AS bit), 
		CAST(0 AS bit))																				as [PostOffBoard],


	-- JOINER
	IIF( t1.IsLeaver != 1 AND DATEDIFF(D,GETDATE(), ISNULL(t1.first_day_of_work, t1.employment_date)) >= -90,
		CAST(1 AS bit),
		CAST(0 AS bit))																				as [IsJoiner],

	ISNULL(t1.first_day_of_work, t1.employment_date)												as [JoinDate],

	IIF(t1.IsLeaver != 1, 
		DATEDIFF(D, GETDATE(), ISNULL(t1.first_day_of_work, t1.employment_date)), 
		NULL)																						as [JoinInDays],

	ISNULL(t1.first_day_of_work, t1.employment_date)												as [StartDate],

	IIF(t1.IsLeaver != 1, 
		DATEDIFF(D, GETDATE(), ISNULL(t1.first_day_of_work, t1.employment_date)), 
		NULL)																						as [StartInDays],

	IIF(t1.IsLeaver != 1 AND DATEDIFF(D, GETDATE(), ISNULL(t1.first_day_of_work, t1.employment_date)) > 0,
		CAST(1 AS bit), 
		CAST(0 AS bit))																				as [PreOnBoard],

	IIF(t1.IsLeaver != 1 AND DATEDIFF(D, GETDATE(), ISNULL(t1.first_day_of_work, t1.employment_date)) = 0, 
		CAST(1 AS bit), 
		CAST(0 AS bit))																				as [OnBoard],

	IIF(t1.IsLeaver != 1 AND DATEDIFF(D, GETDATE(), ISNULL(t1.first_day_of_work, t1.employment_date)) BETWEEN -90 AND -1,
		CAST(1 AS bit), 
		CAST(0 AS bit))																				as [PostOnBoard],


	-- CONTRACT
	CAST(t1.create_ip_ind AS bit) as IsIPCreator,
	t1.employment_date AS ContractStartDate,
	t1.contract_termination_date as ContractExpirationDate,
	t1.contract_type as ContractType,
	contract_types.ContractTypeId as [ContractTypeId],
	contract_types.ContractTypeCode as [ContractTypeCode],

	t1.modified_at AS ModifiedDate,
	t1.creation_at AS CreatedDate

FROM

			  [data_out_ad].dic_employees t1 
	left join [data_mis].[org_country] country1 on t1.country_id = country1.id 
	left join [data_mis].[org_country] country2 on t1.country_work_location_id = country2.id 
	left join [data_mis].[org_city] city1 on t1.city_id = city1.id 
	left join [data_out_ad].[dic_positions] positions on t1.position_id = positions.PositionId 
	left join [data_mis].[role] roles on t1.role_id = roles.id 
	left join [data_out_ad].[dic_org_structure] org_bu on t1.bu_id = org_bu.id -- and org_bu.[type] in ('OH','BU') 
	left join [data_out_ad].[dic_org_structure] org_sub_bu on t1.sub_bu_id = org_sub_bu.id 
	left join [data_out_ad].[dic_org_structure] org_sdt on t1.senior_delivery_team_id = org_sdt.id and org_sdt.[type] = 'SDT' 
	left join [data_out_ad].[dic_org_structure] org_dt on t1.delivery_team_id = org_dt.id and org_dt.[type] = 'DT' 
	left join [data_out_ad].[dic_org_structure] org_teams on t1.team_id = org_teams.id and org_teams.[type] = 'CT' 
	left join [data_out_ad].[dic_org_structure] org_units on t1.org_unit_id = org_units.id 
	left join [data_mis].[sulu_le_lkp] legel_entities on t1.legal_entity_id = legel_entities.id 
	left join [data_out_ad].[dic_contract_types] contract_types on t1.ContractTypeId = contract_types.ContractTypeId
	left join (
		select DISTINCT LEADER_ID ORG_UNIT_LEADER_ID from [data_mis].[org_structure_new] where organization_name = 'ADM'
	) ou_leaders on t1.EmployeeId = ou_leaders.ORG_UNIT_LEADER_ID
	LEFT JOIN [data_out_ad].[v_Employee_restricted_info] restricted_info ON t1.EmployeeId = restricted_info.employee_id
	
WHERE
	(t1.EmployeeId IS NOT NULL) AND 
	(t1.EmployeeId > 0) AND 
	(t1.FirstName IS NOT NULL) AND 
	(t1.LastName IS NOT NULL) AND 
	(t1.Email IS NOT NULL)
GO

EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'data_out_ad', @level1type = N'VIEW', @level1name = N'v_Az_Employees';
GO

EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[25] 4[36] 2[20] 3) )"
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
         Top = -192
         Left = 0
      End
      Begin Tables = 
         Begin Table = "dic_employees (data_out_ad)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 382
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 2
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
         Column = 1440
         Alias = 2700
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
', @level0type = N'SCHEMA', @level0name = N'data_out_ad', @level1type = N'VIEW', @level1name = N'v_Az_Employees';
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Employees] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Employees] TO [HR365@lingaro.onmicrosoft.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Az_Employees] TO [data_out_ad_alter_all]
    AS [dbo];
GO

