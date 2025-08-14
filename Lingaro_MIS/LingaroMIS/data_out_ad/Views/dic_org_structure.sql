create view data_out_ad.dic_org_structure as(
SELECT [id]
      ,[name]
      ,[parent_id]
      ,[start_date]
      ,[end_date]
      ,[unit_level]
      ,[type]
      --,[leader_id]
      --,[dc_ind]
      --,[area]
      --,[team_level] 

  FROM [data_in].[org_unit]
 )
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_org_structure] TO [data_out_ad_alter_all]
    AS [dbo];
GO

GRANT SELECT
    ON OBJECT::[data_out_ad].[dic_org_structure] TO [data_out_ad_read_all]
    AS [dbo];
GO

