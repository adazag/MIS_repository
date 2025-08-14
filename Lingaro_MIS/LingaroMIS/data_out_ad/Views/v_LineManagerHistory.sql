
create view [data_out_ad].[v_LineManagerHistory] as
select 
	t1.employee_id [EmployeeId],
	t1.line_manager_id [LineManagerId],
	t1.[start_date] as [StartDate],
	t1.[end_date] as [EndDate],

	IIF(
		t1.[start_date] < CAST( GETDATE() AS Date ) AND t1.[end_date] < CAST( GETDATE() AS Date ),
		CAST(1 as bit),
		CAST(0 as bit)
	) as [IsPast],

	IIF(
		t1.[start_date] <= CAST( GETDATE() AS Date ) AND t1.[end_date] IS NULL,
		CAST(1 as bit),
		CAST(0 as bit)
	) as [IsCurrent],
	
	IIF(
		t1.[start_date] > CAST( GETDATE() AS Date ),
		CAST(1 as bit),
		CAST(0 as bit)
	) as [IsFuture]

from data_out_ad.dic_line_managers_history t1
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_LineManagerHistory] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_LineManagerHistory] TO [data_out_ad_alter_all]
    AS [dbo];
GO

