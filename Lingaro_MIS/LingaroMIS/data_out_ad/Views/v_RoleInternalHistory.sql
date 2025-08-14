



CREATE View [data_out_ad].[v_RoleInternalHistory] as

SELECT 
	rolesHistory.[id] as [ChangeId],
	rolesHistory.[employee_id] as [EmployeeId],
	rolesHistory.[role_name] as [RoleName],
	rolesHistory.[start_date] as [StartDate],
	rolesHistory.[end_date] as [EndDate],

	IIF(
		rolesHistory.[start_date] < CAST( GETDATE() AS Date ) AND rolesHistory.[end_date] < CAST( GETDATE() AS Date ),
		CAST(1 as bit),
		CAST(0 as bit)
	) as [IsPast],

	IIF(
		rolesHistory.[start_date] <= CAST( GETDATE() AS Date ) AND rolesHistory.[end_date] IS NULL,
		CAST(1 as bit),
		CAST(0 as bit)
	) as [IsCurrent],
	
	IIF(
		rolesHistory.[start_date] > CAST( GETDATE() AS Date ),
		CAST(1 as bit),
		CAST(0 as bit)
	) as [IsFuture]

FROM [data_out_ad].[dic_roles_history] rolesHistory
WHERE rolesHistory.[employee_id] > 0
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_RoleInternalHistory] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_RoleInternalHistory] TO [data_out_ad_read_all]
    AS [dbo];
GO

