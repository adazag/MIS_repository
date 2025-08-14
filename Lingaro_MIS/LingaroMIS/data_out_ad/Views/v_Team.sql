








/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [data_out_ad].[v_Team] as
SELECT 
	[id] as [Id]
   ,[name] as [Name]
   ,[start_date] as [StartDate]
   ,[end_date] as [EndDate]
   ,IIF(
		([start_date] <= CAST( GETDATE() AS Date) AND [end_date] > CAST( GETDATE() AS Date)) OR
		([start_date] <= CAST( GETDATE() AS Date) AND [end_date]  IS NULL)
	, 1 , 0 ) as [IsActive]
	,[type] as [Type]
	,[parent_id]	AS [ParentId]
FROM [data_out_ad].[dic_org_structure] 
WHERE 
	Id IN (SELECT DISTINCT org_unit_id from [data_out_ad].[dic_employees])
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Team] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Team] TO [HR365@lingaro.onmicrosoft.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_Team] TO [data_out_ad_read_all]
    AS [dbo];
GO

