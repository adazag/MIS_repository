

CREATE VIEW [data_out_leap].[v_BusinessUnits]
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

