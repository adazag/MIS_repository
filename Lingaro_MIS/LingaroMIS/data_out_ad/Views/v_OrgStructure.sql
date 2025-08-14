

CREATE VIEW [data_out_ad].[v_OrgStructure] AS 
SELECT 
	   [id]			AS [Id]
      ,[name]		AS [Name]
      ,[parent_id]	AS [ParentId]
      ,[start_date] AS [StartDate]
      ,[end_date]	AS [EndDate]
      ,[unit_level]	AS [Level]
      ,[type]		AS [TypeCode]
	  ,CASE
			WHEN ([end_date] IS NULL OR [end_date] >= GETDATE()) THEN 1
			ELSE 0
		END			AS [IsActive]
  FROM [data_out_ad].[dic_org_structure]
  WHERE 
	--([end_date] IS NULL OR [end_date] >= GETDATE()) AND
	--[parent_id] not in ( SELECT [id] FROM [data_out_ad].[dic_org_structure] WHERE [end_date] < GETDATE()) OR
	--[parent_id] IS NULL
	[unit_level] IS NOT NULL
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_OrgStructure] TO [HR365@lingaro.onmicrosoft.com]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_OrgStructure] TO [data_out_ad_read_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[v_OrgStructure] TO [data_out_ad_alter_all]
    AS [dbo];
GO

