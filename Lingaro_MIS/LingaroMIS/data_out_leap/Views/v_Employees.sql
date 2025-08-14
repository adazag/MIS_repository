





/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [data_out_leap].[v_Employees]
AS
SELECT
	t1.EmployeeId,

	t1.FirstName																AS [FirstName],
	
	t1.LastName																	AS [LastName],

	t1.FirstName + ' ' + t1.LastName											AS [FullName],


	t1.IsActive, 
	
	t1.Email,
	t1.AzADObjectId, 
	
	country1.[name]		AS [Addr1_CountryName],
	country1.code		AS [Addr1_CountryCode],
	city1.[name]		AS [Addr1_CityName],
	
	country2.[name]		AS [Addr2_CountryName],
	country2.code		AS [Addr2_CountryCode],

	t1.legal_entity_id			AS [LegalEntityId],
	legel_entities.name			AS [LegalEntityName],
	t1.bu_id					AS [BUID],
	org_bu.name					AS [BUName],
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


	-- LEAVER
	t1.IsLeaver																						as [IsLeaver],

	-- JOINER
	ISNULL(t1.first_day_of_work, t1.employment_date)												as [StartDate],


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
	
WHERE
	(t1.EmployeeId IS NOT NULL) AND 
	(t1.EmployeeId > 0) AND 
	(t1.FirstName IS NOT NULL) AND 
	(t1.LastName IS NOT NULL) AND 
	(t1.Email IS NOT NULL)
GO

