CREATE   VIEW [data_mis].[org_location_calendar] AS 
SELECT a.[id]
      ,[location_id]
	  ,b.name as location_name
      ,[calendar_id]
	  ,c.name as calendar_name 
FROM [data_in].[org_location_calendar] a
left join [data_in].[org_country] b on a.location_id=b.id
left join [data_in].[org_calendar] c on a.calendar_id=c.id
;
GO

